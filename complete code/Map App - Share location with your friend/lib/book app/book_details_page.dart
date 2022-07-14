import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share_plus/share_plus.dart';

class BookDetailsPage extends StatefulWidget {
  final int bookNo;
  final String bkName;
  final String bkDecription;
  final String bkPrice;
  final String bkImage;
  const BookDetailsPage(
      {Key? key,
      required this.bookNo,
      required this.bkName,
      required this.bkDecription,
      required this.bkPrice,
      required this.bkImage})
      : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Book Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
              height: 250,
              width: double.maxFinite,
              child: Image.asset(
                widget.bkImage,
                fit: BoxFit.fitWidth,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.bkName,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.bkDecription,
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
              onPressed: () {}, child: Text('Buy ${widget.bkPrice}')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () async {
                final dynamicLinkParams = DynamicLinkParameters(
                    link: Uri.parse(
                        'https://yourwebsite.page/book${widget.bookNo}'), //web browser
                    uriPrefix: 'https://coffeecrew.page.link', //live url
                    androidParameters: AndroidParameters(
                        packageName: 'com.arApps.pim',
                        fallbackUrl: Uri.parse('https://myandroidapp.link')),
                    iosParameters: IOSParameters(
                        bundleId: 'com.arApps.pim',
                        fallbackUrl: Uri.parse('https://myIOSapp.link')));

                // Uri link = await FirebaseDynamicLinks.instance
                //     .buildLink(dynamicLinkParams); //long url link

                var shortLink = await FirebaseDynamicLinks.instance
                    .buildShortLink(dynamicLinkParams);

                print(shortLink.shortUrl);

                Share.share(shortLink.shortUrl.toString());
              },
              child: Text('Share With Friends')),
        ],
      ),
    );
  }
}
