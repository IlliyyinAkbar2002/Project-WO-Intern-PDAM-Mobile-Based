import 'package:equatable/equatable.dart';

class DocumentationEntity extends Equatable {
  final int? id;
  final int? workOrderProgressId;
  final String? url;

  const DocumentationEntity({
    this.id,
    this.workOrderProgressId,
    this.url,
  });

  @override
  List<Object?> get props => [
        id,
        workOrderProgressId,
        url,
      ];

  DocumentationEntity copyWith({
    int? id,
    int? workOrderProgressId,
    String? url,
  }) {
    return DocumentationEntity(
      id: id ?? this.id,
      workOrderProgressId: workOrderProgressId ?? this.workOrderProgressId,
      url: url ?? this.url,
    );
  }
}
