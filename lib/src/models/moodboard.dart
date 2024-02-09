import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'moodboard.g.dart';

class StringListConverter
    implements JsonConverter<List<String>?, List<dynamic>?> {
  const StringListConverter();

  @override
  List<String>? fromJson(List<dynamic>? json) {
    if (json == null) return [];
    return json.map((attachment) => attachment as String).toList();
  }

  @override
  List<dynamic>? toJson(List<String>? list) {
    if (list == null) return [];
    return list;
  }
}

class DocumentReferenceListConverter
    implements JsonConverter<List<DocumentReference>?, List<dynamic>?> {
  const DocumentReferenceListConverter();

  @override
  List<DocumentReference>? fromJson(List<dynamic>? json) {
    if (json == null) return [];
    return json
        .map((reference) => _documentReferenceFromJson(reference))
        .toList();
  }

  @override
  List<dynamic>? toJson(List<DocumentReference>? list) {
    if (list == null) return [];
    return list
        .map((reference) => _documentReferenceToJson(reference))
        .toList();
  }
}

@JsonSerializable()
class Moodboard {
  String id;

  @StringListConverter()
  List<String>? attachments;

  @DocumentReferenceListConverter()
  List<DocumentReference>? commentsReferences;

  DateTime createdAt;

  @DocumentReferenceConverter()
  DocumentReference? proyectReference;

  String title;

  Moodboard(
    this.id,
    this.attachments,
    this.commentsReferences,
    this.createdAt,
    this.proyectReference,
    this.title,
  );

  factory Moodboard.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Moodboard(
      snapshot.id,
      data['attachments'] as List<String>?,
      data['comments_references'] as List<DocumentReference>?,
      (data['created_at'] as Timestamp).toDate(),
      _documentReferenceFromJson(data['proyect_reference']),
      data['title'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attachments': attachments,
      'comments_references': commentsReferences,
      'created_at': createdAt,
      'proyect_reference': _documentReferenceToJson(proyectReference),
      'title': title,
    };
  }

  factory Moodboard.fromJson(Map<String, dynamic> json) =>
      _$MoodboardFromJson(json);

  Map<String, dynamic> toJson() => _$MoodboardToJson(this);
}

class DocumentReferenceConverter
    implements JsonConverter<DocumentReference?, dynamic> {
  const DocumentReferenceConverter();

  @override
  DocumentReference? fromJson(dynamic json) {
    return _documentReferenceFromJson(json);
  }

  @override
  dynamic toJson(DocumentReference? reference) {
    return _documentReferenceToJson(reference);
  }
}
