import 'package:flash_fluent/custom-widgets/styled_button.dart';
import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/json_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Text(
        content,
        style: TextStyle(color: AppColours.foreground, fontSize: 18),
      ),
    );
  }
}

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
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
							Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: AppColours.foreground),
                ),

              Text(
                story.title,
                style: TextStyle(fontSize: 30, color: AppColours.foreground),
              ),
							IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.bookmark, color: AppColours.foreground),
                ),
							]),

							SizedBox(height: 10,),

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

							SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StyledButton(
                    text: "Previous",
                    func: () {
                      _controller.currentState?.previousPage();
                    },
                  ),
                  StyledButton(
                    text: "Next",
                    func: () {
                      _controller.currentState?.nextPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
