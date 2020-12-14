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
    return RaisedButton(
       elevation: 2,
       highlightElevation: 5,
       color: Colors.blue,
       shape: StadiumBorder(),
       onPressed: 
          this.callBack
       ,
       child: Container(
         width: double.infinity,
         height: 55,
         child: Center( 
           child: Text( this.txt , style: TextStyle( color:  Colors.white, fontSize: 17),))),
       
     );
  }
}