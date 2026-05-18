class ApiConstants {
  // Base Configuration
  static const String baseUrl = 'https://resplendent-passion-production-773a.up.railway.app';
  static const String apiPrefix = '/api';
  static const String apiUrl = '$baseUrl$apiPrefix';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // JWT
  static const int jwtExpirationMs = 86400000;

  // Authentication
  static const String authLogin    = '$apiUrl/auth/login';
  static const String authRegister = '$apiUrl/auth/register';

  // Products
  static const String products          = '$apiUrl/products';
  static String productById(int id)     => '$products/$id';
  static String productsByCategory(int categoryId) => '$products/category/$categoryId';
  static String productsByArtisan(int artisanId)   => '$products/artisan/$artisanId';
  static const String productsSearch    = '$products/search';
  static const String productsAvailable = '$products/available';

  // Categories
  static const String categories     = '$apiUrl/categories';
  static String categoryById(int id) => '$categories/$id';

  // Orders
  static const String orders                        = '$apiUrl/orders';
  static String orderById(int id)                   => '$orders/$id';
  static const String myOrders                      = '$orders/my-orders';
  static const String artisanOrders                 = '$orders/my-artisan-orders';
  static String cancelOrder(int id)                 => '$orders/$id/cancel';
  static String artisanUpdateStatus(int id)         => '$orders/$id/artisan-status';

  // Delivery PDF
  static String deliveryNote(int id) => '$baseUrl/api/v1/delivery/bon-livraison/$id/pdf';

  // Payments
  static const String payments                      = '$apiUrl/payments';
  static String paymentById(int id)                 => '$payments/$id';
  static String paymentByOrder(int orderId)         => '$payments/order/$orderId';
  static String createPaymentForOrder(int orderId)  => '$payments/order/$orderId';

  // Delivery QR
  static String fetchQrCode(String trackingNumber) => '$baseUrl/api/v1/delivery/qr/$trackingNumber';
  static const String confirmDeliveryByQr              = '$baseUrl/api/v1/delivery/qr/confirm';

  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix        = 'Bearer';
  static const String contentTypeHeader   = 'Content-Type';
  static const String contentTypeJson     = 'application/json';
}
