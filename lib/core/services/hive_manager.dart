import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:habits_tracker/core/constants/constants.dart';

import 'package:habits_tracker/features/domain/entities/habit_entity.dart';
import 'package:habits_tracker/features/data/models/habit_model.dart';

final class HabitAdapter extends TypeAdapter<HabitModel> {
  @override
  int get typeId => 0;

  @override
  HabitModel read(final BinaryReader reader) {
    final String uid = reader.readString();
    final String title = reader.readString();
    final String description = reader.readString();
    final int type = reader.readInt();
    final int priority = reader.readInt();
    final int date = reader.readInt();
    final int count = reader.readInt();
    final int frequency = reader.readInt();
    final List<int> doneDates = reader.readIntList();
    final int color = reader.readInt();

    return HabitModel(
      uid: uid,
      title: title,
      description: description,
      type: HabitType.values[type],
      priority: Priority.values[priority],
      date: date,
      count: count,
      frequency: frequency,
      doneDates: doneDates,
      color: color,
    );
  }

  @override
  void write(final BinaryWriter writer, final HabitModel obj) {
    writer.writeString(obj.uid);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeInt(obj.type.index);
    writer.writeInt(obj.priority.index);
    writer.writeInt(obj.date);
    writer.writeInt(obj.count);
    writer.writeInt(obj.frequency);
    writer.writeIntList(obj.doneDates);
    writer.writeInt(obj.color);
  }
}

/// Hive database manager
final class HiveManager {
  static const HiveManager instance = HiveManager._();

  const HiveManager._();

  static Future<Box<HabitModel>> get habitsBox async =>
      await instance.openHabitBox();

  Future<Box<T>> _openBox<T>({
    required final String name,
    required final int typeId,
    required final TypeAdapter<T> adapter,
  }) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }

    return Hive.openBox<T>(name);
  }

  Future<Box<HabitModel>> openHabitBox() {
    return _openBox<HabitModel>(
      name: Constants.habitBoxName,
      typeId: 0,
      adapter: HabitAdapter(),
    );
  }
}
