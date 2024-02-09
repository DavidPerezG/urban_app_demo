// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intakes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intake _$IntakeFromJson(Map<String, dynamic> json) => Intake(
      json['id'] as String,
      Intake._documentReferenceFromJson(json['commentReference']),
      DateTime.parse(json['createdAt'] as String),
      Intake._documentReferenceFromJson(json['proyectReference']),
    );

Map<String, dynamic> _$IntakeToJson(Intake instance) => <String, dynamic>{
      'id': instance.id,
      'commentReference':
          Intake._documentReferenceToJson(instance.commentReference),
      'createdAt': instance.createdAt.toIso8601String(),
      'proyectReference':
          Intake._documentReferenceToJson(instance.proyectReference),
    };
