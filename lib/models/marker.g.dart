// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkerModel _$MarkerModelFromJson(Map<String, dynamic> json) => MarkerModel(
      category: json['category'] as String?,
      complexity: (json['complexity'] as num?)?.toInt(),
      description: json['description'] as String?,
      imageURL: json['imageURL'] as String?,
      location: MarkerModel._fromGeo(json['location'] as GeoPoint?),
      reward: (json['reward'] as num?)?.toInt(),
      id: json['id'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$MarkerModelToJson(MarkerModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imageURL': instance.imageURL,
      'category': instance.category,
      'id': instance.id,
      'complexity': instance.complexity,
      'reward': instance.reward,
      'location': MarkerModel._toGeo(instance.location),
    };
