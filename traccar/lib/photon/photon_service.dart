import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../flutter_examples_config.dart';
import 'models/photon_address_response_model.dart';

class PhotonServices {
  Future<PhotonAddressResponseModel> selectionLocation(
      String address, String localeLanguage) async {
    Map<String, dynamic> queryParams = {
      "q": address,
    };
    Uri uri = Uri.parse(
      FlutterExamplesConfig.photonUrl,
    ).replace(queryParameters: queryParams);
    var response = await http.get(uri);
    if (response.statusCode == HttpStatus.ok) {
      var responseJson = json.decode(response.body);
      PhotonAddressResponseModel adressList =
          PhotonAddressResponseModel.fromMap(responseJson);
      return adressList;
    } else {
      throw Exception();
    }
  }
}
