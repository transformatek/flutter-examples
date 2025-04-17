import 'dart:convert';

import 'package:collection/collection.dart';

import 'geometry.dart';
import 'properties.dart';

class AddressData {
  Geometry? geometry;
  String? type;
  Properties? properties;

  AddressData({this.geometry, this.type, this.properties});

  @override
  String toString() {
    return 'AddressData(geometry: $geometry, type: $type, properties: $properties)';
  }

  factory AddressData.fromMap(Map<String, dynamic> data) => AddressData(
        geometry: data['geometry'] == null
            ? null
            : Geometry.fromMap(data['geometry'] as Map<String, dynamic>),
        type: data['type'] as String?,
        properties: data['properties'] == null
            ? null
            : Properties.fromMap(data['properties'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'geometry': geometry?.toMap(),
        'type': type,
        'properties': properties?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddressData].
  factory AddressData.fromJson(String data) {
    return AddressData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddressData] to a JSON string.
  String toJson() => json.encode(toMap());

  AddressData copyWith({
    Geometry? geometry,
    String? type,
    Properties? properties,
  }) {
    return AddressData(
      geometry: geometry ?? this.geometry,
      type: type ?? this.type,
      properties: properties ?? this.properties,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AddressData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => geometry.hashCode ^ type.hashCode ^ properties.hashCode;
}
