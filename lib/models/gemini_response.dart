import 'package:json_annotation/json_annotation.dart';
part 'gemini_response.g.dart';

@JsonSerializable()
class GeminiResponseModel {
  GeminiResponseModel({this.title, this.summary, this.complexity, this.emoji});

  String? title;
  String? summary;
  int? complexity;
  String? emoji;

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeminiResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeminiResponseModelToJson(this);
}
