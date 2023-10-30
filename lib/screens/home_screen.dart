import 'package:flutter/material.dart';
import 'package:revision_2/local/shared_prference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${Cache.getName()}'),
        actions: [
          IconButton(
            onPressed: (){
              
            }, 
            icon: Icon(Icons.person_2_outlined),
          ),

        ],
      ),
      body: Center(child: Text("Home")),
    );
  }
}