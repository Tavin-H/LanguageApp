import 'package:flutter/material.dart';

class Lesson {
  final List<Component> components;
  Lesson({required this.components});
  factory Lesson.fromJson(List<dynamic> jsonList) {
    return Lesson(
      components: jsonList.map((item) => Component.fromJson(item)).toList(),
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
    case 'title':
      return Text(
        component.content,
        style: TextStyle(color: Colors.blue.shade500),
      );
    case 'paragraph':
      return Text(component.content, style: TextStyle(color: Colors.black));
  }
  return Text("Test");
}
