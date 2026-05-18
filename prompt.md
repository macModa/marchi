Maintenant je vois tout clairement. Il y a **2 problèmes** :

---

## Problème 1 — Mauvaise route appelée

`OrderController` appelle `/api/orders/1/pdf` mais le vrai endpoint est dans `BonLivraisonController` :

```
GET /api/v1/delivery/bon-livraison/{orderId}
```

## Problème 2 — Cet endpoint retourne du JSON, pas un PDF

`BonLivraisonController` retourne un `BonLivraisonDTO` (JSON) — il faut un **2ème endpoint** qui génère le PDF depuis ce DTO.

---

## Test immédiat — vérifier que le JSON fonctionne

```powershell
# Tester la vraie route existante (retourne JSON)
$bon = Invoke-RestMethod `
    -Uri "$baseUrl/api/v1/delivery/bon-livraison/1" `
    -Method GET `
    -Headers @{ Authorization = "Bearer $token" }

$bon | ConvertTo-Json -Depth 10
```

---

## Fix complet — Ajouter l'endpoint PDF

Ajoute dans `BonLivraisonController.java` :

```java
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import java.io.ByteArrayOutputStream;
import java.awt.Color;

@GetMapping("/{orderId}/pdf")
@PreAuthorize("hasAnyRole('ADMIN', 'ARTISAN')")
public ResponseEntity<byte[]> getBonLivraisonPdf(@PathVariable Long orderId) {
    BonLivraisonDTO dto = bonLivraisonService.getBonLivraison(orderId);

    try {
        byte[] pdf = generatePdf(dto);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"bon_livraison_" + orderId + ".pdf\"")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    } catch (Exception e) {
        logger.error("Erreur génération PDF commande {}", orderId, e);
        return ResponseEntity.internalServerError().build();
    }
}

