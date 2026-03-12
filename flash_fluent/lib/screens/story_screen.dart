import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';

enum ReadingState { reading, testing }

class PageContainer extends StatelessWidget {
  const PageContainer({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Text(
        content,
        style: TextStyle(color: AppColours.foreground, fontSize: 18),
      ),
    );
  }
}

class QuestionContainer extends StatefulWidget {
  const QuestionContainer({super.key, required this.questionObject});
  final Question questionObject;

  @override
  State<QuestionContainer> createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  late List<String> shuffledOptions;
  late bool showHint;
  @override
  void initState() {
    super.initState();
    shuffledOptions = List<String>.from(widget.questionObject.options)
      ..shuffle();
    showHint = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.questionObject.question,
          style: TextStyle(color: AppColours.foreground),
        ),

        ...shuffledOptions.map(
          (option) => StyledButton(
            text: option,
            func: () {
              if (option == widget.questionObject.options[0]) {
                setState(() {
                  //Correct!
                  showHint = false;
                });
              } else {
                //Wrong :(
                setState(() {
                  showHint = true;
                });
              }
            },
          ),
        ),
        if (showHint) ...[
          Text("Hint:", style: TextStyle(color: AppColours.foreground)),

          Text(
            widget.questionObject.relaventLine,
            style: TextStyle(color: AppColours.foreground),
          ),
        ],
      ],
    );
  }
}

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  int page = 0;
  late ReadingState state;

  @override
  void initState() {
    state = ReadingState.reading;
    super.initState();
  }

  final _controller = GlobalKey<PageFlipWidgetState>();
  @override
  Widget build(BuildContext context) {
    final Story story = ModalRoute.of(context)!.settings.arguments as Story;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: AppColours.foreground),
                  ),

                  Text(
                    story.title,
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColours.foreground,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.bookmark, color: AppColours.foreground),
                  ),
                ],
              ),

              SizedBox(height: 10),

              if (state == ReadingState.reading)
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: PageFlipWidget(
                      key: _controller,
                      backgroundColor: AppColours.background2,
                      children: [
                        ...story.storyPages.map(
                          (page) => PageContainer(content: page.content),
                        ),
                      ],
                    ),
                  ),
                ),

              if (state == ReadingState.reading) SizedBox(height: 20),

              if (state == ReadingState.reading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StyledButton(
                      text: "Previous",
                      func: () {
                        if (page > 0) {
                          page--;
                        }
                        _controller.currentState?.previousPage();
                      },
                    ),
                    StyledButton(
                      text: "Next",
                      func: () {
                        if (page < story.storyPages.length - 1) {
                          page++;
                          _controller.currentState?.nextPage();
                        } else {
                          setState(() {
                            state = ReadingState.testing;
                          });
                        }
                      },
                    ),
                  ],
                ),
              if (state == ReadingState.testing)
                Expanded(
                  child: ListView.builder(
                    itemCount: story.questions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: QuestionContainer(
                          questionObject: story.questions[index],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
