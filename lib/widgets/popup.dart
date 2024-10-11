import 'package:flutter/material.dart';
import '../Mapa/pontos.dart';

void showInfoBalloon(BuildContext context, Paradas parada, Offset offset, OverlayEntry overlayEntry) {
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: offset.dx,
      top: offset.dy - 100, // Ajuste da posição vertical
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informações da Parada',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Código: ${parada.codDftrans}'),
              Text('Sentido: ${parada.sentido}'),
              Text('Sequencial: ${parada.sequencial}'),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  overlayEntry.remove(); // Fechar o popup
                },
                child: Text('Fechar'),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Overlay.of(context)?.insert(overlayEntry);
}
