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
       elevation: 1.5,
       highlightElevation: 5,
       color: isDarkTheme ? Colors.teal[800] : Colors.tealAccent[700],
       shape: StadiumBorder(),
       onPressed: 
          this.callBack
       ,
       child: Container(
         width: double.infinity,
         height: 55,
         child: Center( 
           child: Text( this.txt , style: TextStyle( color:  Colors.white, fontSize: 15, letterSpacing: 0.5, fontWeight: FontWeight.w700 ),))),
       
     );
  }
}