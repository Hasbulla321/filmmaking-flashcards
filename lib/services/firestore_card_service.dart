import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard.dart';
import 'card_service.dart';

class FirestoreCardService implements CardService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('flashcards');

  List<Flashcard>? _cache;

  @override
  Future<List<Flashcard>> getAllCards() async {
    if (_cache != null) return _cache!;

    final snapshot = await _collection.orderBy('order').get();
    _cache = snapshot.docs.map((doc) => Flashcard.fromFirestore(doc)).toList();
    return _cache!;
  }

  @override
  Future<List<Flashcard>> getCardsByCategory(String category) async {
    final all = await getAllCards();
    if (category == 'All') return all;
    return all.where((card) => card.cat == category).toList();
  }
}
