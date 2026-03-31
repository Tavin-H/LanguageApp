import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/dictionary_database.dart';
import 'package:flash_fluent/utils/user_data.dart';
import 'package:flutter/material.dart';

class IconStat extends StatelessWidget {
  const IconStat({super.key, required this.icon, required this.progress});
  final IconData icon;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30, color: AppColours.foreground),
        SizedBox(width: 10),
        Text(
          "$progress",
          style: TextStyle(
            color: AppColours.foreground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class CourseContainer extends StatelessWidget {
  const CourseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/images/korean_flag.png", height: 40),
        ),
        SizedBox(width: 20),
        Text(
          "한국어",
          style: TextStyle(
            color: AppColours.foreground,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20),
        Text(
          "(Korean)",
          style: TextStyle(color: AppColours.foreground, fontSize: 20),
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.chapter});
  final ChapterData chapter;

  final sidePadding = 20.0;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DictionaryDatabaseService _dictionaryService =
      DictionaryDatabaseService.instance;

  void _showCourses() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: Colors.transparent,
      // makes the top corners rounded
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColours.background2,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a course",
                style: TextStyle(
                  color: AppColours.orange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              CourseContainer(),
              SizedBox(height: 20),
              Text(
                "More coming soon...",
                style: TextStyle(color: AppColours.foreground),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  ChapterData selectedChapter = chapters[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /*
            FutureBuilder(
              future: _dictionaryService.queryWordInfo("걱정하다"),
              builder: (context, snapshot) {
                // 1. Check if we are still waiting for the database
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 2. Check if there was an error (like a SQL syntax error)
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                // 3. Check if we actually have data and it's not empty
                if (!snapshot.hasData) {
                  return const Center(child: Text("No entries found yet!"));
                }
                String english = "";
                List<String> examples = [];
                (english, examples) = snapshot.data!;
                //return Text(entries[0].english);
                return Expanded(
                  child: ListView.builder(
                    itemCount: examples.length,
                    itemBuilder: (context, index) {
                      return Row(children: [Text(examples[index])]);
                    },
                  ),
                );
              },
            ),
						*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.sidePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _showCourses();
                    },
                    icon: Icon(Icons.translate, color: AppColours.foreground),
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 28,
                      color: AppColours.foreground,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings, color: AppColours.foreground),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.sidePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Stats of the course
                      SizedBox(
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("assets/images/korean_flag.png"),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: widget.chapter.completedLessonCount,
                        builder: (context, count, child) {
                          return IconStat(
                            // Lessons completed
                            icon: Icons.school_rounded,
                            progress: count,
                          );
                        },
                      ),
                      // Lessons
                      ValueListenableBuilder(
                        valueListenable: widget.chapter.completedStoriesCount,
                        builder: (context, count, child) {
                          return IconStat(
                            icon: Icons.menu_book_rounded,
                            progress: count,
                          );
                        },
                      ),
                      IconStat(icon: Icons.mic, progress: 0),
                    ],
                  ),
                  SizedBox(height: 30),

                  /*
                  Center(
                    child: Text(
                      "Aquire -> Absorb -> Produce",
                      style: TextStyle(
                        color: AppColours.foreground,
                        fontSize: 18,
                      ),
                    ),
                  ),
									*/
                  SizedBox(height: 20),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 3,
                        color: AppColours.background2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Word of the day",
                            style: TextStyle(color: AppColours.foreground),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "걱정하다",
                                style: TextStyle(
                                  color: AppColours.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                "To worry",
                                style: TextStyle(
                                  color: AppColours.foreground,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(Icons.book, color: AppColours.foreground),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Weekly Goal",
                    style: TextStyle(
                      color: AppColours.foreground,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: AppColours.background2,
                  ),
                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              color: AppColours.foreground,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "7/12 Exercises",
                            style: TextStyle(
                              color: AppColours.foreground,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColours.background2,
                                  width: 3,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Change",
                                    style: TextStyle(
                                      color: AppColours.foreground,
                                    ),
                                  ),
                                  Icon(Icons.edit, color: AppColours.orange),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          value: 0.8,
                          strokeWidth: 6,
                          strokeCap: StrokeCap.round,
                          color: AppColours.orange,
                          backgroundColor: AppColours.background2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your learning",
                        style: TextStyle(
                          color: AppColours.foreground,
                          fontSize: 20,
                        ),
                      ),
Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColours.background,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColours.background2,
                            width: 3,
                          ),
                        ),
                        child: Center( child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton<ChapterData>(
                          value: selectedChapter,
                          focusColor: Colors.transparent,
                          onChanged: (newValue) {
                            setState(() {
                              selectedChapter = newValue!;
                              currentChapter = newValue;
                            });
                            print(newValue!.title);
                          },
                          hint: Text(
                            "Hello",
                            style: TextStyle(color: AppColours.foreground),
                          ),
                          icon: const SizedBox.shrink(),
                          borderRadius: BorderRadius.circular(10),
                          items: chapters.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color: (selectedChapter == item)
                                      ? AppColours.orange
                                      : AppColours.foreground,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ))),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 3,
                    width: double.infinity,
                    color: AppColours.background2,
                  ),

                  SizedBox(height: 20),
                  Text(
                    selectedChapter.title,
                    style: TextStyle(
                      color: AppColours.foreground,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: selectedChapter.completedCount,
                    builder: (context, count, child) {
                      return LinearProgressIndicator(
                        value:
                            count /
                            (widget.chapter.lessons.length +
                                widget.chapter.stories.length),
                        minHeight: 6,
                        backgroundColor: AppColours.background2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColours.orange,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: Text("")),

            Navbar(),
          ],
        ),
      ),
    );
  }
}
