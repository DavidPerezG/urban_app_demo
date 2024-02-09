// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['id'] as String,
      const StringListConverter().fromJson(json['attachments'] as List?),
      DateTime.parse(json['createdAt'] as String),
      Comment._documentReferenceFromJson(json['proyectReference']),
      json['text'] as String,
      Comment._documentReferenceFromJson(json['userReference']),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'attachments': const StringListConverter().toJson(instance.attachments),
      'createdAt': instance.createdAt.toIso8601String(),
      'proyectReference':
          Comment._documentReferenceToJson(instance.proyectReference),
      'text': instance.text,
      'userReference': Comment._documentReferenceToJson(instance.userReference),
    };
