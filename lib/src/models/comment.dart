import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

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

@JsonSerializable()
class Comment {
  String id;

  @StringListConverter()
  List<String>? attachments;

  DateTime createdAt;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference? proyectReference;

  String text;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  DocumentReference? userReference;

  Comment(
    this.id,
    this.attachments,
    this.createdAt,
    this.proyectReference,
    this.text,
    this.userReference,
  );

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Extracting attachments from the 'attachments' field
    List<String>? attachments =
        StringListConverter().fromJson(data['attachments']);

    return Comment(
      snapshot.id,
      attachments,
      (data['created_at'] as Timestamp).toDate(),
      _documentReferenceFromJson(data['proyect_reference']),
      data['text'] as String,
      _documentReferenceFromJson(data['user_reference']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attachments': StringListConverter().toJson(attachments),
      'created_at': createdAt,
      'proyect_reference': _documentReferenceToJson(proyectReference),
      'text': text,
      'user_reference': _documentReferenceToJson(userReference),
    };
  }

  static DocumentReference? _documentReferenceFromJson(dynamic reference) {
    return reference != null ? FirebaseFirestore.instance.doc(reference) : null;
  }

  static dynamic _documentReferenceToJson(DocumentReference? reference) {
    return reference != null ? reference.path : null;
  }

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
