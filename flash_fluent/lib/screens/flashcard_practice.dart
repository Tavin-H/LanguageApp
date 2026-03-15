import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlashCardContainer extends StatelessWidget {
  const FlashCardContainer({
    super.key,
    required this.controller,
    required this.flashcard,
  });
  final Flashcard flashcard;
  final FlipCardController controller;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      animationDuration: const Duration(milliseconds: 400),
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
            flashcard.front,
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
            flashcard.back,
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
  late FlipCardController controller;
  @override
  void initState() {
    currentCardIndex = 0;
    flipped = false;
    controller = FlipCardController();
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
          controller.flipcard();
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
              Text(
                "Reviewing ${deck.deckName}",
                style: TextStyle(color: AppColours.foreground, fontSize: 24),
              ),
              Expanded(
                child: Center(
                  child: FlashCardContainer(
                    controller: controller,
                    flashcard: deck.flashcards[currentCardIndex],
                    key: ValueKey(currentCardIndex),
                  ),
                ),
              ),
              flipped
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColours.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),

                          onPressed: () {
                            logFlashcardDifficulty();
                          },

                          icon: Icon(
                            Icons.signal_cellular_alt_1_bar_rounded,
                            color: AppColours.background,
                          ),

                          label: Text(
                            "Easy",
                            style: TextStyle(color: AppColours.background),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColours.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),

                          onPressed: () {
                            logFlashcardDifficulty();
                          },

                          icon: Icon(
                            Icons.signal_cellular_alt_2_bar_rounded,
                            color: AppColours.background,
                          ),

                          label: Text(
                            "Okay",
                            style: TextStyle(color: AppColours.background),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColours.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),

                          onPressed: () {
                            logFlashcardDifficulty();
                          },

                          icon: Icon(
                            Icons.signal_cellular_alt_rounded,
                            color: AppColours.background,
                          ),

                          label: Text(
                            "Hard",
                            style: TextStyle(color: AppColours.background),
                          ),
                        ),
                        SizedBox(width: 10),
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
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
