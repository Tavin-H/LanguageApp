import 'package:flash_fluent/screens/bookmarks_screen.dart';
import 'package:flash_fluent/screens/flashcard_hub.dart';
import 'package:flash_fluent/screens/flashcard_practice.dart';
import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/screens/learn_screen.dart';
import 'package:flash_fluent/screens/explore_screen.dart';
import 'package:flash_fluent/screens/learn_lesson.dart';
import 'package:flash_fluent/screens/practice_screen.dart';
import 'package:flash_fluent/screens/story_screen.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

/////dart format .

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android
      //statusBarBrightness: Brightness.dark,      // iOS
    ),
  );
  final String response = await rootBundle.loadString('assets/lessons.json');
  final String storyResponse = await rootBundle.loadString(
    'assets/stories.json',
  );
  final Map<String, dynamic> data = json.decode(response);
  final List<dynamic> storyData = json.decode(storyResponse);

  final List<dynamic> rawGrammarLessons = data['grammar-lessons'] as List;
  List<Lesson> grammarLessons = rawGrammarLessons
      .map((l) => Lesson.fromJson(l, LessonType.grammar))
      .toList();

  final List<dynamic> rawVocabLessons = data['vocab-lessons'] as List;
  List<Lesson> vocabLessons = rawVocabLessons
      .map((l) => Lesson.fromJson(l, LessonType.vocab))
      .toList();

  final List<Lesson> allLessons = [];

  final int minLength = grammarLessons.length < vocabLessons.length
      ? grammarLessons.length
      : vocabLessons.length;

  for (int i = 0; i < minLength; i++) {
    allLessons.add(vocabLessons[i]);
    allLessons.add(grammarLessons[i]);
  }
  allLessons.addAll(vocabLessons.sublist(minLength));
  allLessons.addAll(grammarLessons.sublist(minLength));

  List<Story> stories = storyData.map((s) => Story.fromJson(s)).toList();

  chapters.add(
    ChapterData(
      title: "Chapter 1",
      lessons: allLessons,
      stories: stories,
      completedLessonCount: ValueNotifier(0),
      completedStoriesCount: ValueNotifier(0),
    ),
  );
  runApp(
    MyApp(
      grammarLessons: grammarLessons,
      vocabLessons: vocabLessons,
      allLessons: allLessons,
      stories: stories,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.grammarLessons,
    required this.vocabLessons,
    required this.allLessons,
    required this.stories,
  });

  final List<Lesson> grammarLessons;
  final List<Lesson> vocabLessons;
  final List<Lesson> allLessons;
  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark, // iOS
      ),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle.light, // Makes status bar icons white
          ),
          scaffoldBackgroundColor: AppColours.background,
          canvasColor: AppColours.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColours.blue,
            surface: AppColours.background,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(chapter: chapters[0]),

          //Intermediate screens
          '/learn': (context) => LearnScreen(chapter: chapters[0]),
          '/explore': (context) => ExploreScreen(chapter: chapters[0]),
          '/flashcard_hub': (context) => const FlashcardHub(),

          //Action sceens
          '/lesson': (context) => const LearnLesson(),
          '/flashcard_practice': (context) => const FlashcardPractice(),
          '/bookmarks': (context) => const BookmarksScreen(),
          '/story': (context) => const StoryScreen(),
          '/practice': (context) => PracticeScreen(),
        },
      ),
    );
  }
}
