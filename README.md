# Film Craft Daily

A cinematic techniques flashcard app for filmmakers, students, and film enthusiasts. Learn storytelling, camera work, sound design, color theory, and more through beautifully crafted cards with real-world film references and hands-on challenges.

## Features

- **56 Curated Flashcards** across 9 categories: Story, Shot, Sound, Color, Lens, Framing, Blocking, VFX, and History
- **3D Flip Animation** — tap to reveal a creative challenge on the back of each card
- **Category Filtering** — browse by technique type with color-coded chips
- **Save & Bookmark** — heart your favorite cards for quick reference
- **Progress Tracking** — see how many cards you've explored
- **Swipe Navigation** — swipe left/right or use the arrow controls
- **Cross-Platform** — runs on iOS and web from a single codebase

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x |
| Backend | Firebase Cloud Firestore |
| Local Storage | SharedPreferences |
| State Management | Provider |
| Platforms | iOS, Web |

## Architecture

The app is built with an **auth-ready abstraction layer** — services use abstract interfaces so authentication and cloud sync can be added later without rewriting the UI.

```
lib/
├── models/          # Flashcard data model
├── services/        # Abstract interfaces + implementations
│   ├── card_service.dart            # Cards from Firestore
│   ├── storage_service.dart         # Local save/bookmark persistence
│   └── auth_service.dart            # Stub for future authentication
├── providers/       # ChangeNotifier state management
├── screens/         # Home screen with explore & saved views
├── theme/           # Dark theme, category color system
└── config/          # Firebase configuration
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or later)
- A [Firebase project](https://console.firebase.google.com) with Cloud Firestore enabled

### Setup

```bash
# Clone the repo
git clone https://github.com/karthikv792/filmmaking-flashcards.git
cd filmmaking-flashcards

# Install dependencies
flutter pub get

# Configure Firebase (update lib/config/firebase_options.dart with your project credentials)
# Or use FlutterFire CLI:
flutterfire configure --project=your-project-id --out=lib/config/firebase_options.dart

# Seed flashcards to Firestore
cd tool && npm install firebase && node seed.mjs && cd ..

# Run on web
flutter run -d chrome

# Run on iOS
flutter run -d ios
```

## Card Categories

| Category | Cards | Topics |
|----------|-------|--------|
| Story | 8 | Rashomon Effect, Unreliable Narrator, MacGuffin, Dramatic Irony... |
| Shot | 7 | Long Take, Dolly Zoom, Whip Pan, Dutch Angle, Tracking Shot... |
| Sound | 6 | Sound Bridge, Diegetic Blur, Silence, Foley, Leitmotif... |
| Color | 5 | Orange & Teal, Desaturation, Color Arcs, Monochromatic... |
| Lens | 5 | Wide Angle, Shallow DOF, Anamorphic, Long Lens, Macro... |
| Framing | 6 | Frame Within Frame, Negative Space, Symmetry, Leading Lines... |
| Blocking | 5 | Power Triangle, Proxemics, Walk & Talk, Levels, Reveals... |
| VFX | 4 | Invisible VFX, Forced Perspective, De-Aging, Miniatures... |
| History | 10 | Thermopylae, Titanic, Churchill, Moon Landing, Alcatraz... |

## License

MIT
