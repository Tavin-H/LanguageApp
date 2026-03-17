import 'package:flash_fluent/screens/flashcard_hub.dart';
import 'package:flash_fluent/screens/flashcard_practice.dart';
import 'package:flash_fluent/screens/home_screen.dart';
import 'package:flash_fluent/screens/learn_screen.dart';
import 'package:flash_fluent/screens/explore_screen.dart';
import 'package:flash_fluent/screens/learn_lesson.dart';
import 'package:flash_fluent/screens/practice_screen.dart';
import 'package:flash_fluent/screens/profile_screen.dart';
import 'package:flash_fluent/screens/story_screen.dart';
import 'package:flash_fluent/screens/workshop_screen.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flash_fluent/utils/user_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

/////dart format .

Future<ChapterData> loadChapterData() async {
  final UserSaveSerice _saveService = UserSaveSerice.instance;
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

  int completed = 0;
  int completedLessonCount = 0;
  int completedStoryCount = 0;
  for (int i = 0; i < minLength; i++) {
    allLessons.add(vocabLessons[i]);
    completed = await _saveService.queryLessonCompletion(vocabLessons[i].title);
    if (completed == 1) {
      print("Found lesson data!");
      grammarLessons[i].completed.value = true;
      completedLessonCount += 1;
    }
    allLessons.add(grammarLessons[i]);
    completed = await _saveService.queryLessonCompletion(
      grammarLessons[i].title,
    );
    if (completed == 1) {
      print("Found story data!");
      grammarLessons[i].completed.value = true;
      completedLessonCount += 1;
    }
  }
  allLessons.addAll(vocabLessons.sublist(minLength));
  allLessons.addAll(grammarLessons.sublist(minLength));

  List<Story> stories = storyData.map((s) => Story.fromJson(s)).toList();
  for (int i = 0; i < stories.length; i++) {
    completed = await _saveService.queryLessonCompletion(stories[i].title);
    if (completed == 1) {
      stories[i].completed.value = true;
      completedStoryCount += 1;
    }
  }

  ChapterData chapter = ChapterData(
    title: "Chapter 1",
    lessons: allLessons,
    stories: stories,
    completedLessonCount: ValueNotifier(completedLessonCount),
    completedStoriesCount: ValueNotifier(completedStoryCount),
    completedCount: ValueNotifier(completedLessonCount + completedStoryCount),
  );

  return chapter;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android
      //statusBarBrightness: Brightness.dark,      // iOS
    ),
  );
  ChapterData chapter = await loadChapterData();

  chapters.add(chapter);
  runApp(MyApp(allLessons: chapters[0].lessons, stories: chapters[0].stories));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.allLessons, required this.stories});

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
          '/bookmarks': (context) => const WorkshopScreen(),
          '/story': (context) => const StoryScreen(),
          '/practice': (context) => PracticeScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