private byte[] generatePdf(BonLivraisonDTO dto) throws Exception {
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    Document doc = new Document(PageSize.A4, 40, 40, 60, 40);
    PdfWriter writer = PdfWriter.getInstance(doc, baos);
    doc.open();

    // ── Fonts ──────────────────────────────────────────────────────
    Font fontTitle  = new Font(Font.HELVETICA, 18, Font.BOLD, Color.WHITE);
    Font fontBold   = new Font(Font.HELVETICA, 10, Font.BOLD);
    Font fontNormal = new Font(Font.HELVETICA, 10, Font.NORMAL);
    Font fontSmall  = new Font(Font.HELVETICA, 8,  Font.NORMAL, Color.GRAY);

    // ── Header ─────────────────────────────────────────────────────
    PdfPTable header = new PdfPTable(2);
    header.setWidthPercentage(100);
    header.setWidths(new float[]{3, 1});

    PdfPCell titleCell = new PdfPCell(new Phrase("BON DE LIVRAISON", fontTitle));
    titleCell.setBackgroundColor(new Color(139, 90, 43)); // marron
    titleCell.setPadding(12);
    titleCell.setBorder(Rectangle.NO_BORDER);
    header.addCell(titleCell);

    PdfPCell orderCell = new PdfPCell();
    orderCell.addElement(new Phrase("Commande #" + dto.getOrderId(), fontBold));
    orderCell.addElement(new Phrase("Suivi: " + dto.getNumeroSuivi(), fontNormal));
    orderCell.addElement(new Phrase("Date: " + dto.getDateCreation().substring(0, 10), fontNormal));
    orderCell.addElement(new Phrase("Statut: " + dto.getStatut(), fontNormal));
    orderCell.setPadding(10);
    orderCell.setBorder(Rectangle.NO_BORDER);
    orderCell.setBackgroundColor(new Color(245, 245, 245));
    header.addCell(orderCell);

    doc.add(header);
    doc.add(Chunk.NEWLINE);

    // ── Expéditeur / Destinataire ───────────────────────────────────
    PdfPTable parties = new PdfPTable(2);
    parties.setWidthPercentage(100);
    parties.setSpacingBefore(8);

    // Expéditeur
    PdfPCell expCell = new PdfPCell();
    expCell.addElement(new Phrase("EXPÉDITEUR", fontBold));
    expCell.addElement(new Phrase(dto.getExpéditeur().getNomBoutique(), fontNormal));
    expCell.addElement(new Phrase(dto.getExpéditeur().getNom(), fontNormal));
    expCell.addElement(new Phrase("Ville: " + dto.getExpéditeur().getVille(), fontNormal));
    expCell.addElement(new Phrase("Tél: " + dto.getExpéditeur().getTelephone(), fontNormal));
    expCell.setPadding(10);
    expCell.setBackgroundColor(new Color(252, 248, 244));
    parties.addCell(expCell);

    // Destinataire
    PdfPCell destCell = new PdfPCell();
    destCell.addElement(new Phrase("DESTINATAIRE", fontBold));
    destCell.addElement(new Phrase(dto.getDestinataire().getNom(), fontNormal));
    destCell.addElement(new Phrase(dto.getDestinataire().getAdresseLivraison(), fontNormal));
    destCell.addElement(new Phrase("CP: " + dto.getDestinataire().getCodePostal(), fontNormal));
    destCell.addElement(new Phrase("Tél: " + dto.getDestinataire().getTelephone(), fontNormal));
    destCell.setPadding(10);
    destCell.setBackgroundColor(new Color(244, 248, 252));
    parties.addCell(destCell);

    doc.add(parties);
    doc.add(Chunk.NEWLINE);

    // ── Tableau produits ────────────────────────────────────────────
    PdfPTable produits = new PdfPTable(5);
    produits.setWidthPercentage(100);
    produits.setWidths(new float[]{4, 1, 2, 1.5f, 2});
    produits.setSpacingBefore(8);

    // En-têtes
    String[] headers = {"Produit", "Qté", "Prix Unitaire", "Poids", "Sous-total"};
    for (String h : headers) {
        PdfPCell c = new PdfPCell(new Phrase(h, fontBold));
        c.setBackgroundColor(new Color(139, 90, 43));
        // Changer la couleur du texte en blanc
        c.setPhrase(new Phrase(h, new Font(Font.HELVETICA, 10, Font.BOLD, Color.WHITE)));
        c.setPadding(6);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        produits.addCell(c);
    }

    // Lignes produits
    boolean alt = false;
    for (BonLivraisonDTO.ProduitDTO p : dto.getProduits()) {
        Color bg = alt ? new Color(249, 245, 241) : Color.WHITE;
        addProductCell(produits, p.getNom(), fontNormal, bg, Element.ALIGN_LEFT);
        addProductCell(produits, String.valueOf(p.getQuantite()), fontNormal, bg, Element.ALIGN_CENTER);
        addProductCell(produits, p.getPrixUnitaire() + " TND", fontNormal, bg, Element.ALIGN_RIGHT);
        addProductCell(produits, p.getPoidsUnitaire() + " kg", fontNormal, bg, Element.ALIGN_CENTER);
        addProductCell(produits, p.getSousTotal() + " TND", fontBold, bg, Element.ALIGN_RIGHT);
        alt = !alt;
    }
    doc.add(produits);
    doc.add(Chunk.NEWLINE);

    // ── Totaux ──────────────────────────────────────────────────────
    PdfPTable totaux = new PdfPTable(2);
    totaux.setWidthPercentage(50);
    totaux.setHorizontalAlignment(Element.ALIGN_RIGHT);

    addTotalRow(totaux, "Poids total :", dto.getPoidsTotal() + " kg", fontNormal, fontBold);
    addTotalRow(totaux, "Montant COD :", dto.getMontantCOD() + " TND", fontNormal, fontBold);
    addTotalRow(totaux, "Mode :", dto.getModeReglement(), fontNormal, fontNormal);

    doc.add(totaux);
    doc.add(Chunk.NEWLINE);

    // ── Montant en lettres ──────────────────────────────────────────
    PdfPTable lettres = new PdfPTable(1);
    lettres.setWidthPercentage(100);
    PdfPCell lettresCell = new PdfPCell(
        new Phrase("Arrêté à : " + dto.getMontantEnLettres(), fontNormal));
    lettresCell.setPadding(8);
    lettresCell.setBackgroundColor(new Color(245, 245, 245));
    lettres.addCell(lettresCell);
    doc.add(lettres);

    // ── Signatures ──────────────────────────────────────────────────
    doc.add(Chunk.NEWLINE);
    PdfPTable signs = new PdfPTable(2);
    signs.setWidthPercentage(100);
    signs.setSpacingBefore(20);

    PdfPCell signExp = new PdfPCell(new Phrase("Signature Expéditeur\n\n\n_________________", fontNormal));
    signExp.setPadding(10);
    signExp.setMinimumHeight(60);
    signs.addCell(signExp);

    PdfPCell signDest = new PdfPCell(new Phrase("Signature Destinataire\n\n\n_________________", fontNormal));
    signDest.setPadding(10);
    signs.addCell(signDest);

    doc.add(signs);

    // ── Footer ──────────────────────────────────────────────────────
    doc.add(Chunk.NEWLINE);
    Paragraph footer = new Paragraph(
        "Document généré automatiquement par Marchi Marketplace", fontSmall);
    footer.setAlignment(Element.ALIGN_CENTER);
    doc.add(footer);

    doc.close();
    return baos.toByteArray();
}

private void addProductCell(PdfPTable table, String text, Font font,
                             Color bg, int align) {
    PdfPCell cell = new PdfPCell(new Phrase(text, font));
    cell.setBackgroundColor(bg);
    cell.setPadding(5);
    cell.setHorizontalAlignment(align);
    table.addCell(cell);
}

private void addTotalRow(PdfPTable table, String label, String value,
                          Font labelFont, Font valueFont) {
    PdfPCell l = new PdfPCell(new Phrase(label, labelFont));
    l.setBorder(Rectangle.BOTTOM);
    l.setPadding(5);
    table.addCell(l);

    PdfPCell v = new PdfPCell(new Phrase(value, valueFont));
    v.setBorder(Rectangle.BOTTOM);
    v.setPadding(5);
    v.setHorizontalAlignment(Element.ALIGN_RIGHT);
    table.addCell(v);
}
```

---

## Test PowerShell après déploiement

```powershell
# Nouveau endpoint PDF
$outPath = "$env:USERPROFILE\Downloads\bon_livraison_1.pdf"

Invoke-WebRequest `
    -Uri "$baseUrl/api/v1/delivery/bon-livraison/1/pdf" `
    -Method GET `
    -Headers @{ Authorization = "Bearer $token" } `
    -OutFile $outPath

Write-Host "✅ PDF : $outPath"
Start-Process $outPath
```

---

## Aussi — corriger Flutter

Dans `api_constants.dart` :
```dart
// ❌ Avant
static String deliveryNote(int orderId) =>
    '$baseUrl/api/delivery/bon-livraison/$orderId';

// ✅ Après
static String deliveryNote(int orderId) =>
    '$baseUrl/api/v1/delivery/bon-livraison/$orderId/pdf';
```