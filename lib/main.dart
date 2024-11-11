import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.location_on, color: Colors.black),
        title: Text(
          'Seattle, USA',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.png'), // adaugă imaginea profilului
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(),
            SizedBox(height: 16.0),
            SpecialistBanner(),
            SizedBox(height: 16.0),
            CategoriesSection(),
            SizedBox(height: 16.0),
            NearbyClinicsSection(),
            SizedBox(height: 16.0),
            DoctorList(),
          ],
        ),
      ),
    );
  }
}

// Secțiunea de căutare
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search doctor...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}

// Secțiunea banner pentru specialiști
class SpecialistBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/doctor.png', // Înlocuiește cu calea corectă a imaginii
            width: 80.0,
            height: 80.0,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Looking for Specialist Doctors?",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Schedule an appointment with our top doctors.",
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Secțiunea de categorii
class CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            TextButton(onPressed: () {}, child: Text("See All")),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryCard(icon: Icons.local_hospital, label: 'Dentistry'),
            CategoryCard(icon: Icons.favorite, label: 'Cardiology'),
            CategoryCard(icon: Icons.spa, label: 'Pulmonology'),
            CategoryCard(icon: Icons.healing, label: 'General'),
          ],
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.teal[50],
          child: Icon(icon, size: 30.0, color: Colors.teal),
        ),
        SizedBox(height: 8.0),
        Text(label, style: TextStyle(fontSize: 14.0)),
      ],
    );
  }
}

// Secțiunea clinicilor apropiate
class NearbyClinicsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Nearby Medical Centers", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            TextButton(onPressed: () {}, child: Text("See All")),
          ],
        ),
        SizedBox(height: 8.0),
        Column(
          children: [
            buildClinicCard(
              'Sunrise Health Clinic',
              '123 Oak Street, CA 98765',
              'assets/sunrise_clinic.png',
              '5.0',
              '86 Reviews',
            ),
            buildClinicCard(
              'Golden Cardiology Center',
              '456 Bridge St, NY 12345',
              'assets/golden_cardiology.png',
              '4.7',
              '152 Reviews',
            ),
          ],
        ),
      ],
    );
  }

  Widget buildClinicCard(String name, String address, String imagePath, String rating, String reviews) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150.0,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                SizedBox(height: 4.0),
                Text(address),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.0),
                    Text(rating),
                    Text("  •  $reviews"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Lista doctorilor
class DoctorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("532 found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        SizedBox(height: 8.0),
        DoctorCard(name: "Dr. David Patel", specialty: "Cardiologist", location: "Cardiology Center, USA", imagePath: "assets/doctor1.png"),
        DoctorCard(name: "Dr. Jessica Turner", specialty: "Gynecologist", location: "Women's Clinic, Seattle, USA", imagePath: "assets/doctor2.png"),
        // Adaugă mai mulți doctori dacă este necesar
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String location;
  final String imagePath;

  DoctorCard({required this.name, required this.specialty, required this.location, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(specialty),
            SizedBox(height: 4.0),
            Text(location),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
      ),
    );
  }
}
