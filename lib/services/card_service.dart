import '../models/flashcard.dart';

abstract class CardService {
  Future<List<Flashcard>> getAllCards();
  Future<List<Flashcard>> getCardsByCategory(String category);
}
