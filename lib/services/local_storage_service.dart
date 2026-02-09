import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class LocalStorageService implements StorageService {
  static const _savedKey = 'filmcraft-saved-cards';
  static const _seenKey = 'filmcraft-seen-cards';

  @override
  Future<Set<String>> getSavedCardIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_savedKey)?.toSet() ?? {};
  }

  @override
  Future<void> toggleSaveCard(String cardId) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_savedKey)?.toSet() ?? {};
    if (saved.contains(cardId)) {
      saved.remove(cardId);
    } else {
      saved.add(cardId);
    }
    await prefs.setStringList(_savedKey, saved.toList());
  }

  @override
  Future<Set<String>> getSeenCardIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_seenKey)?.toSet() ?? {};
  }

  @override
  Future<void> markCardSeen(String cardId) async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getStringList(_seenKey)?.toSet() ?? {};
    seen.add(cardId);
    await prefs.setStringList(_seenKey, seen.toList());
  }
}
