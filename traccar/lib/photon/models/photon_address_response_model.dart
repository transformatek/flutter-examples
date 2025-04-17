import 'dart:convert';

import 'package:collection/collection.dart';

import 'address_data.dart';

class PhotonAddressResponseModel {
  List<AddressData> addressList;

  PhotonAddressResponseModel({required this.addressList});

  @override
  String toString() {
    return 'PhotonAddressResponseModel(features: $addressList)';
  }

  factory PhotonAddressResponseModel.fromMap(Map<String, dynamic> data) {
    return PhotonAddressResponseModel(
      addressList: List<AddressData>.from(
          (data['features'] ?? []).map((x) => AddressData.fromMap(x))).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'features': addressList.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PhotonAddressResponseModel].
  factory PhotonAddressResponseModel.fromJson(String data) {
    return PhotonAddressResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PhotonAddressResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PhotonAddressResponseModel copyWith({
    List<AddressData>? addressList,
    String? type,
  }) {
    return PhotonAddressResponseModel(
      addressList: addressList ?? this.addressList,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PhotonAddressResponseModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => addressList.hashCode;
}
