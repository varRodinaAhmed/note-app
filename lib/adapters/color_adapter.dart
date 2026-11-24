import 'package:hive/hive.dart';
import 'dart:ui' show Color;

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 99;

  @override
  Color read(BinaryReader reader) {
    final value = reader.readUint32();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeUint32(obj.value);
  }
}
