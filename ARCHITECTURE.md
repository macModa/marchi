# Architecture Documentation - Marchi 🏛️

This document provides a technical deep dive into the architecture and design patterns used in the **Marché Artisanal Tunisien** (Marchi) Flutter application.

---

## 🏗️ Architectural Pattern: Feature-First

The project follows a **Feature-First Architecture**, which organizes code by business features rather than technical layers (like data/domain/presentation). This makes the codebase modular and easier to navigate.

### Core Structure
- **`lib/core`**: Contains application-wide infrastructure that isn't specific to any feature.
  - `network/`: Dio client configuration and interceptors (e.g., adding Auth headers).
  - `routes/`: Centralized declarative routing using `GoRouter`.
  - `constants/`: Global strings, theme values, and API keys.
- **`lib/features`**: Each sub-folder represents a distinct business module.
  - Inside each feature, you'll typically find:
    - `screens/`: UI components (Flutter widgets).
    - `providers/`: State management logic using Riverpod.
    - `models/`: Data structures (often using Freezed).
    - `services/`: API communication specific to the feature.
- **`lib/shared`**: Reusable widgets and models used across multiple features.

---

## 🧪 Key Technologies & Patterns

### 1. State Management (Riverpod)
The app uses [Riverpod](https://riverpod.dev) for dependency injection and state management. 
- **Code Generation**: Uses `riverpod_generator` to ensure type-safety and boilerplate reduction.
- **Providers**: `authStateProvider`, `routerProvider`, etc., manage the application's state reactively.

### 2. Networking (Dio)
HTTP requests are handled by [Dio](https://pub.dev/packages/dio).
- **Interceptors**: Log requests and responses, and automatically attach Bearer tokens to authenticated requests.
- **Error Handling**: Centralized error mapping in `core/error`.

### 3. Navigation (GoRouter)
Declarative routing is implemented with [GoRouter](https://pub.dev/packages/go_router).
- **Redirection Logic**: Handles user redirection based on authentication state (e.g., redirecting to `/login` if not authenticated).

### 4. Data Modeling (Freezed)
Models are built using [Freezed](https://pub.dev/packages/freezed), providing:
- Immutable data classes.
- Union types (Sealed classes) for state (e.g., Loading, Success, Error).
- JSON serialization/deserialization.

---

## 🔐 Authentication Flow

1. **Splash**: Check for persisted tokens in `FlutterSecureStorage`.
2. **Login/Register**: Communicate with the backend via `AuthService`.
3. **State Sync**: `authStateProvider` updates, triggering `GoRouter`'s refresh listener.
4. **Navigation**: User is redirected to `/home` upon successful login.

---

## 🏺 Product & Order Flow

- **Products**: Fetched via `ProductService`, displayed in `HomeScreen`.
- **Cart**: Managed locally via `CartNotifier` (Riverpod StateNotifier).
- **Orders**: Created by sending cart items to the `OrderService`, navigating to the `PaymentScreen` upon success.

---

## 🛠️ Development Guidelines

- **No Shared State**: Keep feature state local to its module unless globally required.
- **Atomic Widgets**: Build small, reusable widgets in `shared/widgets`.
- **DRY (Don't Repeat Yourself)**: Use utility methods in `core` for common tasks like date formatting or currency display.
