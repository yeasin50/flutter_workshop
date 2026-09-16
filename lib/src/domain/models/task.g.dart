// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.pending,
  description: json['description'] as String? ?? "",
  createdAt: const DateDBConverter().fromJson(json['createdAt'] as String),
  updatedAt: const DateDBConverter().fromJson(json['updatedAt'] as String),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'status': _$TaskStatusEnumMap[instance.status],
  'description': instance.description,
  'createdAt': const DateDBConverter().toJson(instance.createdAt),
  'updatedAt': const DateDBConverter().toJson(instance.updatedAt),
};

const _$TaskStatusEnumMap = {
  TaskStatus.pending: 'pending',
  TaskStatus.compelete: 'compelete',
  TaskStatus.due: 'due',
};
