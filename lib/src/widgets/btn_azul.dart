import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {

  final String txt;
  final VoidCallback callBack;

  BtnAzul({
    @required this.txt,
    @required this.callBack,    
  });

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
    return RaisedButton(
       elevation: 0.0,
       highlightElevation: 5,
       color: isDarkTheme ? Colors.teal[800] : Colors.tealAccent[400],
       shape: StadiumBorder(),
       onPressed: 
          this.callBack
       ,
       child: Container(
         width: double.infinity,
         height: 55,
         child: Center( 
           child: Text( this.txt , style: TextStyle(color: Colors.white, fontSize: 14, letterSpacing: -.4, fontWeight: FontWeight.w600 ),))),
       
     );
  }
}