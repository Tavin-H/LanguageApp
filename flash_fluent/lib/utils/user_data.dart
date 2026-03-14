import 'package:flash_fluent/utils/json_utils.dart';

enum FlashcardType { vocab, grammar }

class Flashcard {
  String front;
  String back;
  FlashcardType type;
  Flashcard({required this.front, required this.back, required this.type});
}

class FlashcardDeck {
  String deckName;
  List<Flashcard> flashcards;
  FlashcardDeck({required this.flashcards, required this.deckName});

  // Tries to add it to this deck but will not make a copy
  void tryAdd(Flashcard flashcard) {
    if (flashcards.contains(flashcard)) {
      return;
    }
    flashcards.add(flashcard);
  }
}

class Bookmark {
  int page;
  Lesson lesson;
  Bookmark({required this.page, required this.lesson});
}

List<FlashcardDeck> flashcardDecks = [
  FlashcardDeck(
    deckName: "test deck",
    flashcards: [
      Flashcard(front: "test", back: "test2", type: FlashcardType.vocab),
      Flashcard(front: "TEST", back: "TEST2", type: FlashcardType.grammar),
    ],
  ),
];

List<Bookmark> userBookmarks = [];

class ChapterData {}
