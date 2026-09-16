import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskStatus { pending, compelete, due }

@freezed
abstract class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    required String title,
    @Default(TaskStatus.pending) TaskStatus? status,
    @Default("") String description,
    @DateDBConverter() required DateTime createdAt,
    @DateDBConverter() required DateTime updatedAt,
  }) = _Task;

  static Task get empty => Task(
    id: Uuid().v4().toString(),
    title: "",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}

class DateDBConverter extends JsonConverter<DateTime, String> {
  const DateDBConverter();
  @override
  DateTime fromJson(String json) => DateTime.now();

  @override
  String toJson(DateTime object) => object.toString();
}
