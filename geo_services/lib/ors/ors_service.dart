import 'dart:convert';
import 'dart:io';

import 'package:gps_position_listener/ors/utils.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../geo_services_config.dart';

class OrsServices {
  Future<LineString> getRoute(LatLng start, LatLng end) async {
    try {
      String url =
          "${FlutterExamplesConfig.orsDirectionsURL}?start=${start.longitude},${start.latitude}&end=${end.longitude},${end.latitude}";
      http.Response response = await http.get(Uri.parse(url), headers: {
        'accept': 'application/geo+json, */*',
        'apikey': 'your_api_key', // Replace with your actual API key
      });
      if (response.statusCode == HttpStatus.ok) {
        var data = jsonDecode(response.body);

        LineString lineString =
            LineString(data['features'][0]['geometry']['coordinates']);
        return lineString;
      } else {
        throw Exception("Failed to load route data");
      }
    } catch (e) {
      throw Exception("Error fetching route: $e");
    }
  }
}
