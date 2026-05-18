/// Converts a TND (Tunisian Dinar) amount to French words.
///
/// The amount is expected to have at most 2 decimal places (scale 2),
/// which represents centimes. Millimes = centimes × 10.
///
/// Examples:
///   numberToWordsFr(145.00) → "Cent quarante-cinq dinars"
///   numberToWordsFr(145.50) → "Cent quarante-cinq dinars et cinq cents millimes"
///   numberToWordsFr(3.75)   → "Trois dinars et sept cent cinquante millimes"
///   numberToWordsFr(0)      → "Zéro dinar"
String numberToWordsFr(double amount) {
  if (amount == 0) return 'Zéro dinar';

  final int dinars = amount.truncate();
  // scale-2 fraction × 1000 = millimes (e.g. 0.50 TND = 500 millimes)
  final int millimes = ((amount - dinars) * 1000).round();

  final buffer = StringBuffer();
  buffer.write(_intToWords(dinars));
  buffer.write(dinars > 1 ? ' dinars' : ' dinar');

  if (millimes > 0) {
    buffer.write(' et ');
    buffer.write(_intToWords(millimes));
    buffer.write(millimes > 1 ? ' millimes' : ' millime');
  }

  final result = buffer.toString();
  return result[0].toUpperCase() + result.substring(1);
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helpers
// ─────────────────────────────────────────────────────────────────────────────

const _ones = [
  '', 'un', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit',
  'neuf', 'dix', 'onze', 'douze', 'treize', 'quatorze', 'quinze',
  'seize', 'dix-sept', 'dix-huit', 'dix-neuf',
];

const _tens = [
  '', '', 'vingt', 'trente', 'quarante', 'cinquante',
  'soixante', 'soixante', 'quatre-vingt', 'quatre-vingt',
];

String _intToWords(int n) {
  assert(n >= 0, 'Number must be non-negative');
  if (n == 0) return 'zéro';

  // 1–19
  if (n < 20) return _ones[n];

  // 20–69
  if (n < 70) {
    final ten  = n ~/ 10;
    final unit = n % 10;
    if (unit == 0) return _tens[ten] + (ten == 8 ? 's' : '');
    if (unit == 1 && ten < 8) return '${_tens[ten]} et un';
    return '${_tens[ten]}-${_ones[unit]}';
  }

  // 70–79: soixante-dix…soixante-dix-neuf
  if (n < 80) return 'soixante-${_ones[n - 60]}';

  // 80–89: quatre-vingts, quatre-vingt-un…
  if (n < 90) {
    final unit = n - 80;
    return unit == 0 ? 'quatre-vingts' : 'quatre-vingt-${_ones[unit]}';
  }

  // 90–99: quatre-vingt-dix…quatre-vingt-dix-neuf
  if (n < 100) return 'quatre-vingt-${_ones[n - 80]}';

  // 100–199
  if (n < 200) {
    final rem = n - 100;
    return rem == 0 ? 'cent' : 'cent ${_intToWords(rem)}';
  }

  // 200–999
  if (n < 1000) {
    final hundred = n ~/ 100;
    final rem     = n % 100;
    final h = '${_ones[hundred]} cent${rem == 0 ? 's' : ''}';
    return rem == 0 ? h : '$h ${_intToWords(rem)}';
  }

  // 1 000–1 999
  if (n < 2000) {
    final rem = n - 1000;
    return rem == 0 ? 'mille' : 'mille ${_intToWords(rem)}';
  }

  // 2 000–999 999
  if (n < 1000000) {
    final thousands = n ~/ 1000;
    final rem       = n % 1000;
    final t = '${_intToWords(thousands)} mille';
    return rem == 0 ? t : '$t ${_intToWords(rem)}';
  }

  // Fallback for very large numbers
  return n.toString();
}
