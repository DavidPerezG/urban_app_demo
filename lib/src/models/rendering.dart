/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rendering.g.dart';

@JsonSerializable()
class Rendering {
  String id;
  List<String> attachments;
  List<DocumentReference> commentsReferences;
  DateTime createdAt;

  Rendering(
    this.id,
    this.attachments,
    this.commentsReferences,
    this.createdAt,
  );

  factory Rendering.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // Extracting attachments from the 'attachments' field
    List<String> attachments = [];
    if (data['attachments'] != null) {
      for (var attachment in data['attachments']) {
        attachments.add(attachment as String);
      }
    }

    // Extracting comments_references from the 'comments_references' field
    List<DocumentReference> commentsReferences = [];
    if (data['comments_references'] != null) {
      for (var commentRef in data['comments_references']) {
        commentsReferences.add(commentRef as DocumentReference);
      }
    }

    return Rendering(
      snapshot.id,
      attachments,
      commentsReferences,
      (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    List<dynamic> attachmentsData = attachments;
    List<dynamic> commentsReferencesData = commentsReferences;

    return {
      'attachments': attachmentsData,
      'comments_references': commentsReferencesData,
      'created_at': createdAt,
    };
  }

  factory Rendering.fromJson(Map<String, dynamic> json) =>
      _$RenderingFromJson(json);

  Map<String, dynamic> toJson() => _$RenderingToJson(this);
}
 */