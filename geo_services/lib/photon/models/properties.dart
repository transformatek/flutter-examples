import 'dart:convert';

import 'package:collection/collection.dart';

class Properties {
  String? osmType;
  int? osmId;
  List<dynamic>? extent;
  String? country;
  String? osmKey;
  String? countrycode;
  String? osmValue;
  String? postcode;
  String? name;
  String? county;
  String? state;
  String? type;
  String fullAddress;

  Properties({
    this.osmType,
    this.osmId,
    this.extent,
    this.country,
    this.osmKey,
    this.countrycode,
    this.osmValue,
    this.postcode,
    this.name,
    this.county,
    this.state,
    this.type,
    required this.fullAddress,
  });

  @override
  String toString() {
    return 'Properties(osmType: $osmType, osmId: $osmId, extent: $extent, country: $country, osmKey: $osmKey, countrycode: $countrycode, osmValue: $osmValue, postcode: $postcode, name: $name, county: $county, state: $state, type: $type, fullAddress: $fullAddress)';
  }

  factory Properties.fromMap(Map<String, dynamic> data) => Properties(
      osmType: data['osm_type'] as String?,
      osmId: data['osm_id'] as int?,
      extent: data['extent'] as List<dynamic>?,
      country: data['country'] as String?,
      osmKey: data['osm_key'] as String?,
      countrycode: data['countrycode'] as String?,
      osmValue: data['osm_value'] as String?,
      postcode: data['postcode'] as String?,
      name: data['name'] as String?,
      county: data['county'] as String?,
      state: data['state'] as String?,
      type: data['type'] as String?,
      fullAddress: "${data['name'] ?? ""}"
          " ${data['county'] ?? ""}"
          " ${data['state'] ?? ""}");

  Map<String, dynamic> toMap() => {
        'osm_type': osmType,
        'osm_id': osmId,
        'extent': extent,
        'country': country,
        'osm_key': osmKey,
        'countrycode': countrycode,
        'osm_value': osmValue,
        'postcode': postcode,
        'name': name,
        'county': county,
        'state': state,
        'type': type,
        'fullAddress': fullAddress,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Properties].
  factory Properties.fromJson(String data) {
    return Properties.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Properties] to a JSON string.
  String toJson() => json.encode(toMap());

  Properties copyWith({
    String? osmType,
    int? osmId,
    List<dynamic>? extent,
    String? country,
    String? osmKey,
    String? countrycode,
    String? osmValue,
    String? postcode,
    String? name,
    String? county,
    String? state,
    String? type,
    String? fullAddress,
  }) {
    return Properties(
      osmType: osmType ?? this.osmType,
      osmId: osmId ?? this.osmId,
      extent: extent ?? this.extent,
      country: country ?? this.country,
      osmKey: osmKey ?? this.osmKey,
      countrycode: countrycode ?? this.countrycode,
      osmValue: osmValue ?? this.osmValue,
      postcode: postcode ?? this.postcode,
      name: name ?? this.name,
      county: county ?? this.county,
      state: state ?? this.state,
      type: type ?? this.type,
      fullAddress: fullAddress ?? this.fullAddress,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Properties) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      osmType.hashCode ^
      osmId.hashCode ^
      extent.hashCode ^
      country.hashCode ^
      osmKey.hashCode ^
      countrycode.hashCode ^
      osmValue.hashCode ^
      postcode.hashCode ^
      name.hashCode ^
      county.hashCode ^
      state.hashCode ^
      type.hashCode ^
      fullAddress.hashCode;
}
