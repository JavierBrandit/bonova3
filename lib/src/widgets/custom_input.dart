import 'package:bonova0002/theme.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({
    Key key, 
    @required this.icon, 
    @required this.placeholder, 
    @required this.textController, 
    this.keyboardType = TextInputType.text, 
    this.isPassword = false
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
     margin: EdgeInsets.only(bottom: 30,),
     padding: EdgeInsets.only( top: 5, left: 5 ,bottom: 5, right: 20 ),
     decoration: BoxDecoration(
       color: isDarkTheme ? BonovaColors.azulNoche[600] : Colors.white, 
       borderRadius: BorderRadius.circular(30),
      //  boxShadow: <BoxShadow>[
      //    BoxShadow(
      //      color: Colors.black.withOpacity(0.05),
      //      offset: Offset(0, 5),
      //      blurRadius: 5
      //    )
      //  ]
     ),
     child: TextField(
       controller: this.textController,
       autocorrect: false,
       keyboardType: this.keyboardType,
       obscureText: this.isPassword,
       textAlignVertical: TextAlignVertical.center,
       decoration: InputDecoration(
         prefixIcon: Icon( this.icon, size: 18, ),
         focusedBorder: InputBorder.none,
         border: InputBorder.none,
         hintText: this.placeholder,
         hintStyle: TextStyle( fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: -.2)
       ),
        
     ));






  }
}