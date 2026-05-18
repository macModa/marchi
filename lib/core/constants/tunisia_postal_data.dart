/// Données postales tunisiennes extraites du fichier GOV.csv
/// Structure : Province → District → Localité → Code Postal
///
/// Usage :
///   final provinces = kTunisiaPostalData.keys.toList();
///   final districts = kTunisiaPostalData['Tunis']!.keys.toList();
///   final localites = kTunisiaPostalData['Tunis']!['La Marsa']!.keys.toList();
///   final cp        = kTunisiaPostalData['Tunis']!['La Marsa']!['La Marsa Centre']!;
const Map<String, Map<String, Map<String, String>>> kTunisiaPostalData = {
  // ─────────────────────────────────────────────────────────────────────────
  'Bizerte': {
    'Bizerte Nord': {
      'Bizerte Centre': '7000',
      'Ain Mariem': '7000',
      'Cité El Houda': '7000',
      'Cité Belvédère': '7000',
      'Cité Bougatfa': '7001',
      'Bizerte Ksiba': '7001',
      'Cité de Paris': '7003',
      'Cité El Hana': '7003',
      'Sidi Ahmed': '7029',
      'Bizerte Bab Mateur': '7061',
    },
    'Bizerte Sud': {
      'Bizerte Hached': '7071',
      'La Pêcherie': '7011',
      'Borj Challouf': '7094',
    },
    'Zarzouna': {
      'Jarzouna': '7021',
    },
    'Menzel Jemil': {
      'Menzel Jemil Ville': '7080',
      'Menzel Abderrahmane': '7035',
      'El Azib': '7026',
      'Cité 7 Novembre': '7026',
    },
    'Menzel Bourguiba': {
      'Menzel Bourguiba Ville': '7050',
      'Cité Ennajah': '7072',
      'Tinja': '7032',
    },
    'Mateur': {
      'Mateur Ville': '7030',
      'Bazina': '7012',
    },
    'Ras Jebel': {
      'Ras Jebel': '7070',
      'Raf Raf': '7015',
      'Metline': '7027',
    },
    'El Alia': {
      'El Alia': '7016',
      'Khetmine': '7081',
    },
    'Ghar El Melh': {
      'Ghar El Melh': '7033',
      'El Aousja': '7014',
    },
    'Utique': {
      'Utique': '7060',
      'Sidi Othman': '7023',
    },
    'Ghezala': {
      'Ghezala': '7040',
    },
    'Joumine': {
      'Joumine': '7020',
    },
    'Sejnane': {
      'Sejnane': '7010',
    },
  },
  // ─────────────────────────────────────────────────────────────────────────
  'Ariana': {
    'Ariana Ville': {
      'Ariana': '2080',
      'Ariana Aéroport': '2035',
      'Ariana Nouvelle': '2080',
      'Cité El Nozha': '2080',
      'Cité du Jardin': '2080',
      'Cité El Mouaouia': '2080',
      'Cité El Wafa': '2080',
      'Cité Borj Turki': '2080',
      'Borj Baccouche': '2027',
      'Menzah 5': '2037',
      'Menzah 6': '2091',
      'Menzah 7': '2037',
      'Menzah 8': '2037',
    },
    'La Soukra': {
      'La Soukra': '2036',
      'Cité El Fath': '2036',
      'Cité El Hana': '2036',
      'Cité El Mansoura': '2036',
      'Choutrana 1': '2036',
      'Choutrana 2': '2036',
      'Choutrana 3': '2036',
      'Dar Fadhal': '2036',
      'Sidi Salah': '2036',
    },
    'Raoued': {
      'Raoued': '2056',
      'Cité El Ghazala 1': '2083',
      'Cité El Ghazala 2': '2083',
      'Pôle Technologique': '2088',
      'Cité Riadh El Andalous': '2058',
      'Cité El Amal': '2056',
      'Raoued Plage': '2056',
      'Jaafar 1': '2083',
      'Jaafar 2': '2083',
      'Borj Touil': '2083',
    },
    'Ettadhamen': {
      'Cité Ettadhamen': '2041',
    },
    'Mnihla': {
      'Mnihla': '2082',
      'Cité El Bassatine': '2082',
      'Cité El Entissar': '2082',
      'Cité Rafaha': '2082',
      'Sidi Thabet': '2032',
    },
    'Sidi Thabet': {
      'Sidi Thabet': '2032',
      'Cité Chorfech': '2032',
      'Cité El Mongi Slim': '2032',
      'Beb El Khoukha': '2032',
    },
    'Kalâat el-Andalous': {
      'Kalâat el-Andalous': '2022',
      'Pont de Bizerte': '2022',
      'El Hessiene': '2022',
    },
  },
  // ─────────────────────────────────────────────────────────────────────────
  'Manouba': {
    'Manouba Ville': {
      'Manouba Centre': '2010',
      'Manouba Entrée': '2010',
      'Cité El Amal': '2010',
      'Denden': '2011',
      'Cité Ibn Khaldoun': '2011',
    },
    'Oued Ellil': {
      'Oued Ellil Centre': '2021',
      'Cité El Ward': '2021',
      'Cité Ennasr': '2021',
      'Cité Erriadh': '2021',
    },
    'Douar Hicher': {
      'Douar Hicher': '2050',
      'Cité Khaled Ibn El Walid': '2050',
    },
    'Mornaguia': {
      'Mornaguia Centre': '2001',
      'Cité Bourguiba': '2001',
      'Sidi Ali El Hattab': '2015',
    },
    'Borj Amri': {
      'Borj Amri': '2014',
    },
    'El Battan': {
      'El Battan': '2013',
    },
    'Tebourba': {
      'Tebourba Ville': '2030',
      'Cité El Bassatine': '2030',
    },
    'Jedaida': {
      'Jedaida Centre': '2020',
      'Cité El Habib': '2020',
    },
  },
  // ─────────────────────────────────────────────────────────────────────────
  'Ben Arous': {
    'Ben Arous Ville': {
      'Ben Arous Centre': '2013',
      'Cité El Amen': '2013',
      'Nouvelle Medina 1': '2063',
      'Nouvelle Medina 2': '2063',
      'Cité El Yasmina': '2013',
      'Cité Olympique': '2013',
    },
    'Megrine': {
      'Megrine Riadh': '2014',
      'Megrine Coteaux': '2033',
      'Megrine Chaker': '2033',
      'Sidi Rezig': '2033',
    },
    'Rades': {
      'Rades Ville': '2040',
      'Rades Foret': '2040',
      'Rades Meliane': '2040',
      'Rades Plage': '2040',
      'Zone Industrielle Rades': '2040',
    },
    'Ezzahra': {
      'Ezzahra Ville': '2034',
      'Ezzahra El Habib': '2034',
      'Cité El Ons': '2034',
    },
    'Hammam Lif': {
      'Hammam Lif Centre': '2050',
      'Cité Mohamed Ali': '2050',
    },
    'Hammam Chott': {
      'Hammam Chott Centre': '2055',
      'Bir El Bey': '2055',
      'Borj Cedria': '2055',
    },
    'Bou Mhel': {
      'Bou Mhel El Bassatine': '2097',
      'Cité El Habib': '2097',
    },
    'Mornag': {
      'Mornag Centre': '2090',
      'Cité Erriadh': '2090',
      'Khledia': '2054',
      'Jebel Ressas': '2090',
    },
    'Mohamedia': {
      'Mohamedia Centre': '2008',
      'Cité El Menzel': '2008',
    },
    'Fouchana': {
      'Fouchana Centre': '2082',
      'Zone Industrielle Mghira': '2082',
      'Cité El Hidaya': '2082',
    },
    'El Mourouj': {
      'El Mourouj 1': '2074',
      'El Mourouj 2': '2074',
      'El Mourouj 3': '2074',
      'El Mourouj 4': '2074',
      'El Mourouj 5': '2074',
      'El Mourouj 6': '2074',
    },
  },
  // ─────────────────────────────────────────────────────────────────────────
  'Tunis': {
    'Tunis Centre': {
      'Tunis Ville (Avenue Habib Bourguiba)': '1000',
      'Tunis République': '1001',
      'Belvédère': '1002',
      'Mutuelle Ville': '1082',
      'Cité Mahrajène': '1082',
      'Montplaisir': '1073',
      'Bab El Khadra': '1075',
      'Bab Saadoun': '1029',
      'Bab Souika': '1006',
      'La Médina': '1000',
      'Sidi El Béchir': '1089',
      'Bab El Falla': '1027',
      'Montfleury': '1089',
    },
    'El Menzah': {
      'El Menzah 1': '1004',
      'El Menzah 4': '1082',
      'El Menzah 9': '1013',
    },
    'El Manar': {
      'El Manar 1': '2092',
      'El Manar 2': '2092',
    },
    'Cité El Khadra': {
      'Cité El Khadra': '1003',
      'Cité Jardins': '1002',
      'Zone Industrielle Charguia 1': '2035',
      'Zone Industrielle Charguia 2': '2035',
    },
    'Les Berges du Lac': {
      'Lac 1': '1053',
      'Lac 2': '1053',
    },
    'La Goulette': {
      'La Goulette Centre': '2060',
      'Le Kram': '2015',
      'Le Kram Ouest': '2089',
    },
    'Carthage': {
      'Carthage': '2016',
      'Carthage Byrsa': '2016',
      'Sidi Bou Saïd': '2026',
      'Amilcar': '1054',
    },
    'La Marsa': {
      'La Marsa Centre': '2070',
      'Gammarth': '1057',
      'Sidi Daoud': '2046',
      'La Marsa Plage': '2070',
      'Cité El Khalil': '2076',
    },
    'El Omrane': {
      'El Omrane': '1005',
      'Cité Ibn Khaldoun': '2062',
      'El Omrane Supérieur': '1091',
    },
    'Ezzouhour': {
      'Cité Ezzouhour': '2052',
      'Ezzahrouni': '2051',
    },
    'El Hrairia': {
      'Sidi Hassine': '1095',
    },
    'El Kabaria': {
      'El Kabaria': '2053',
      'Ibn Sina': '2066',
    },
    'Jebel Jelloud': {
      'Jebel Jelloud': '1046',
      'Sidi Fathallah': '2023',
    },
  },
  // ─────────────────────────────────────────────────────────────────────────
  'Nabeul': {
    'Nabeul Ville': {
      'Nabeul Centre': '8000',
      'Cité El Borj': '8000',
      'Nabeul Thameur': '8062',
      'Cité El Mahrsi': '8062',
      'Ain Kemicha': '8000',
    },
    'Dar Chaâbane': {
      'Dar Chaâbane El Fehri': '8011',
      'Dar Chaâbane Plage': '8075',
    },
    'Hammamet': {
      'Hammamet Centre': '8050',
      'Hammamet Nord': '8050',
      'Yasmine Hammamet': '8057',
      'Bir Bouregba': '8042',
      'Barraket Essahel': '8056',
    },
    'Béni Khiar': {
      'Béni Khiar': '8060',
      'El Maâmoura': '8012',
      'Somaâ': '8023',
    },
    'Korba': {
      'Korba Centre': '8070',
      'Tazarka': '8024',
    },
    'Menzel Temime': {
      'Menzel Temime': '8080',
      'Menzel Horr': '8015',
    },
    'Kélibia': {
      'Kélibia Centre': '8090',
      'Kélibia Port': '8090',
    },
    'El Haouaria': {
      'El Haouaria Centre': '8045',
      'Bou Krim': '8046',
    },
    'Menzel Bouzelfa': {
      'Menzel Bouzelfa Centre': '8010',
      'Damous El Hajja': '8010',
    },
    'Béni Khalled': {
      'Béni Khalled Centre': '8021',
      'Zaouiet Jedidi': '8099',
    },
    'Grombalia': {
      'Grombalia Centre': '8030',
      'Bou Argoub': '8040',
      'Belli': '8030',
    },
    'Soliman': {
      'Soliman Centre': '8020',
      'Soliman Plage': '8020',
      'Echérifate': '8051',
    },
    'Takelsa': {
      'Takelsa Centre': '8014',
    },
  },
};

/// Returns a flat list of all districts for the given province.
List<String> districtsForProvince(String province) =>
    kTunisiaPostalData[province]?.keys.toList() ?? [];

/// Returns a flat list of all localités for the given province + district.
List<String> localitesForDistrict(String province, String district) =>
    kTunisiaPostalData[province]?[district]?.keys.toList() ?? [];

/// Returns the postal code for the given province + district + localité.
/// Returns null if the combination is not found.
String? postalCodeFor(String province, String district, String localite) =>
    kTunisiaPostalData[province]?[district]?[localite];
