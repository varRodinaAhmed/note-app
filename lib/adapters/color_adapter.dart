import 'package:hive/hive.dart';
import 'dart:ui' show Color; // أو 'package:flutter/material.dart'

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 99; // رقم فريد (غير مستخدم قبل كده)

  @override
  Color read(BinaryReader reader) {
    final value = reader.readUint32(); // اقرأ الـ Color كـ int
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeUint32(obj.value); // اكتب الـ Color كـ int
  }
}
