import 'package:flash_fluent/custom-widgets/navbar.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/dictionary_database.dart';
import 'package:flutter/material.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final DictionaryDatabaseService _dictionaryService =
      DictionaryDatabaseService.instance;

  String english = "";
	String korean = "";
  List<String> examples = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Korean - English Dictionary",
              style: TextStyle(color: AppColours.foreground, fontSize: 20),
            ),
						SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: AppColours.background2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter a Korean word",
                            hintStyle: TextStyle(color: AppColours.foreground),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: AppColours.foreground),
                          onSubmitted: (String value) async {
                            print(value);
                            final (englishResult, examplesResult) =
                                await _dictionaryService.queryWordInfo(value);
                            setState(() {
														korean = value;
                              english = englishResult;
                              examples = examplesResult;
                            });
                          },
                        ),
                      ),
                    ),
										SizedBox(height: 20,),
										Row(children: [
										Text("Korean: ", style: TextStyle(color: AppColours.orange, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      korean,
                      style: TextStyle(color: AppColours.foreground, fontSize: 18),
                    ),
										],),

										Row(children: [
										Text("Meaning: ", style: TextStyle(color: AppColours.orange, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      english,
                      style: TextStyle(color: AppColours.foreground, fontSize: 18),
                    ),
										],),
										SizedBox(height: 20,),
                    
                    Text(
                      "Examples:",
                      style: TextStyle(color: AppColours.orange, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: examples.length,
                        itemBuilder: (context, index) {
                          return Text(
                            examples[index],
                            style: TextStyle(color: AppColours.foreground),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
						Navbar()
          ],
        ),
      ),
    );
  }
}
