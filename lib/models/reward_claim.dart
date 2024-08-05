import 'package:json_annotation/json_annotation.dart';
part 'reward_claim.g.dart';

@JsonSerializable()
class RewardClaimModel {
  RewardClaimModel({this.cost, this.userID, this.prizeName});

  int? cost;
  String? userID;
  String? prizeName;

  factory RewardClaimModel.fromJson(Map<String, dynamic> json) =>
      _$RewardClaimModelFromJson(json);
  Map<String, dynamic> toJson() => _$RewardClaimModelToJson(this);
}
