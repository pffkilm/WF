import 'package:json_annotation/json_annotation.dart';

part 'definition.g.dart';

@JsonSerializable()
class Definition {
  final String? example;
  final String? definition;

  const Definition({
    this.example,
    this.definition,
  });

  factory Definition.fromJson(Map<String, dynamic> json) => _$DefinitionFromJson(json);
  Map<String, dynamic> toJson() => _$DefinitionToJson(this);
}