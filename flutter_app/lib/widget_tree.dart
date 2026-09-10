import 'package:flutter_app/auth.dart';
import 'package:flutter_app/collectionPage.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/login_register_page.dart';
import 'package:flutter/material.dart';
import 'collectionPage.dart';
class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return CollectionPage(title: 'Collection');
        } else{
          return const LoginPage();
        }
      },
      );

  }
}