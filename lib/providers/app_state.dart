import 'package:flutter/foundation.dart';
import '../models/flashcard.dart';
import '../services/card_service.dart';
import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  final CardService _cardService;
  final StorageService _storageService;

  AppState({
    required CardService cardService,
    required StorageService storageService,
  })  : _cardService = cardService,
        _storageService = storageService;

  // Loading state
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // All cards from Firestore
  List<Flashcard> _allCards = [];
  List<Flashcard> get allCards => _allCards;

  // Filtered cards based on active category
  List<Flashcard> _filteredCards = [];
  List<Flashcard> get filteredCards =>
      _viewMode == ViewMode.saved ? _savedCards : _filteredCards;

  // Category filter
  String _activeCategory = 'All';
  String get activeCategory => _activeCategory;

  // Current card index
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // Card flip state
  bool _isFlipped = false;
  bool get isFlipped => _isFlipped;

  // Saved card IDs
  Set<String> _savedIds = {};
  Set<String> get savedIds => _savedIds;

  // Seen card IDs
  Set<String> _seenIds = {};
  Set<String> get seenIds => _seenIds;

  // View mode
  ViewMode _viewMode = ViewMode.explore;
  ViewMode get viewMode => _viewMode;

  // Saved cards list (derived)
  List<Flashcard> _savedCards = [];

  // Current card convenience getter
  Flashcard? get currentCard {
    final cards = filteredCards;
    if (cards.isEmpty || _currentIndex >= cards.length) return null;
    return cards[_currentIndex];
  }

  // Progress
  double get progress {
    if (_allCards.isEmpty) return 0;
    return _seenIds.length / _allCards.length;
  }

  /// Load all data from services. Call once on app start.
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allCards = await _cardService.getAllCards();
      _savedIds = await _storageService.getSavedCardIds();
      _seenIds = await _storageService.getSeenCardIds();
      _applyFilter();
      _rebuildSavedCards();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    if (_activeCategory == category) return;
    _activeCategory = category;
    _currentIndex = 0;
    _isFlipped = false;
    _applyFilter();
    notifyListeners();
  }

  void setViewMode(ViewMode mode) {
    if (_viewMode == mode) return;
    _viewMode = mode;
    _currentIndex = 0;
    _isFlipped = false;
    notifyListeners();
  }

  void goToCard(int index) {
    final cards = filteredCards;
    if (cards.isEmpty) return;
    _currentIndex = index.clamp(0, cards.length - 1);
    _isFlipped = false;
    _markCurrentCardSeen();
    notifyListeners();
  }

  void nextCard() {
    final cards = filteredCards;
    if (cards.isEmpty) return;
    if (_currentIndex < cards.length - 1) {
      _currentIndex++;
      _isFlipped = false;
      _markCurrentCardSeen();
      notifyListeners();
    }
  }

  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _isFlipped = false;
      notifyListeners();
    }
  }

  void toggleFlip() {
    _isFlipped = !_isFlipped;
    notifyListeners();
  }

  Future<void> toggleSave() async {
    final card = currentCard;
    if (card == null) return;

    await _storageService.toggleSaveCard(card.id);
    if (_savedIds.contains(card.id)) {
      _savedIds.remove(card.id);
    } else {
      _savedIds.add(card.id);
    }
    _rebuildSavedCards();
    notifyListeners();
  }

  bool isCardSaved(String cardId) => _savedIds.contains(cardId);

  Future<void> toggleSaveById(String cardId) async {
    await _storageService.toggleSaveCard(cardId);
    if (_savedIds.contains(cardId)) {
      _savedIds.remove(cardId);
    } else {
      _savedIds.add(cardId);
    }
    _rebuildSavedCards();
    notifyListeners();
  }

  void _applyFilter() {
    if (_activeCategory == 'All') {
      _filteredCards = List.from(_allCards);
    } else {
      _filteredCards =
          _allCards.where((c) => c.cat == _activeCategory).toList();
    }
  }

  void _rebuildSavedCards() {
    _savedCards =
        _allCards.where((c) => _savedIds.contains(c.id)).toList();
  }

  void _markCurrentCardSeen() {
    final card = currentCard;
    if (card == null) return;
    if (!_seenIds.contains(card.id)) {
      _seenIds.add(card.id);
      _storageService.markCardSeen(card.id);
    }
  }
}

enum ViewMode { explore, saved }
