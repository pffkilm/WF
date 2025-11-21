import 'package:word/dato/dto/meaning.dart';
import 'package:word/dato/dto/phonetic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable()
class Word {
  final String word;
  final String? phonetic;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;
  final List<String> sourceUrls;

  const Word({
    required this.word,
    this.phonetic,
    required this.phonetics,
    required this.meanings,
    required this.sourceUrls,
  });

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}