import 'package:flutter/material.dart';

import 'package:flash_fluent/utils/app_consts.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/learn') {
                      Navigator.pushNamed(context, '/learn');
                    }
                  },
                  icon: Icon(
                    Icons.menu_book_rounded,
                    size: 40,
                    color: ModalRoute.of(context)?.settings.name == '/learn'
                        ? AppColours.orange
                        : AppColours.foreground,
                  ),
                ),
                Text("Learn", style: TextStyle(color: AppColours.foreground)),
              ],
            ),
          ),
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/practice') {
                      Navigator.pushNamed(context, '/practice');
                    }
                  },
                  icon: Icon(
                    Icons.edit_note,
                    size: 40,
                    color: ModalRoute.of(context)?.settings.name == '/practice'
                        ? AppColours.orange
                        : AppColours.foreground,
                  ),
                ),
                Text(
                  "Practice",
                  style: TextStyle(color: AppColours.foreground),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/');
                    if (ModalRoute.of(context)?.settings.name != '/') {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    }
                  },
                  icon: Icon(
                    Icons.home_rounded,
                    size: 40,
                    color: ModalRoute.of(context)?.settings.name == '/'
                        ? AppColours.orange
                        : AppColours.foreground,
                  ),
                ),
                Text("Home", style: TextStyle(color: AppColours.foreground)),
              ],
            ),
          ),
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (ModalRoute.of(context)?.settings.name != '/bookmarks') {
                      Navigator.pushNamed(context, '/bookmarks');
                    }
                  },
                  icon: Icon(
                    Icons.collections_bookmark,
                    size: 35,
                    color: ModalRoute.of(context)?.settings.name == '/bookmarks'
                        ? AppColours.orange
                        : AppColours.foreground,
                  ),
                ),
                Text(
                  "Workshop",
                  style: TextStyle(color: AppColours.foreground),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: 40,
                    color: ModalRoute.of(context)?.settings.name == '/profile'
                        ? AppColours.orange
                        : AppColours.foreground,
                  ),
                ),
                Text("Profile", style: TextStyle(color: AppColours.foreground)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
