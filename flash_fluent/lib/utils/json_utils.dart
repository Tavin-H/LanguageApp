import 'package:flash_fluent/utils/app_consts.dart';
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

abstract class Component {
  final String type;
  final double bottomMargin;

  Component({required this.type, required this.bottomMargin});

  factory Component.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'header':
        return HeaderComponent.fromJson(json);
      case 'paragraph':
        return ParagraphComponent.fromJson(json);
      case 'sentence':
        return SentenceComponent.fromJson(json);
      case 'highlight':
        return HighlightComponent.fromJson(json);
      default:
        throw Exception('Unkown component type: ${json['type']}');
    }
  }
}

class HeaderComponent extends Component {
  final String content;
  HeaderComponent({required this.content})
    : super(type: 'header', bottomMargin: 15);
  factory HeaderComponent.fromJson(Map<String, dynamic> json) {
    return HeaderComponent(content: json['content']);
  }
}

class ParagraphComponent extends Component {
  final String content;
  ParagraphComponent({required this.content})
    : super(type: 'paragraph', bottomMargin: 10);
  factory ParagraphComponent.fromJson(Map<String, dynamic> json) {
    return ParagraphComponent(content: json['content']);
  }
}

class SentenceComponent extends Component {
  final String target;
  final String source;
  SentenceComponent({required this.target, required this.source})
    : super(type: 'sentence', bottomMargin: 10);
  factory SentenceComponent.fromJson(Map<String, dynamic> json) {
    return SentenceComponent(target: json['target'], source: json['source']);
  }
}

class HighlightComponent extends Component {
  final String content;
  HighlightComponent({required this.content})
    : super(type: 'highlight', bottomMargin: 10);
  factory HighlightComponent.fromJson(Map<String, dynamic> json) {
    return HighlightComponent(content: json['content']);
  }
}

//Now define the styles of these
Widget convertJsonComponentToWidget(Component component) {
  switch (component.type) {
    case 'header':
      final c = component as HeaderComponent;
      return Text(
        c.content,
        style: TextStyle(fontSize: 24, color: Colors.blue.shade500, fontWeight: FontWeight.bold),
      );
    case 'paragraph':
      final c = component as ParagraphComponent;
      return Text(c.content, style: TextStyle(fontSize: 15));
    case 'sentence':
      final c = component as SentenceComponent;
      return Container(
        decoration: BoxDecoration(),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.target,
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(c.source),
            ],
          ),
        ),
      );
    case 'highlight':
      final c = component as HighlightComponent;
      return Column(
        children: [
          Text(
            c.content,
            style: TextStyle(fontSize: 18, color: AppColours.accent1, fontWeight: FontWeight.bold),
          ),
        ],
      );
    default:
      return Text("Unsuported type: ${component.type}", style: TextStyle(color: Colors.red),);
  }
}
