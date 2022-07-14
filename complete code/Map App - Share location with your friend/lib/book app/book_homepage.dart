import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'book_details_page.dart';

class Homepage extends StatefulWidget {
  final String? path;
  const Homepage({Key? key, required this.path}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> bookImgs = [
    "assets/img_01.webp",
    "assets/img_02.webp",
    "assets/img_03.jpeg",
    "assets/img_04.webp",
    "assets/img_05.webp",
    "assets/img_06.webp",
  ];

  List<String> bookPrice = [
    "\$20.00",
    "\$23.00",
    "\$14.00",
    "\$50.00",
    "\$24.00",
    "\$40.00",
  ];

  List<String> bookNames = [
    "Fahrenheit 451 by Ray Bradbury",
    "1984 by George Orwell",
    "The Lord of the Rings by J.R.R. Tolkien",
    "The Kite Runner by Khaled Hosseini",
    "Frankenstein by Mary Shelley",
    "Harry Potter and the Philosopher’s Stone by J.K. Rowling"
  ];

  List<String> bookDescription = [
    "Ray Bradbury’s dystopian world shines a light on Western societies’ dependence on the media. The main character’s job is to find and burn any books he can find – until he begins to question everything. Considering the state of current politics and world affairs, this is one of the absolute must-read books in life.",
    "1984 tells the futuristic story of a dystopian, totalitarian world where free will and love are forbidden. Although the year 1984 has long since passed, the prophecy of a society controlled by fear and lies is arguably more relevant now than ever.",
    "Tolkien’s fantasy epic is one of the top must-read books out there. Set in Middle Earth – a world full of hobbits, elves, orcs, goblins, and wizards – The Lord of the Rings will take you on an unbelievable adventure.",
    "The Kite Runner is a moving story of an unlikely friendship between a wealthy boy and the son of his father’s servant. Set in Afghanistan during a time of tragedy and destruction, this unforgettable novel will have you hooked from start to finish.",
    "English author Mary Shelley tells the story of Victor Frankenstein, a young scientist who creates a monster and brings it to life. This gripping novel evokes questions about what makes us human and what love and kindness truly mean.",
    "This global bestseller took the world by storm. So, if you haven’t read J.K. Rowling’s Harry Potter, now may be the time. Join Harry Potter and his schoolmates as this must-read book transports you deep into a world of magic and monsters.",
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((c) => openTheBook());
  }

  openTheBook() {
    int bookNoIndex = -1;

    if (widget.path != null) {
      if (widget.path == '/book0') {
        bookNoIndex = 0;
      } else if (widget.path == '/book1') {
        bookNoIndex = 1;
      } else if (widget.path == '/book2') {
        bookNoIndex = 2;
      } else if (widget.path == '/book3') {
        bookNoIndex = 3;
      } else if (widget.path == '/book4') {
        bookNoIndex = 4;
      } else if (widget.path == '/book5') {
        bookNoIndex = 5;
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                    bkDecription: bookDescription.elementAt(bookNoIndex),
                    bkImage: bookImgs.elementAt(bookNoIndex),
                    bkName: bookNames.elementAt(bookNoIndex),
                    bkPrice: bookPrice.elementAt(bookNoIndex),
                    bookNo: bookNoIndex,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            't3p->' + widget.path.toString(),
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  String url = 'https://coffeecrew.page.link/download';

                  await Share.share(url);
                },
                child: Row(
                  children: [Icon(Icons.share), Text('Share with Friends')],
                ))
          ],
        ),
        body: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetailsPage(
                                bkDecription: bookDescription.elementAt(index),
                                bkImage: bookImgs.elementAt(index),
                                bkName: bookNames.elementAt(index),
                                bkPrice: bookPrice.elementAt(index),
                                bookNo: index,
                              )));
                },
                child: Card(
                  child: Image.asset(
                    bookImgs.elementAt(index),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }));
  }
}
