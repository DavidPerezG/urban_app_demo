// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      json['id'] as String,
      Task._documentReferenceListFromJson(json['commentsReferences'] as List?),
      DateTime.parse(json['createdAt'] as String),
      Task._documentReferenceFromJson(json['intakeReference']),
      Task._documentReferenceFromJson(json['moodboardReference']),
      json['name'] as String,
      Task._documentReferenceFromJson(json['proyectReference']),
      Task._documentReferenceFromJson(json['questionnaireReference']),
      Task._documentReferenceFromJson(json['renderingReference']),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'commentsReferences':
          Task._documentReferenceListToJson(instance.commentsReferences),
      'createdAt': instance.createdAt.toIso8601String(),
      'intakeReference':
          Task._documentReferenceToJson(instance.intakeReference),
      'moodboardReference':
          Task._documentReferenceToJson(instance.moodboardReference),
      'name': instance.name,
      'proyectReference':
          Task._documentReferenceToJson(instance.proyectReference),
      'questionnaireReference':
          Task._documentReferenceToJson(instance.questionnaireReference),
      'renderingReference':
          Task._documentReferenceToJson(instance.renderingReference),
    };
