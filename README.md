# Spark — Flutter Dating App Clone

A pixel-accurate Bumble/Tinder-style dating app built in Flutter with Clean Architecture, BLoC state management, and live API integration.

---

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run on a connected device or emulator
flutter run

# Run on a specific device
flutter run -d <device_id>
```

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/        # Colors, text styles, spacing tokens
│   ├── di/               # GetIt service locator
│   ├── error/            # Typed failure classes
│   ├── network/          # Dio client configuration
│   ├── theme/            # Dark ThemeData
│   └── widgets/          # Shared reusable widgets
│       ├── app_top_bar.dart
│       ├── bottom_nav_bar.dart
│       ├── circular_icon_button.dart
│       ├── info_badge_pill.dart
│       ├── primary_avatar.dart
│       ├── section_header.dart
│       └── shimmer_loader.dart
│
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── datasources/     # Dio remote data source
│   │   │   ├── models/          # UserModel (DTO + deterministic derived fields)
│   │   │   └── repositories/    # Repository implementation
│   │   ├── domain/
│   │   │   ├── entities/        # UserEntity (pure Dart)
│   │   │   ├── repositories/    # Abstract interface
│   │   │   └── usecases/        # GetUsersUseCase
│   │   └── presentation/
│   │       ├── bloc/            # HomeFeedBloc + States + Events
│   │       ├── pages/           # HomePage
│   │       └── widgets/         # ProfileSwipeCard, HomeShimmerCard
│   ├── admirers/
│   ├── chat/
│   ├── date_now/
│   ├── events/
│   ├── filters/
│   ├── menu/
│   ├── notifications/
│   └── profile_detail/
│
├── routes/
│   ├── app_router.dart   # GoRouter configuration
│   └── app_routes.dart   # Route name constants
│
├── app.dart              # MaterialApp.router + BlocProviders
└── main.dart             # Entry point (DI setup, orientation lock)
```

---

## 🏗️ Architecture

### Clean Architecture with MVVM

```
UI (Widgets) → BLoC/Cubit → Use Cases → Repository Interface
                                              ↓
                                    Repository Implementation
                                              ↓
                                    Remote Data Source (Dio)
                                              ↓
                                    randomuser.me API
```

### Layers
| Layer | Responsibility |
|---|---|
| `domain/` | Pure business logic, no Flutter/Dio imports |
| `data/` | API calls, JSON parsing, repository implementations |
| `presentation/` | Widgets, pages, BLoC/Cubit state management |
| `core/` | Shared utilities, DI, theme, networking |

### State Management
- **`HomeFeedBloc`** — manages the home feed with 4 states:
  - `HomeFeedLoading` → Shimmer card skeleton
  - `HomeFeedLoaded` → Swipeable card stack from API
  - `HomeFeedError` → Friendly error with retry (network/timeout/parse)
  - `HomeFeedEmpty` → "Load More" screen
- **`FiltersCubit`** — local UI state for the Filters screen

---

## 🌐 API Integration

**Endpoint:** `GET https://randomuser.me/api/?results=20`

| UI Field | API Source | Notes |
|---|---|---|
| Profile photo | `picture.large` | Cached via `cached_network_image` |
| Name | `name.first` + `name.last` | — |
| Age | `dob.age` | — |
| City | `location.city` | — |
| Match % | Derived from `login.uuid` hash | Deterministic, stable per user |
| Trust % | Derived from `login.uuid` hash | Deterministic, stable per user |
| Reply time | Derived from `login.uuid` hash | One of 10 options |
| Online status | Derived from `login.uuid` hash | ~33% are online |
| Distance | Derived from `login.uuid` hash | 1–30 km |
| Occupation | Derived from `login.uuid` hash | 10 mock options |
| Height | Derived from `login.uuid` hash | 10 mock options |
| Intent | Derived from `login.uuid` hash | 6 mock options |

All derived fields are computed from a hash of `login.uuid` so they **never change** across rebuilds for the same user.

---

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `flutter_bloc` | BLoC/Cubit state management |
| `dio` | HTTP client with interceptors |
| `go_router` | Declarative named routing |
| `get_it` | Dependency injection |
| `cached_network_image` | Image caching + placeholders |
| `shimmer` | Skeleton loading animations |
| `google_fonts` | Poppins typography |
| `equatable` | Value equality for BLoC states |

---

## 🎨 Design System

- **Background:** `#0D0D0D` (near-black scaffold)
- **Cards:** `#1A1A1A`
- **Primary accent:** `#E8385A` (pink/red — buttons, active nav, badges)
- **Match badge:** `#4A9EFF` (blue)
- **Trust badge:** `#2DD87F` (green)
- **Reply badge:** `#FF8C42` (orange)
- **Typography:** Poppins (Google Fonts)

---

## 📱 Screens

| Screen | Type | Notes |
|---|---|---|
| Home | API-wired | Swipe cards, all BLoC states, pull-to-refresh |
| Date Now | Static | Toggle availability, nearby grid |
| Admirers | Static | Blurred cards for non-premium |
| Chat List | Static | Conversations with unread badges |
| Chat Detail | Static | Functional send UI |
| Events | Static | RSVP toggle |
| Filters | Local State | FiltersCubit, sliders, chips |
| Notifications | Static | Grouped with unread dots |
| Profile Detail | Dynamic | Photo carousel, bio, interests |
| Menu Drawer | Static | User stats, navigation links |
