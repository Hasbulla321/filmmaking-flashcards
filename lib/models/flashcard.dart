import 'package:cloud_firestore/cloud_firestore.dart';

class Flashcard {
  final String id;
  final String cat;
  final String title;
  final String desc;
  final String film;
  final String tryThis;
  final String icon;
  final int order;

  const Flashcard({
    required this.id,
    required this.cat,
    required this.title,
    required this.desc,
    required this.film,
    required this.tryThis,
    required this.icon,
    this.order = 0,
  });

  factory Flashcard.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Flashcard(
      id: doc.id,
      cat: data['cat'] ?? '',
      title: data['title'] ?? '',
      desc: data['desc'] ?? '',
      film: data['film'] ?? '',
      tryThis: data['tryThis'] ?? '',
      icon: data['icon'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'cat': cat,
      'title': title,
      'desc': desc,
      'film': film,
      'tryThis': tryThis,
      'icon': icon,
      'order': order,
    };
  }
}
