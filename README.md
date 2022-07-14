## Android
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW"/>
    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>
    <data
        android:host="example.com"
        android:scheme="https"/>
</intent-filter>
```


## Field Data
```dart

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
```

## Flutter Map Usage

```dart
Widget build(BuildContext context) {
  return FlutterMap(
    options: MapOptions(
      center: LatLng(51.5, -0.09),
      zoom: 13.0,
    ),
    layers: [
      TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c'],
      ),
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      ),
    ],
    nonRotatedChildren: [
      AttributionWidget.defaultWidget(
        source: 'OpenStreetMap contributors',
        onSourceTapped: () {},
      ),
    ],
  );
}

```
