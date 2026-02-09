# Film Craft Daily — Flutter + Firebase Implementation Plan

## Current State

- **React prototype** in a single `index.js` (40KB) with 77 hardcoded flashcards
- Categories: Story, Shot, Sound, Color, Lens, Framing, Blocking, VFX, History
- Features: card flip animation, category filtering, save/bookmark, progress tracking, swipe navigation
- No backend, no build system, no Flutter project

## Goals

- **Flutter** cross-platform app (iOS + Web)
- **Firebase Firestore** for flashcard data (remotely manageable)
- **Local storage** (SharedPreferences) for saved/favorited cards
- **Auth-ready architecture** — structured so authentication can be added later without rewrites

---

## Target Project Structure

```
filmmaking-flashcards/
├── lib/
│   ├── main.dart                        # App entry point
│   ├── app.dart                         # MaterialApp + routing
│   ├── config/
│   │   └── firebase_options.dart        # FlutterFire generated
│   ├── models/
│   │   └── flashcard.dart               # Flashcard data model
│   ├── services/
│   │   ├── card_service.dart            # Abstract interface for card data
│   │   ├── firestore_card_service.dart  # Firestore implementation
│   │   ├── storage_service.dart         # Abstract interface for local storage
│   │   ├── local_storage_service.dart   # SharedPreferences implementation
│   │   └── auth_service.dart            # Stub for future auth
│   ├── providers/
│   │   └── app_state.dart               # ChangeNotifier for app state
│   ├── screens/
│   │   ├── home_screen.dart             # Main screen with explore/saved tabs
│   │   └── splash_screen.dart           # Loading screen
│   ├── widgets/
│   │   ├── flashcard_widget.dart        # Flip card with front/back
│   │   ├── category_filter.dart         # Horizontal category chips
│   │   ├── card_swiper.dart             # Swipeable card stack
│   │   └── progress_bar.dart            # Cards seen indicator
│   └── theme/
│       └── app_theme.dart               # Dark theme, category colors
├── web/                                 # Flutter web support
├── ios/                                 # iOS support
├── android/                             # Android support (free with Flutter)
├── test/                                # Unit & widget tests
├── tool/
│   └── seed_firestore.dart              # One-time script to seed 77 cards
├── pubspec.yaml
├── firebase.json
└── firestore.rules
```

---

## Key Architecture Decisions

### 1. State Management: Provider

Simple, well-documented, and sufficient for this app's complexity. Easy to migrate to Riverpod later if needed.

### 2. Firestore for Cards, SharedPreferences for Saves

Cards live in Firestore so you can add/edit/remove cards from the Firebase Console without app updates. Saved card IDs are stored locally via SharedPreferences (no auth needed yet).

### 3. Auth-Ready Abstraction

Services use abstract interfaces. When auth is added later:

- `StorageService` gets a Firestore-backed implementation (saved cards per user)
- `CardService` can add user-specific progress tracking
- Just swap implementations via Provider — no UI changes needed

```dart
// Abstract so we can swap implementations when auth arrives
abstract class CardService {
  Future<List<Flashcard>> getAllCards();
  Future<List<Flashcard>> getCardsByCategory(String category);
}

abstract class StorageService {
  Future<Set<String>> getSavedCardIds();
  Future<void> toggleSaveCard(String cardId);
  // Future: will accept userId parameter
}
```

### 4. Firestore Collection Structure

```
flashcards/              (collection)
  ├── s1                 (document)
  │   ├── cat: "Story"
  │   ├── title: "The Rashomon Effect"
  │   ├── desc: "..."
  │   ├── film: "Rashomon (1950)"
  │   ├── tryThis: "..."
  │   ├── icon: "📖"
  │   └── order: 1
  └── s2 ...
```

### 5. Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.x
  cloud_firestore: ^5.x
  shared_preferences: ^2.x
  provider: ^6.x
  flip_card: ^0.7.x  # or custom animation
