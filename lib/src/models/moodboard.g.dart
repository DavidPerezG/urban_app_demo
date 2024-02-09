// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moodboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moodboard _$MoodboardFromJson(Map<String, dynamic> json) => Moodboard(
      json['id'] as String,
      const StringListConverter().fromJson(json['attachments'] as List?),
      const DocumentReferenceListConverter()
          .fromJson(json['commentsReferences'] as List?),
      DateTime.parse(json['createdAt'] as String),
      const DocumentReferenceConverter().fromJson(json['proyectReference']),
      json['title'] as String,
    );

Map<String, dynamic> _$MoodboardToJson(Moodboard instance) => <String, dynamic>{
      'id': instance.id,
      'attachments': const StringListConverter().toJson(instance.attachments),
      'commentsReferences': const DocumentReferenceListConverter()
          .toJson(instance.commentsReferences),
      'createdAt': instance.createdAt.toIso8601String(),
      'proyectReference':
          const DocumentReferenceConverter().toJson(instance.proyectReference),
      'title': instance.title,
    };
