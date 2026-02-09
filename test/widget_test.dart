import 'package:flutter_test/flutter_test.dart';
import 'package:filmmaking_flashcards/models/flashcard.dart';

void main() {
  test('Flashcard model creates from map correctly', () {
    final card = Flashcard(
      id: 's1',
      cat: 'Story',
      title: 'The Rashomon Effect',
      desc: 'Test description',
      film: 'Rashomon (1950)',
      tryThis: 'Try this challenge',
      icon: '\u{1F4D6}',
      order: 1,
    );

    expect(card.id, 's1');
    expect(card.cat, 'Story');
    expect(card.title, 'The Rashomon Effect');
    expect(card.order, 1);
  });

  test('Flashcard toFirestore produces correct map', () {
    final card = Flashcard(
      id: 's1',
      cat: 'Story',
      title: 'Test',
      desc: 'Desc',
      film: 'Film',
      tryThis: 'Try',
      icon: '\u{1F4D6}',
      order: 1,
    );

    final map = card.toFirestore();
    expect(map['cat'], 'Story');
    expect(map['title'], 'Test');
    expect(map['order'], 1);
    expect(map.containsKey('id'), false);
  });
}
