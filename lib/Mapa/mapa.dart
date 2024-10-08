import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'pontos.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class TelaMapa extends StatefulWidget {
  const TelaMapa({Key? key}) : super(key: key);

  @override
  _TelaMapaState createState() => _TelaMapaState();
}

class _TelaMapaState extends State<TelaMapa> {
  late Future<List<Paradas>> _paradasFuture;

  @override
  void initState() {
    super.initState();
    _paradasFuture = Paradas.procurarParadas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Paradas>>(
        future: _paradasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final paradas = snapshot.data ?? [];
            return FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(-15.7801, -47.9292), // Coordenadas DF
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                    tileProvider: CancellableNetworkTileProvider(),
                  ),
                  MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 250,
                    size: const Size(40, 40),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(60),
                    maxZoom: 15,
                    markers: paradas.map((parada) {
                      return Marker(
                        point: parada.point,
                        child: Container(
                          child: Icon(Icons.pin_drop, color: Colors.blue),
                        ),
                      );
                    }).toList(),
                    builder: (context, cluster) {
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              '${cluster.length}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                      );
                    },
          ),
                  ),
                ],
            );
          }
        },
    );
  }
}