```

---

## Execution Waves

### Wave 1: Foundation (6 pts)

| # | Ticket | Summary | Points | Risk | Dependencies |
|---|--------|---------|--------|------|--------------|
| 1 | Flutter project setup | `flutter create`, configure for iOS + web, add dependencies to `pubspec.yaml` | 2 | Low | Flutter SDK installed |
| 2 | Data model + theme | `Flashcard` model class, `AppTheme` with dark mode & category colors matching React prototype | 2 | Low | Ticket 1 |
| 3 | Firebase setup | FlutterFire CLI config, Firestore setup, seed 77 cards to Firestore | 3 | Med | Ticket 1, Firebase project created |

### Wave 2: Services Layer (5 pts) — depends on Wave 1

| # | Ticket | Summary | Points | Risk | Dependencies |
|---|--------|---------|--------|------|--------------|
| 4 | Card service (Firestore) | Abstract `CardService` + `FirestoreCardService` — fetch cards, local cache | 3 | Low | Tickets 2, 3 |
| 5 | Local storage service | `LocalStorageService` using SharedPreferences for saved card IDs, seen cards | 2 | Low | Ticket 2 |

### Wave 3: UI Layer (14 pts) — depends on Wave 2

| # | Ticket | Summary | Points | Risk | Dependencies |
|---|--------|---------|--------|------|--------------|
| 6 | App state (Provider) | `AppState` ChangeNotifier — current category, card index, saved set, flip state | 3 | Low | Tickets 4, 5 |
| 7 | Flashcard widget | 3D flip animation card with front (title, category, icon) and back (description, film, challenge) | 5 | Med | Ticket 6 |
| 8 | Home screen | Category filter bar, card swiper, explore/saved toggle, progress bar | 5 | Med | Tickets 6, 7 |
| 9 | Splash screen | Loading screen while Firestore data loads | 1 | Low | Ticket 6 |

### Wave 4: Polish & Deploy (6 pts) — depends on Wave 3

| # | Ticket | Summary | Points | Risk | Dependencies |
|---|--------|---------|--------|------|--------------|
| 10 | Swipe gestures + animations | GestureDetector for swipe navigation, smooth card transitions | 3 | Med | Ticket 8 |
| 11 | Platform testing + build | Test on iOS simulator + Chrome, fix platform-specific issues, build configs | 3 | Med | All above |

---

## Firestore Seeding Strategy

Create a one-time Dart script (`tool/seed_firestore.dart`) that:

1. Reads the 77 card definitions (ported from the React `index.js` data)
2. Writes each card as a document to the `flashcards` collection in Firestore
3. Adds an `order` field for consistent sorting

Alternative: import via Firebase Console or a Node.js script reading `index.js` directly.

---

## Risk Assessment

| Area | Risk | Mitigation |
|------|------|------------|
| Firebase setup | Medium | Step-by-step in ticket; can fall back to local JSON if Firebase isn't ready |
| 3D flip animation | Medium | Use `flip_card` package or custom `AnimatedBuilder` with `Transform` |
| Web + iOS parity | Medium | Test both platforms in Wave 4; use `kIsWeb` for platform-specific checks |
| Firestore cold start | Low | 77 documents is tiny; cache after first fetch |

---

## Summary

| Metric | Value |
|--------|-------|
| **Total Tickets** | 11 |
| **Total Story Points** | 32 |
| **Execution Waves** | 4 |
| **Risk Profile** | 6 Low, 5 Medium, 0 High |
| **Platforms** | iOS + Web |
| **Key Dependencies** | Flutter SDK, Firebase project, FlutterFire CLI |

---

## Notes

- The existing React `index.js` will be kept as reference until the Flutter app is feature-complete.
- No authentication is implemented in this plan — only the abstractions to support it later.
- Android support comes free with Flutter but is not a primary target for this plan.

---

## Next Steps

1. Review and approve this plan
2. Ensure Flutter SDK and FlutterFire CLI are installed
3. Create a Firebase project (or provide existing project details)
4. Begin Wave 1 implementation
