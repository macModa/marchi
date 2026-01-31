# Marchi - Tunisian Artisanal Marketplace

Marchi is a full-stack marketplace application designed to connect Tunisian artisans with clients. The platform enables artisans to showcase their handmade products, while clients can browse, search, and purchase unique artisanal items.

## Tech Stack

### Frontend
- **Framework**: Flutter (Mobile)
- **State Management**: Riverpod (with Generator)
- **Networking**: Dio
- **Storage**: Flutter Secure Storage (JWT), Shared Preferences
- **Architecture**: Feature-first Layered Architecture

### Backend
- **Framework**: Spring Boot (REST API)
- **Security**: Spring Security with JWT
- **Database**: MySQL
- **Persistence**: Spring Data JPA
- **Language**: Java 17

## Architecture Overview

The project follows a clean, layered architecture to ensure separation of concerns and maintainability.

### Backend Structure
- **Controller Layer**: REST Endpoints handling HTTP requests and responses.
- **Service Layer**: Business logic implementation.
- **Repository Layer**: Data access using JPA/Hibernate.
- **Entity Layer**: Database mapping and domain models.
- **DTO Layer**: Data Transfer Objects for API communication.
- **Security**: JWT-based stateless authentication.

### Frontend Structure
- **Features Layer**: Modularized by domain (Auth, Products, Orders, Payments).
- **Presentation**: Flutter screens and widgets.
- **Providers**: State management and business logic.
- **Services**: API client wrappers.

## Implemented Features

### Authentication & Authorization
- User registration and login.
- JWT-based authentication.
- Role-based access control (ADMIN, ARTISAN, CLIENT).
- Secure token storage on the mobile app.

### Product Management
- Browse products (Paginated).
- View product details.
- Search products by keyword.
- Filter products by category.
- Artisan-specific product management (Create, Update, Delete).
- Product image upload (Multi-part).

### Order Processing
- Create orders (Client).
- View order history (Client/Admin).
- Cancel orders (Client).
- Update order status (Admin).

### Payment Integration
- Create payment for orders.
- Payment status tracking (Pending, Completed, Failed, Refunded).
- Admin management of payment statuses.

## Authentication & Roles

The system uses three distinct roles:
- **CLIENT**: Can browse products, create orders, and manage their payments.
- **ARTISAN**: Can manage their own shop and products.
- **ADMIN**: Has oversight of all orders, payments, and system configurations.

## Database Design

The database schema includes the following key entities:
- **User**: Base entity for all users (Shared table via JOINED inheritance).
- **Client**: Extends User, represents customers.
- **Artisan**: Extends User, includes shop-specific details (Shop name, description).
- **Product**: Managed by artisans, linked to categories.
- **Category**: Hierarchical grouping for products.
- **Order**: Links clients to products via Order Lines.
- **OrderLine**: Specific items within an order with quantity and price.
- **Payment**: Linked to orders for transaction tracking.

## Environment & Setup

### Backend (Spring Boot)
1. Configure MySQL database in `src/main/resources/application.properties`.
2. Run `mvn install` to download dependencies.
3. Launch the application: `mvn spring-boot:run`.

### Frontend (Flutter)
1. Ensure Flutter SDK is installed.
2. Run `flutter pub get`.
3. Update the API base URL in the configuration (e.g., `DioClient`).
4. Launch the app: `flutter run`.

## Project Status

### Completed
- Core Authentication (JWT).
- Product Browsing & Management.
- Category Filtering.
- Order Creation Flow.
- Payment entity and status management.

### In Progress
- Advanced Artisan Dashboard.
- Real-time order notifications.
- Enhanced search filtering (price range, location).

## Future Roadmap

- **Short Term**: Implement product reviews and ratings.
- **Mid Term**: Integration with local Tunisian payment gateways.
- **Long Term**: Recommendation engine based on user preferences.

## License & Contribution

This project is developed for the Tunisian artisanal community. Contributions are welcome via Pull Requests. Please ensure all code adheres to the established architecture and naming conventions.



key

flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run -d edge