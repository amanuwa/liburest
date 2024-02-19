// ignore_for_file: camel_case_types, duplicate_ignore


import 'package:flutter/material.dart';


import 'package:restmenus/feedme.dart';


class myhomepage extends StatefulWidget {
  const myhomepage({super.key});

  @override
  State<myhomepage> createState() => _myhomepageState();
}

// ignore: camel_case_types
class _myhomepageState extends State<myhomepage> {

  @override
  Widget build(BuildContext context) {
    // return  const Scaffold(

          

    //   body: FeedMe(),
    // );
     return LayoutBuilder(builder: (context, constraints) {
     
       if (constraints.maxWidth < 500) {
        return const FeedMe();
      } 
      else {
        return const Center(
          child: const Text('Not Available for windows'),
          
        );
      }
    });
  }
}



