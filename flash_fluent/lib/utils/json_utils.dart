import 'package:flutter/material.dart';

/*
class Lesson {
  final String title;
  final List<Component> components;
  Lesson({required this.title, required this.components});
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['lesson-name'],
      components: (json['components'] as List)
          .map((item) => Component.fromJson(item))
          .toList(),
    );
  }
}
*/
class Lesson {
  final String title;
  final List<Page> pages;
  Lesson({required this.title, required this.pages});
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
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

class Component {
  final String type;
  final String content;

  Component({required this.type, required this.content});

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(type: json['type'], content: json['content']);
  }
}

Widget convertJsonComponentToWidget(Component component) {
  switch (component.type) {
    case 'header':
      return Text(
        component.content,
        style: TextStyle(color: Colors.blue.shade500),
      );
    case 'paragraph':
      return Text(component.content, style: TextStyle(color: Colors.black));
    default:
      return Text("Unsuported type: ${component.type}");
  }
}
