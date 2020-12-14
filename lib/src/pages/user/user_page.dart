import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
 
class UserPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(

        children: [
          
          Center(child: CircleAvatar(backgroundImage: AssetImage('assets/placeBonova.jpg'), radius: 55 )),
          SizedBox( height: 20 ),
          Container(
            child: Text('Javier Gonzalez', style: TextStyle( fontSize: 22, fontWeight: FontWeight.w400 ) ),
          ),
          SizedBox( height: 10 ),

          FlatButton.icon(
            icon: Icon( Icons.add, size: 18 ),
            onPressed: (){},
            label: Text('Seguir', style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700),),
            color: Colors.tealAccent[400],
            colorBrightness: Brightness.dark,
            shape: StadiumBorder(),
          ),
          
          Card(
            borderOnForeground: true,
            elevation: 0.4,
            margin: EdgeInsets.all(12),
            child: Container(
              padding: EdgeInsets.all(14),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sobre Mi', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500)),
                  SizedBox( height: 6 ),
                  Text('sobre mi sobre misobre mi sobre mi sobre mi sobre mi sobre misobre mi sobre mi sobre mi'
                  , style: TextStyle( fontSize: 14, fontWeight: FontWeight.w300)),
                  SizedBox( height: 12 ),
                  Text('Estudios', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500)),
                  SizedBox( height: 6 ),
                  Text('Fue a la Universidad de Santiago'
                  , style: TextStyle( fontSize: 14, fontWeight: FontWeight.w300)),
              ]),
            ),
          ),

          ListTile(
            title: Text('Modo Noche'),
            leading: SvgPicture.asset('assets/bvPlay.svg', height: 16,)
          )
          
        ],
      ),  
      
    );
  }
}