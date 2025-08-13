import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_image_crud/screens/add_task_screen.dart';
import 'package:sqlite_image_crud/utils/db_helper.dart';

import '../providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context,listen: false).getAllData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"), backgroundColor: Colors.blue),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.userData.length,
          itemBuilder: (context, index) {
            var data=value.userData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 50,backgroundImage: FileImage(File(data[DbHelper.COLUMN_IMAGE_PATH])),),
                      SizedBox(width: 20,),
                      Text(data[DbHelper.COLUMN_NAME],style: TextStyle(fontSize: 20),)
                    ],
                  )
                ],
              ),
            );
          },);
      },),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
