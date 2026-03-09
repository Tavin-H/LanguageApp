import 'package:flash_fluent/utils/json_utils.dart';

class Bookmark {
  int page;
  Lesson lesson;

  Bookmark({required this.page, required this.lesson});
}

List<Bookmark> userBookmarks = [];
