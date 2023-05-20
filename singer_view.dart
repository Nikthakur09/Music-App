import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../model/singer.dart';
import '../services/services.dart';
import '../widget/singerbox.dart';

class SingerView extends StatefulWidget {
  const SingerView({super.key});
 @override
  State<SingerView> createState() => _SingerViewState();
}
class _SingerViewState extends State<SingerView> {
  final SingerService _singerService = SingerService();
@override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.black,borderRadius: const BorderRadius.all(Radius.circular(20))),
        
        child: FloatingNavbar(
              onTap: (int val) {
                //returns tab id which is user tapped
              },
              currentIndex: 0,
              items: [
                FloatingNavbarItem(icon: Icons.home, title: 'HOME',),
                FloatingNavbarItem(icon: Icons.search, title: 'SEARCH'),
                FloatingNavbarItem(icon: Icons.person, title: 'PROFILE'),
                FloatingNavbarItem(icon: Icons.circle, title: 'ALEXA'),
              ],
              selectedItemColor: Colors.blue,
              selectedBackgroundColor: Colors.black,
            ),
      ),
      appBar:AppBar(
        
        leading: Icon(Icons.notifications),
        title: Row(children: [
          
          SizedBox(width: 20,),
          Chip(label: Text('  MUSIC  '),
          side: BorderSide(color: Colors.grey,),
          backgroundColor: Color.fromARGB(255, 20, 19, 19),
          labelStyle: TextStyle(color: Colors.white,),
          
          ),
          SizedBox(width: 10,),
           Chip(label: Text('  PODCASTS  '),
            side: BorderSide(color: Colors.grey,),
          backgroundColor: Color.fromARGB(255, 20, 19, 19),
          labelStyle: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 40,),
          Icon(Icons.settings),
        ],),
        backgroundColor: Color.fromARGB(255, 20, 19, 19),
        
      ),
      body: Container(
        
        child: FutureBuilder(
          
          future: _singerService.getSingers(),
          builder: (contxt,AsyncSnapshot<List<Singer>> snapshot) {
            if (snapshot.hasError) {
              return  const Text('Something went Wrong');
            } else if (!snapshot.hasData) {
              return  Center(child: CircularProgressIndicator());
            }
            return 
              Container(
                color: Colors.black,
                child: GridView.builder(
                    
                    
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                      itemBuilder: (cntxt, int index) {
                        Singer singer = snapshot.data![index];
                        return SingerBox(singer);
                    }
                  ),
              );
              
          
          },
        ),
      ),
    );
  }
}
