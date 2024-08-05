import 'package:json_annotation/json_annotation.dart';
part 'reward.g.dart';

@JsonSerializable()
class RewardModel {
  RewardModel({this.cost, this.title, this.imageURL});

  int? cost;
  String? title;
  String? imageURL;

  factory RewardModel.fromJson(Map<String, dynamic> json) =>
      _$RewardModelFromJson(json);
  Map<String, dynamic> toJson() => _$RewardModelToJson(this);
}
