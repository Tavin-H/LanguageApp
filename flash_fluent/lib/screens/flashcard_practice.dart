import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class FlashcardPractice extends StatefulWidget {
  const FlashcardPractice({super.key});

  @override
  State<FlashcardPractice> createState() => _FlashcardPracticeState();
}

class _FlashcardPracticeState extends State<FlashcardPractice> {
  late int currentCardIndex;
  late bool flipped;
  @override
  void initState() {
    currentCardIndex = 0;
    flipped = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlashcardDeck deck =
        ModalRoute.of(context)!.settings.arguments as FlashcardDeck;
    void logFlashcardDifficulty() {
      setState(() {
        if (currentCardIndex < deck.flashcards.length - 1) {
          currentCardIndex++;
        	flipped = false;
        } else {
				Navigator.pop(context);
				}
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Reviewing ${deck.deckName}"),
              Text(!flipped ? "??" : deck.flashcards[currentCardIndex].back),
              flipped
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            logFlashcardDifficulty();
                          },
                          child: Text("Easy"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            logFlashcardDifficulty();
                          },
                          child: Text("Medium"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            logFlashcardDifficulty();
                          },
                          child: Text("Hard"),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flipped = true;
                        });
                      },
                      child: Text("Flip"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
