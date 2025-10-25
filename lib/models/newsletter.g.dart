// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsletterAdapter extends TypeAdapter<Newsletter> {
  @override
  final int typeId = 0;

  @override
  Newsletter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Newsletter(
      title: fields[0] as String,
      description: fields[1] as String,
      link: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Newsletter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsletterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
