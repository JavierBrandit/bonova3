import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta( BuildContext context, String titulo, String subitulo ){

  if ( Platform.isAndroid ) {
    return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text( titulo ),
      content: Text( subitulo ),
      actions: [
        MaterialButton(
          child: Text('Continuar'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ]
     )
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text( titulo ),
      content: Text( subitulo ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Continuar'),
          onPressed: () => Navigator.pop(context),
        ),
      ]
     )
    );

}