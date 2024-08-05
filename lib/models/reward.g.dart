// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardModel _$RewardModelFromJson(Map<String, dynamic> json) => RewardModel(
      cost: (json['cost'] as num?)?.toInt(),
      title: json['title'] as String?,
      imageURL: json['imageURL'] as String?,
    );

Map<String, dynamic> _$RewardModelToJson(RewardModel instance) =>
    <String, dynamic>{
      'cost': instance.cost,
      'title': instance.title,
      'imageURL': instance.imageURL,
    };
