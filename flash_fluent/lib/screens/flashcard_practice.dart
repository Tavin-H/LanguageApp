import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class FlashcardPractice extends StatefulWidget {
  const FlashcardPractice({super.key});

  @override
  State<FlashcardPractice> createState() => _FlashcardPracticeState();
}

class _FlashcardPracticeState extends State<FlashcardPractice> {
  int currentCardIndex = 0;
  @override
  void initState() {
    currentCardIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlashcardDeck deck =
        ModalRoute.of(context)!.settings.arguments as FlashcardDeck;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [Text("Reviewing ${deck.deckName}")]),
      ),
    );
  }
}
