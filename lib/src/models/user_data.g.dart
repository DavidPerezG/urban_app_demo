// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['uid'] as String,
      json['name'] as String,
      json['email'] as String,
      DateTime.parse(json['createdAt'] as String),
      UserData._documentReferenceFromJson(json['rolReference']),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'rolReference': UserData._documentReferenceToJson(instance.rolReference),
    };
