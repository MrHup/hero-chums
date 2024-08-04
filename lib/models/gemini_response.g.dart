// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiResponseModel _$GeminiResponseModelFromJson(Map<String, dynamic> json) =>
    GeminiResponseModel(
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      complexity: (json['complexity'] as num?)?.toInt(),
      emoji: json['emoji'] as String?,
    );

Map<String, dynamic> _$GeminiResponseModelToJson(
        GeminiResponseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'summary': instance.summary,
      'complexity': instance.complexity,
      'emoji': instance.emoji,
    };
