import 'package:flash_fluent/screens/dictionary_screen.dart';
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

Future<ChapterData> loadChapterData(String chapterLocation) async {
  final UserSaveSerice _saveService = UserSaveSerice.instance;
  final String response = await rootBundle.loadString(
    'assets/$chapterLocation',
  );
  final Map<String, dynamic> data = json.decode(response);

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
  int bookmarked = 0;
  int completedLessonCount = 0;
  int completedStoryCount = 0;
  for (int i = 0; i < minLength; i++) {
    print("adding ${vocabLessons[i].title}");
    (completed, bookmarked) = await _saveService.queryLessonInfo(
      vocabLessons[i].title,
    );
    if (completed == 1) {
      print("Found lesson data!");
      vocabLessons[i].completed.value = true;
      completedLessonCount += 1;
    }
    if (bookmarked == 1) {
      print("Found a bookmark");
      lessonBookmarks.value.add(vocabLessons[i]);
    }

    print("adding ${grammarLessons[i].title}");
    (completed, bookmarked) = await _saveService.queryLessonInfo(
      grammarLessons[i].title,
    );
    if (completed == 1) {
      print("Found grammar data!");
      grammarLessons[i].completed.value = true;
      completedLessonCount += 1;
    }
    if (bookmarked == 1) {
      print("Found a bookmark");
      lessonBookmarks.value.add(grammarLessons[i]);
    }

    allLessons.add(grammarLessons[i]);
    allLessons.add(vocabLessons[i]);
  }

  //Add the rest
  List<Lesson> remainingVocabs = vocabLessons.sublist(minLength);
  for (int i = 0; i < remainingVocabs.length; i++) {
    (completed, bookmarked) = await _saveService.queryLessonInfo(
      remainingVocabs[i].title,
    );
    print("adding ${remainingVocabs[i].title}");
    if (completed == 1) {
      print("Found vocab data!");
      remainingVocabs[i].completed.value = true;
      completedLessonCount += 1;
    }
    if (bookmarked == 1) {
      print("Found a bookmark");
      lessonBookmarks.value.add(remainingVocabs[i]);
    }
    allLessons.add(remainingVocabs[i]);
  }

  List<Lesson> remainingGrammar = grammarLessons.sublist(minLength);
  for (int i = 0; i < remainingGrammar.length; i++) {
    (completed, bookmarked) = await _saveService.queryLessonInfo(
      remainingGrammar[i].title,
    );
    print("adding ${remainingGrammar[i].title}");
    if (completed == 1) {
      print("Found grammar data!");
      remainingGrammar[i].completed.value = true;
      completedLessonCount += 1;
    }
    if (bookmarked == 1) {
      print("Found a bookmark");
      lessonBookmarks.value.add(remainingGrammar[i]);
    }

    allLessons.add(remainingGrammar[i]);
  }

  final List<Story> stories = (data['stories'] as List)
      .map((s) => Story.fromJson(s))
      .toList();
  for (int i = 0; i < stories.length; i++) {
    (completed, bookmarked) = await _saveService.queryLessonInfo(
      stories[i].title,
    );
    if (completed == 1) {
      stories[i].completed.value = true;
      completedStoryCount += 1;
    }
    if (bookmarked == 1) {
      print("Found completed story ${stories[i].title}");
      storyBookmarks.value.add(stories[i]);
    }
  }

  ChapterData chapter = ChapterData(
    title: data['title'],
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
  /*
	UNCOMMENT TO PURGE DATABASE
  final UserSaveSerice _saveService = UserSaveSerice.instance;
  _saveService.purgeData();
	*/

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Android
      //statusBarBrightness: Brightness.dark,      // iOS
    ),
  );
  ChapterData chapter = await loadChapterData("chapter1.json");
  ChapterData chapter2 = await loadChapterData("chapter2.json");

  chapters.add(chapter);
  chapters.add(chapter2);
  currentChapter = chapter;
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
          textSelectionTheme: TextSelectionThemeData(),
          appBarTheme: AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle.light, // Makes status bar icons white
          ),
          scaffoldBackgroundColor: AppColours.background,
          canvasColor: AppColours.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColours.blue,
            surface: AppColours.background,
            onSurface: AppColours.foreground,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(chapter: chapters[0]),

          //Intermediate screens
          '/learn': (context) => LearnScreen(chapter: currentChapter!),
          '/explore': (context) => ExploreScreen(chapter: currentChapter!),
          '/flashcard_hub': (context) => const FlashcardHub(),

          //Action sceens
          '/lesson': (context) => const LearnLesson(),
          '/flashcard_practice': (context) => const FlashcardPractice(),
          '/bookmarks': (context) => const WorkshopScreen(),
          '/story': (context) => const StoryScreen(),
          '/practice': (context) => PracticeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/dictionary': (context) => DictionaryScreen(),
        },
      ),
    );
  }
}
