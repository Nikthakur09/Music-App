import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app/modules/Songs/widgits/song_box.dart';

class Songs extends StatelessWidget {
  String singerName;
  Songs(this.singerName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: FloatingNavbar(
          onTap: (int val) {
            //returns tab id which is user tapped
          },
          currentIndex: 0,
          items: [
            FloatingNavbarItem(
              icon: Icons.home,
              title: 'HOME',
            ),
            FloatingNavbarItem(icon: Icons.search, title: 'SEARCH'),
            FloatingNavbarItem(icon: Icons.person, title: 'PROFILE'),
            FloatingNavbarItem(icon: Icons.circle, title: 'ALEXA'),
          ],
          selectedItemColor: Colors.blue,
          selectedBackgroundColor: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 19, 18, 18),
        title: Text(
          singerName,
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SongBox(
        singerName: singerName,
      ),
    );
  }
}
