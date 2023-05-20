import 'package:flutter/material.dart';
import 'package:music_app/modules/Singers/widget/starrating.dart';
import '../../Songs/pages/songs.dart';
import '../model/singer.dart';
class SingerBox extends StatelessWidget {
  Singer singer;
  SingerBox(this.singer, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.60,
          child: InkWell(
            
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Songs(singer.name)));
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(image: NetworkImage(singer.url)),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 5, color: Colors.black)
                ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 50,
          child: Center(
            child: Text(
              singer.name,
              style:  TextStyle(fontSize: 18,color: Color.fromARGB(255, 246, 244, 244), fontWeight: FontWeight.bold),),
          ),
        ),
        // Positioned(
        //   top: 10,
        //   left: 30,
        //   child: StarRating(),
        //   ),
      ],
    );
  }
}