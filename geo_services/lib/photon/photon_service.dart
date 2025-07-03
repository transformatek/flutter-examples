import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../geo_services_config.dart';
import 'models/photon_address_response_model.dart';

class PhotonServices {
  Future<PhotonAddressResponseModel> selectionLocation(
      String address, String localeLanguage) async {
    Map<String, dynamic> queryParams = {
      "q": address,
    };
    try {
      Uri uri = Uri.parse(
        FlutterExamplesConfig.photonUrl,
      ).replace(queryParameters: queryParams);
      var response = await http.get(uri, headers: {
        'accept': 'application/json',
        'apikey': 'your_api_key', // Replace with your actual API key
      });

      if (response.statusCode == HttpStatus.ok) {
        var responseJson = json.decode(response.body);
        PhotonAddressResponseModel adressList =
            PhotonAddressResponseModel.fromMap(responseJson);

        return adressList;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception("Failed to load data from Photon service");
    }
  }

  Future<PhotonAddressResponseModel> selectionAddress(LatLng coordinate) async {
    Map<String, dynamic> queryParams = {
      "lat": coordinate.latitude.toString(),
      "lon": coordinate.longitude.toString()
    };
    try {
      Uri uri = Uri.parse(
        FlutterExamplesConfig.photonReverseUrl,
      ).replace(queryParameters: queryParams);
      var response = await http.get(uri, headers: {
        'accept': 'application/json',

        'apikey': 'your_api_key', // Replace with your actual API key
      });
      if (response.statusCode == HttpStatus.ok) {
        var responseJson = json.decode(response.body);
        PhotonAddressResponseModel adressList =
            PhotonAddressResponseModel.fromMap(responseJson);

        return adressList;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception("Failed to load data from Photon service");
    }
  }
}
