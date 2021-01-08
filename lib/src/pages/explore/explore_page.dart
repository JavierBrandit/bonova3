
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [

         SliverAppBar(
           toolbarHeight: 100,
         ),
         SliverToBoxAdapter(
           child: Column(
             children: [

               SizedBox(height: 20),


              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Padding(
                  padding:  EdgeInsets.all(10),
                  child: Container(
                    height: 250,
                    width: 80,
                    color: Colors.white10,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(10),
                  child: Container(
                    height: 250,
                    width: 80,
                    color: Colors.white10,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(10),
                  child: Container(
                    height: 250,
                    width: 80,
                    color: Colors.white10,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(10),
                  child: Container(
                    height: 250,
                    width: 80,
                    color: Colors.white10,
                  ),
                ),
              ]),

             ],
           )
         )



        ],
      ),
    );
  }

}
