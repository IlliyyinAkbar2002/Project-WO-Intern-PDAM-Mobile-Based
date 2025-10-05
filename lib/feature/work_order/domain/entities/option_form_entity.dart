import 'package:equatable/equatable.dart';

class OptionFormEntity extends Equatable {
  final int? id;
  final int? formId;
  final String? optionName;
  final int? parentId;
  final int? order;

  const OptionFormEntity({
    this.id,
    this.formId,
    this.optionName,
    this.parentId,
    this.order,
  });

  @override
  List<Object?> get props => [
        id,
        formId,
        optionName,
        parentId,
        order,
      ];

  OptionFormEntity copyWith({
    int? id,
    int? formId,
    String? optionName,
    int? parentId,
    int? order,
  }) {
    return OptionFormEntity(
      id: id ?? this.id,
      formId: formId ?? this.formId,
      optionName: optionName ?? this.optionName,
      parentId: parentId ?? this.parentId,
      order: order ?? this.order,
    );
  }
}
