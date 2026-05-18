import 'package:flutter/material.dart';
import 'package:marchi/core/services/pdf_service.dart';
import 'package:logger/logger.dart';

class BonLivraisonPdfButton extends StatefulWidget {
  final int orderId;
  final String authToken;
  final VoidCallback? onDownloadStart;
  final VoidCallback? onDownloadComplete;
  final Function(String error)? onError;
  final double? fontSize;
  final IconData icon;

  const BonLivraisonPdfButton({
    super.key,
    required this.orderId,
    required this.authToken,
    this.onDownloadStart,
    this.onDownloadComplete,
    this.onError,
    this.fontSize,
    this.icon = Icons.picture_as_pdf,
  });

  @override
  State<BonLivraisonPdfButton> createState() => _BonLivraisonPdfButtonState();
}

class _BonLivraisonPdfButtonState extends State<BonLivraisonPdfButton> {
  late PdfService _pdfService;
  bool _isLoading = false;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _pdfService = PdfService();
  }

  Future<void> _handleDownload() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    widget.onDownloadStart?.call();

    try {
      await _pdfService.downloadBonLivraisonPdf(
        orderId: widget.orderId,
        token: widget.authToken,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF ouvert avec succès ✅'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        widget.onDownloadComplete?.call();
      }
    } catch (e) {
      _logger.e('Erreur: $e');

      if (mounted) {
        final errorMsg = e.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $errorMsg'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        widget.onError?.call(errorMsg);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _handleDownload,
      icon: _isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
              ),
            )
          : Icon(widget.icon),
      label: Text(
        _isLoading ? 'Téléchargement...' : 'Télécharger PDF',
        style: TextStyle(fontSize: widget.fontSize),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey.shade400,
      ),
    );
  }
}

/// Widget compact pour les listes
class BonLivraisonPdfButtonCompact extends StatefulWidget {
  final int orderId;
  final String authToken;
  final double size;
  final VoidCallback? onDownloadStart;
  final VoidCallback? onDownloadComplete;

  const BonLivraisonPdfButtonCompact({
    super.key,
    required this.orderId,
    required this.authToken,
    this.size = 24,
    this.onDownloadStart,
    this.onDownloadComplete,
  });

  @override
  State<BonLivraisonPdfButtonCompact> createState() =>
      _BonLivraisonPdfButtonCompactState();
}

class _BonLivraisonPdfButtonCompactState
    extends State<BonLivraisonPdfButtonCompact> {
  late PdfService _pdfService;
  bool _isLoading = false;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _pdfService = PdfService();
  }

  Future<void> _handleDownload() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    widget.onDownloadStart?.call();

    try {
      await _pdfService.downloadBonLivraisonPdf(
        orderId: widget.orderId,
        token: widget.authToken,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF ouvert ✅'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        widget.onDownloadComplete?.call();
      }
    } catch (e) {
      _logger.e('Erreur: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _isLoading ? null : _handleDownload,
      icon: _isLoading
          ? SizedBox(
              width: widget.size,
              height: widget.size,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
              ),
            )
          : Icon(
              Icons.picture_as_pdf,
              size: widget.size,
              color: Colors.blue.shade600,
            ),
      tooltip: 'Télécharger PDF',
    );
  }
}
