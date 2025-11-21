// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phonetic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phonetic _$PhoneticFromJson(Map<String, dynamic> json) => Phonetic(
      text: json['text'] as String?,
      audio: json['audio'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
    );

Map<String, dynamic> _$PhoneticToJson(Phonetic instance) => <String, dynamic>{
      'text': instance.text,
      'audio': instance.audio,
      'sourceUrl': instance.sourceUrl,
    };
