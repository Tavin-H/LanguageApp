import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class FlashcardDeckContainer extends StatelessWidget {
  final FlashcardDeck deck;
  const FlashcardDeckContainer({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(deck.deckName),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/flashcard_practice',
              arguments: deck,
            );
          },
          child: Text("Practice"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/flashcard_practice',
              arguments: deck,
            );
          },
          child: Text("Custom Practice"),
        ),
      ],
    );
  }
}

class FlashcardHub extends StatefulWidget {
  const FlashcardHub({super.key});

  @override
  State<FlashcardHub> createState() => _FlashcardHubState();
}

class _FlashcardHubState extends State<FlashcardHub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Flashcard Hub"),
            Expanded(
              child: ListView.builder(
                itemCount: flashcardDecks.length,
                itemBuilder: (context, index) =>
                    FlashcardDeckContainer(deck: flashcardDecks[index]),
              ),
            ),

            Navbar(),
          ],
        ),
      ),
    );
  }
}
