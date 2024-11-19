// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_story_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStoryModelAdapter extends TypeAdapter<LocalStoryModel> {
  @override
  final int typeId = 1;

  @override
  LocalStoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStoryModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      bookId: fields[5] as String,
      bookTitle: fields[6] as String,
      category: fields[2] as String,
      content: fields[3] as String,
      date: fields[4] as DateTime,
      bookCoverImageUrl: fields[8] as String?,
      part: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStoryModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.bookId)
      ..writeByte(6)
      ..write(obj.bookTitle)
      ..writeByte(7)
      ..write(obj.part)
      ..writeByte(8)
      ..write(obj.bookCoverImageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
