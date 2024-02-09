import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String id;

  @JsonKey(
      fromJson: _documentReferenceListFromJson,
      toJson: _documentReferenceListToJson)
  List<DocumentReference> commentsReferences;

  DateTime createdAt;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference intakeReference;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference moodboardReference;

  String name;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference proyectReference;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference questionnaireReference;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference renderingReference;

  Task(
    this.id,
    this.commentsReferences,
    this.createdAt,
    this.intakeReference,
    this.moodboardReference,
    this.name,
    this.proyectReference,
    this.questionnaireReference,
    this.renderingReference,
  );

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Extracting comments_references from the 'comments_references' field
    List<DocumentReference> commentsReferences =
        _documentReferenceListFromJson(data['comments_references']);

    return Task(
      snapshot.id,
      commentsReferences,
      (data['created_at'] as Timestamp).toDate(),
      _documentReferenceFromJson(data['intake_reference']),
      _documentReferenceFromJson(data['moodboard_reference']),
      data['name'] as String,
      _documentReferenceFromJson(data['proyect_reference']),
      _documentReferenceFromJson(data['questionnaire_reference']),
      _documentReferenceFromJson(data['rendering_reference']),
    );
  }

  Map<String, dynamic> toMap() {
    List<dynamic> commentsReferencesData =
        _documentReferenceListToJson(commentsReferences);

    return {
      'comments_references': commentsReferencesData,
      'created_at': createdAt,
      'intake_reference': _documentReferenceToJson(intakeReference),
      'moodboard_reference': _documentReferenceToJson(moodboardReference),
      'name': name,
      'proyect_reference': _documentReferenceToJson(proyectReference),
      'questionnaire_reference':
          _documentReferenceToJson(questionnaireReference),
      'rendering_reference': _documentReferenceToJson(renderingReference),
    };
  }

  static List<DocumentReference> _documentReferenceListFromJson(
      List<dynamic>? list) {
    if (list == null) return [];
    return list.map((ref) => _documentReferenceFromJson(ref)).toList();
  }

  static List<dynamic> _documentReferenceListToJson(
      List<DocumentReference>? list) {
    if (list == null) return [];
    return list.map((ref) => _documentReferenceToJson(ref)).toList();
  }

  static DocumentReference _documentReferenceFromJson(dynamic reference) {
    return FirebaseFirestore.instance.doc(reference);
  }

  static dynamic _documentReferenceToJson(DocumentReference reference) {
    return reference.path;
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
