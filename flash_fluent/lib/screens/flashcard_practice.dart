import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlashCardContainer extends StatelessWidget {
  const FlashCardContainer({super.key, required this.controller});

  final FlipCardController controller;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      onTapFlipping: true,
      frontWidget: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColours.background,
          border: Border.all(color: AppColours.orange, width: 4),
        ),
        child: Center(
          child: Text(
            "걱정하다",
            style: TextStyle(
              color: AppColours.foreground,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backWidget: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColours.background,
          border: Border.all(color: AppColours.blue, width: 4),
        ),
        child: Center(
          child: Text(
            "To Worry",
            style: TextStyle(
              color: AppColours.foreground,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      controller: controller,
      rotateSide: RotateSide.right,
    );
  }
}

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

    final controller = FlipCardController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reviewing ${deck.deckName}",
                style: TextStyle(color: AppColours.foreground, fontSize: 24),
              ),
              Expanded(
                child: Center(
                  child: FlashCardContainer(controller: controller),
                ),
              ),
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
                  : StyledButton(
                      text: "Flip",
                      func: () {
                        setState(() {
                          controller.flipcard();
                          flipped = true;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
