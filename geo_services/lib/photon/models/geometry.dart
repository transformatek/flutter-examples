import 'dart:convert';

import 'package:collection/collection.dart';

class Geometry {
  List<dynamic>? coordinates;
  String? type;

  Geometry({this.coordinates, this.type});

  @override
  String toString() => 'Geometry(coordinates: $coordinates, type: $type)';

  factory Geometry.fromMap(Map<String, dynamic> data) => Geometry(
        coordinates: data['coordinates'] as List<dynamic>?,
        type: data['type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'coordinates': coordinates,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Geometry].
  factory Geometry.fromJson(String data) {
    return Geometry.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Geometry] to a JSON string.
  String toJson() => json.encode(toMap());

  Geometry copyWith({
    List<dynamic>? coordinates,
    String? type,
  }) {
    return Geometry(
      coordinates: coordinates ?? this.coordinates,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Geometry) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => coordinates.hashCode ^ type.hashCode;
}
