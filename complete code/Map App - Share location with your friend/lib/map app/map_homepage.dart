import 'dart:ffi';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';

class MapHomepage extends StatefulWidget {
  final String? path;
  const MapHomepage({Key? key, this.path}) : super(key: key);

  @override
  State<MapHomepage> createState() => _MapHomepageState();
}

class _MapHomepageState extends State<MapHomepage> {
  late LatLng pinPosition;

  @override
  void initState() {
    pinPosition = LatLng(51.5, -0.09);
    findPathLatLng();
    super.initState();
  }

  findPathLatLng() {
    if (widget.path != null) {
      String p = widget.path!;

      double lat =
          double.parse(p.substring(p.indexOf('=') + 1, p.indexOf('&')));

      print(lat);

      double lon = double.parse(p.substring(p.lastIndexOf('=') + 1, p.length));
      print(lon);

      pinPosition = LatLng(lat, lon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text('path : ${widget.path}'),
            SizedBox(
              height: 10,
            ),
            Text('01 Latitude : ${pinPosition.latitude}'),
            SizedBox(
              height: 10,
            ),
            Text('02 Longitude : ${pinPosition.longitude}'),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(51.5, -0.09),
                    zoom: 13.0,
                    onTap: (tapPosition, latLng) {
                      pinPosition = latLng;
                      setState(() {});
                    }),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                          width: 80.0,
                          height: 80.0,
                          point: pinPosition,
                          builder: (ctx) => Icon(
                                CupertinoIcons.pin_fill,
                                color: Colors.red,
                              )),
                    ],
                  ),
                ],
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String link =
                'https://yourwebsite.page.com/latitude=${pinPosition.latitude}&longitude=${pinPosition.longitude}'; // web browser

            final dynamicLinkParams = DynamicLinkParameters(
                link: Uri.parse(link),
                uriPrefix: 'https://coffeecrew.page.link', //live url
                androidParameters: AndroidParameters(
                    packageName: 'com.arApps.pim',
                    fallbackUrl: Uri.parse('https://androidapp.link')),
                iosParameters: IOSParameters(
                    bundleId: 'com.arApps.pim',
                    fallbackUrl: Uri.parse('https://iosapp.link')),
                socialMetaTagParameters: SocialMetaTagParameters(
                    description: 'Share location with your friends',
                    imageUrl: Uri.parse(
                        'https://cdn.jim-nielsen.com/ios/512/where-am-i-gps-location-address-finder-2020-07-27.png'),
                    title: 'Map App'));

            var shortLink = await FirebaseDynamicLinks.instance
                .buildShortLink(dynamicLinkParams);

            print(shortLink.shortUrl);

            Share.share(shortLink.shortUrl.toString());
          },
          child: Icon(Icons.share),
        ),
      ),
    );
  }
}
