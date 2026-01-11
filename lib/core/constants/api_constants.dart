class ApiConstants {
  // Base Configuration
  static const String baseUrl = 'http://localhost:8080';
  static const String apiPrefix = '/api';
  
  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // JWT
  static const int jwtExpirationMs = 86400000; // 24 hours
  
  // Authentication Endpoints
  static const String authLogin = '$apiPrefix/auth/login';
  static const String authRegister = '$apiPrefix/auth/register';
  
  // Products Endpoints
  static const String products = '$apiPrefix/products';
  static String productById(int id) => '$products/$id';
  static String productsByCategory(int categoryId) => '$products/category/$categoryId';
  static String productsByArtisan(int artisanId) => '$products/artisan/$artisanId';
  static const String productsSearch = '$products/search';
  static const String productsAvailable = '$products/available';
  
  // Categories Endpoints
  static const String categories = '$apiPrefix/categories';
  static String categoryById(int id) => '$categories/$id';
  
  // Orders Endpoints
  static const String orders = '$apiPrefix/orders';
  static String orderById(int id) => '$orders/$id';
  static const String myOrders = '$orders/my-orders';
  static String cancelOrder(int id) => '$orders/$id/cancel';
  
  // Payments Endpoints
  static const String payments = '$apiPrefix/payments';
  static String paymentById(int id) => '$payments/$id';
  static String paymentByOrder(int orderId) => '$payments/order/$orderId';
  static String createPaymentForOrder(int orderId) => '$payments/order/$orderId';
  
  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeJson = 'application/json';
}
