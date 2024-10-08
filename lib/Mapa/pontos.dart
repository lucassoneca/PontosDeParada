import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class Paradas {
  final LatLng point;
  final String codDftrans;

  Paradas({required this.point, required this.codDftrans});

  static Future<List<Paradas>> procurarParadas() async {
    final response = await http.get(Uri.parse(
        'https://www.sistemas.dftrans.df.gov.br/parada/geo/paradas/wgs'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['features'] as List)
          .map((feature) => Paradas.fromJson(feature))
          .toList();
    } else {
      throw Exception('Falha para carregar paradas');
    }
  }

  factory Paradas.fromJson(Map<String, dynamic> json) {
    return Paradas(
      point: LatLng(
          json['geometry']['coordinates'][1], json['geometry']['coordinates'][0]),
      codDftrans: json['properties']['codDftrans'],
    );
  }
}