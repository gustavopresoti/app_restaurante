import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100.0,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.get('image'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.get('title'),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    snapshot.get('address'),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    launch('https://www.google.com/maps/search/?api=1&query'
                        '=${snapshot.get('lat')},${snapshot.get('long')}');
                  },
                  child: Text('Ver no Mapa'),
                  style: TextButton.styleFrom(
                    primary: Colors.redAccent,
                    padding: EdgeInsets.zero,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    launch('tel:${snapshot.get('phone')}');
                  },
                  child: Text('Ligar'),
                  style: TextButton.styleFrom(
                    primary: Colors.redAccent,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
