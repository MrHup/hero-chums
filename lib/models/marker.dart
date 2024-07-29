import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'marker.g.dart';

@JsonSerializable()
class MarkerModel {
  MarkerModel(
      {this.category,
      this.complexity,
      this.description,
      this.imageURL,
      this.location,
      this.reward,
      this.id,
      this.title});

  String? title;
  String? description;
  String? imageURL;
  String? category;
  String? id;
  int? complexity;
  int? reward;

  @JsonKey(fromJson: _fromGeo, toJson: _toGeo)
  GeoPoint? location;

  factory MarkerModel.fromJson(Map<String, dynamic> json) =>
      _$MarkerModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarkerModelToJson(this);

  static GeoPoint? _fromGeo(GeoPoint? geopoint) {
    return geopoint;
  }

  static GeoPoint? _toGeo(GeoPoint? geopoint) {
    return geopoint;
  }
}
