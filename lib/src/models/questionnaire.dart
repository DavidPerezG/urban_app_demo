/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questionnaire.g.dart';

@JsonSerializable()
class Questionnaire {
  String id;
  DateTime createdAt;
  String description;
  String link;
  DocumentReference proyectReference;
  String title;

  Questionnaire(
    this.id,
    this.createdAt,
    this.description,
    this.link,
    this.proyectReference,
    this.title,
  );

  factory Questionnaire.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Questionnaire(
      snapshot.id,
      (data['created_at'] as Timestamp).toDate(),
      data['description'] as String,
      data['link'] as String,
      data['proyect_reference'] as DocumentReference,
      data['title'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'description': description,
      'link': link,
      'proyect_reference': proyectReference,
      'title': title,
    };
  }

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
}
 */