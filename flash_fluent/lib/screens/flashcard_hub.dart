import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class FlashcardDeckContainer extends StatelessWidget {
  final FlashcardDeck deck;
  const FlashcardDeckContainer({super.key, required this.deck});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColours.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColours.background2, width: 3),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(18, 0, 7, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deck.deckName,
                style: TextStyle(fontSize: 18, color: AppColours.foreground),
              ),
              StyledButton(
                text: "Review",
                func: () {
                  Navigator.pushNamed(
                    context,
                    '/flashcard_practice',
                    arguments: deck,
                  );
                },
              ),
            ],
          ),
        ),
      ),
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
            Text(
              "Flashcard Hub",
              style: TextStyle(color: AppColours.foreground, fontSize: 24),
            ),
            SizedBox(height: 20),
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
