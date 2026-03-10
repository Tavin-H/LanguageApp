import 'package:flash_fluent/utils/json_utils.dart';

class Flashcard {
  String front;
  String back;
  Flashcard({required this.front, required this.back});
}

class FlashcardDeck {
  String deckName;
  List<Flashcard> flashcards;
  FlashcardDeck({required this.flashcards, required this.deckName});
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
      Flashcard(front: "test", back: "test2"),
      Flashcard(front: "TEST", back: "TEST2"),
    ],
  ),
];

List<Bookmark> userBookmarks = [];
