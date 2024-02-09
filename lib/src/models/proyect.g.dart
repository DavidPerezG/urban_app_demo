// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proyect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proyect _$ProyectFromJson(Map<String, dynamic> json) => Proyect(
      json['id'] as String,
      json['title'] as String,
      Proyect._documentReferenceFromJson(json['userClientReference']),
      DateTime.parse(json['createdAt'] as String),
      Proyect._documentReferenceListFromJson(json['tasks'] as List?),
    );

Map<String, dynamic> _$ProyectToJson(Proyect instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userClientReference':
          Proyect._documentReferenceToJson(instance.userClientReference),
      'createdAt': instance.createdAt.toIso8601String(),
      'tasks': Proyect._documentReferenceListToJson(instance.tasks),
    };
