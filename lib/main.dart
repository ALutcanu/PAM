import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> banners = [];
  List<dynamic> categories = [];
  List<dynamic> nearbyCenters = [];
  List<dynamic> doctors = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);

    setState(() {
      banners = data['banners'];
      categories = data['categories'];
      nearbyCenters = data['nearby_centers'];
      doctors = data['doctors'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter App')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banners
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(banners[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(banners[index]['title'], style: TextStyle(color: Colors.white)),
                        Text(banners[index]['description'], style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Categories
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(categories[index]['icon'], height: 40, width: 40),
                      Text(categories[index]['title']),
                    ],
                  );
                },
              ),
            ),
            // Nearby Centers
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nearbyCenters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(nearbyCenters[index]['image'], width: 50),
                  title: Text(nearbyCenters[index]['title']),
                  subtitle: Text(nearbyCenters[index]['location_name']),
                  trailing: Text('${nearbyCenters[index]['review_rate']}⭐'),
                );
              },
            ),
            // Doctors
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(doctors[index]['image'], width: 50),
                  title: Text(doctors[index]['full_name']),
                  subtitle: Text(doctors[index]['type_of_doctor']),
                  trailing: Text('${doctors[index]['review_rate']}⭐'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
