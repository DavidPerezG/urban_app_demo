import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proyect.g.dart';

@JsonSerializable()
class Proyect {
  String id;
  String title;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference userClientReference;

  DateTime createdAt;

  @JsonKey(
      fromJson: _documentReferenceListFromJson,
      toJson: _documentReferenceListToJson)
  List<DocumentReference> tasks;

  Proyect(this.id, this.title, this.userClientReference, this.createdAt,
      this.tasks);

  factory Proyect.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Extracting tasks from the 'tasks' field
    List<DocumentReference> tasks =
        _documentReferenceListFromJson(data['tasks']);

    return Proyect(
      snapshot.id,
      data['title'] as String,
      _documentReferenceFromJson(data['user_client_reference']),
      (data['created_at'] as Timestamp).toDate(),
      tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_client_reference': _documentReferenceToJson(userClientReference),
      'created_at': createdAt,
      'tasks': _documentReferenceListToJson(tasks),
    };
  }

  static List<DocumentReference> _documentReferenceListFromJson(
      List<dynamic>? list) {
    if (list == null) return [];
    return list.map((ref) => _documentReferenceFromJson(ref)).toList();
  }

  static List _documentReferenceListToJson(List<DocumentReference>? list) {
    if (list == null) return [];
    return list.map((ref) => _documentReferenceToJson(ref)).toList();
  }

  static DocumentReference _documentReferenceFromJson(dynamic reference) {
    return FirebaseFirestore.instance.doc(reference);
  }

  static dynamic _documentReferenceToJson(DocumentReference reference) {
    return reference.path;
  }

  factory Proyect.fromJson(Map<String, dynamic> json) =>
      _$ProyectFromJson(json);

  Map<String, dynamic> toJson() => _$ProyectToJson(this);
}
