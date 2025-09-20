import 'dart:math';

import 'package:business_card/screens/home%20screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String noteTitle;
  @HiveField(1)
  late String noteText;
  @HiveField(2)
  late Color noteColor;
  @HiveField(3)
  bool isFavourite = false;
  Note(
      {required this.noteTitle,
      required this.noteText,
      required this.noteColor});
}
