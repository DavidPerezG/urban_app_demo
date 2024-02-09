import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intakes.g.dart';

@JsonSerializable()
class Intake {
  String id;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference? commentReference;

  DateTime createdAt;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference? proyectReference;

  Intake(
    this.id,
    this.commentReference,
    this.createdAt,
    this.proyectReference,
  );

  factory Intake.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Intake(
      snapshot.id,
      _documentReferenceFromJson(data['comment_reference']),
      (data['created_at'] as Timestamp).toDate(),
      _documentReferenceFromJson(data['proyect_reference']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment_reference': _documentReferenceToJson(commentReference),
      'created_at': createdAt,
      'proyect_reference': _documentReferenceToJson(proyectReference),
    };
  }

  static DocumentReference? _documentReferenceFromJson(dynamic reference) {
    return reference != null ? FirebaseFirestore.instance.doc(reference) : null;
  }

  static dynamic _documentReferenceToJson(DocumentReference? reference) {
    return reference != null ? reference.path : null;
  }

  factory Intake.fromJson(Map<String, dynamic> json) => _$IntakeFromJson(json);

  Map<String, dynamic> toJson() => _$IntakeToJson(this);
}
