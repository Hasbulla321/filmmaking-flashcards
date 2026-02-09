abstract class StorageService {
  Future<Set<String>> getSavedCardIds();
  Future<void> toggleSaveCard(String cardId);
  Future<Set<String>> getSeenCardIds();
  Future<void> markCardSeen(String cardId);
}
