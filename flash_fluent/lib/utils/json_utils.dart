import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flutter/material.dart';

enum LessonType { grammar, vocab }

class Lesson {
  final String title;
  final List<Page> pages;
  final LessonType type;
  ValueNotifier<bool> completed;
  Lesson({
    required this.title,
    required this.pages,
    required this.type,
    bool isCompleted = false,
  }) : completed = ValueNotifier(isCompleted);
  factory Lesson.fromJson(Map<String, dynamic> json, type) {
    return Lesson(
      type: type,
      title: json['lesson-name'],
      pages: (json['pages'] as List)
          .map((item) => Page.fromJson(item))
          .toList(),
    );
  }
}

class Page {
  final List<Component> components;
  Page({required this.components});
  factory Page.fromJson(Map<String, dynamic> json) {
    return Page(
      components: (json['components'] as List)
          .map((item) => Component.fromJson(item))
          .toList(),
    );
  }
}

abstract class Component {
  final String type;
  final double bottomMargin;

  Component({required this.type, required this.bottomMargin});

  factory Component.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'padding':
        return PaddingComponent.fromJson(json);
      case 'header':
        return HeaderComponent.fromJson(json);
      case 'paragraph':
        return ParagraphComponent.fromJson(json);
      case 'sentence':
        return SentenceComponent.fromJson(json);
      case 'highlight':
        return HighlightComponent.fromJson(json);
      case 'mini-quiz':
        return MiniQuizComponent.fromJson(json);
      case 'translated-group':
        return TranslatedGroupComponent.fromJson(json);
      default:
        throw Exception('Unkown component type: ${json['type']}');
    }
  }
}

class PaddingComponent extends Component {
  PaddingComponent({required double margin})
    : super(type: 'padding', bottomMargin: margin);
  factory PaddingComponent.fromJson(Map<String, dynamic> json) {
    return PaddingComponent(margin: json['height'].toDouble());
  }
}

class HeaderComponent extends Component {
  final String content;
  HeaderComponent({required this.content})
    : super(type: 'header', bottomMargin: 15);
  factory HeaderComponent.fromJson(Map<String, dynamic> json) {
    return HeaderComponent(content: json['content']);
  }
}

class ParagraphComponent extends Component {
  final String content;
  ParagraphComponent({required this.content})
    : super(type: 'paragraph', bottomMargin: 20);
  factory ParagraphComponent.fromJson(Map<String, dynamic> json) {
    return ParagraphComponent(content: json['content']);
  }
}

class SentenceComponent extends Component {
  final String target;
  final String source;
  SentenceComponent({required this.target, required this.source})
    : super(type: 'sentence', bottomMargin: 10);
  factory SentenceComponent.fromJson(Map<String, dynamic> json) {
    return SentenceComponent(target: json['target'], source: json['source']);
  }
}

class HighlightComponent extends Component {
  final String content;
  HighlightComponent({required this.content})
    : super(type: 'highlight', bottomMargin: 10);
  factory HighlightComponent.fromJson(Map<String, dynamic> json) {
    return HighlightComponent(content: json['content']);
  }
}

class TranslatedGroupComponent extends Component {
  final List<String> targetWords;
  final List<String> sourceWords;
  TranslatedGroupComponent({
    required this.targetWords,
    required this.sourceWords,
  }) : super(type: 'translated-group', bottomMargin: 20);
  factory TranslatedGroupComponent.fromJson(Map<String, dynamic> json) {
    return TranslatedGroupComponent(
      sourceWords: List<String>.from(json['source']),
      targetWords: List<String>.from(json['target']),
    );
  }
}

class MiniQuizComponent extends Component {
  final String question;
  final List<String> options;
  MiniQuizComponent({required this.question, required this.options})
    : super(type: 'mini-quiz', bottomMargin: 10);
  factory MiniQuizComponent.fromJson(Map<String, dynamic> json) {
    return MiniQuizComponent(
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }
}

class MiniQuizWidget extends StatefulWidget {
  const MiniQuizWidget({super.key, required this.c});
  final MiniQuizComponent c;

  @override
  State<MiniQuizWidget> createState() => _MiniQuizWidgetState();
}

class _MiniQuizWidgetState extends State<MiniQuizWidget> {
  String displayMessage = "";
  Color displayColor = AppColours.blue;
  late List<String> shuffledOptions;
  @override
  void initState() {
    super.initState();
    shuffledOptions = List<String>.from(widget.c.options)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.c.question, style: TextStyle(color: AppColours.foreground)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...shuffledOptions.map(
              (option) => StyledButton(
                text: option,
                func: () {
                  if (option == widget.c.options[0]) {
                    setState(() {
                      displayMessage = "Correct!";
                      displayColor = AppColours.blue;
                    });
                  } else {
                    setState(() {
                      displayMessage = "Wrong";
                      displayColor = AppColours.orange;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        Text(displayMessage, style: TextStyle(color: displayColor)),
      ],
    );
  }
}

//Now define the styles of these
Widget convertJsonComponentToWidget(Component component) {
  switch (component.type) {
    case 'padding':
      return SizedBox(height: component.bottomMargin);
    case 'header':
      final c = component as HeaderComponent;
      return Text(
        c.content,
        style: TextStyle(
          fontSize: 24,
          color: AppColours.blue,
          fontWeight: FontWeight.bold,
        ),
      );
    case 'paragraph':
      final c = component as ParagraphComponent;
      return Text(
        c.content,
        style: TextStyle(fontSize: 15, color: AppColours.foreground),
      );
    case 'sentence':
      final c = component as SentenceComponent;
      return Container(
        decoration: BoxDecoration(),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.target,
                style: TextStyle(
                  color: AppColours.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(c.source, style: TextStyle(color: AppColours.foreground2)),
            ],
          ),
        ),
      );
    case 'highlight':
      final c = component as HighlightComponent;
      return Column(
        children: [
          Text(
            c.content,
            style: TextStyle(
              fontSize: 18,
              color: AppColours.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    case 'mini-quiz':
      final c = component as MiniQuizComponent;
      return MiniQuizWidget(c: c);
    case 'translated-group':
      final c = component as TranslatedGroupComponent;

      return 
			Center(child: 

			Wrap(
			alignment: WrapAlignment.center,
				runSpacing: 5,
				spacing: 20,
        children: [

					for (int i = 0; i < c.targetWords.length; i++) 
						Column(children: [
						Text(c.targetWords[i], style: TextStyle(color: AppColours.orange, fontSize: 18, fontWeight: FontWeight.bold)),
						Text(c.sourceWords[i], style: TextStyle(color: AppColours.foreground),)
						])

					],
      ));

    default:
      return Text(
        "Unsuported type: ${component.type}",
        style: TextStyle(color: Colors.red),
      );
  }
}

class StoryPage {
  final String content;
  StoryPage({required this.content});
}

class Question {
  String question;
  List<String> options;
  String relaventLine;
  Question({
    required this.question,
    required this.options,
    required this.relaventLine,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      relaventLine: json['relavent-line'],
      options: List<String>.from(json['options']),
    );
  }
}

class Story {
  final String title;
  final List<StoryPage> storyPages;
  final List<Question> questions;
  ValueNotifier<bool> completed;

  Story({
    required this.title,
    required this.storyPages,
    required this.questions,
    bool isCompleted = false,
  }) : completed = ValueNotifier(isCompleted);

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json['story-name'],
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
      storyPages: (json['pages'] as List)
          .map((item) => StoryPage(content: item))
          .toList(),
    );
  }
}
