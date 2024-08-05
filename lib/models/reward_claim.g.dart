// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardClaimModel _$RewardClaimModelFromJson(Map<String, dynamic> json) =>
    RewardClaimModel(
      cost: (json['cost'] as num?)?.toInt(),
      userID: json['userID'] as String?,
      prizeName: json['prizeName'] as String?,
    );

Map<String, dynamic> _$RewardClaimModelToJson(RewardClaimModel instance) =>
    <String, dynamic>{
      'cost': instance.cost,
      'userID': instance.userID,
      'prizeName': instance.prizeName,
    };
