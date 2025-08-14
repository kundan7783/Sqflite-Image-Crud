import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_image_crud/screens/add_task_screen.dart';
import 'package:sqlite_image_crud/screens/update_task_screen.dart';
import 'package:sqlite_image_crud/utils/db_helper.dart';
import '../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Home Screen"), backgroundColor: Colors.blue),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.userData.length,
            itemBuilder: (context, index) {
              var data = value.userData[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        FileImage(File(data[DbHelper.COLUMN_IMAGE_PATH])),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          data[DbHelper.COLUMN_NAME],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Update Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon:
                          const Icon(Icons.edit, color: Colors.blue, size: 22),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTaskScreen(id: data[DbHelper.COLUMN_ID], name: data[DbHelper.COLUMN_NAME], image: data[DbHelper.COLUMN_IMAGE_PATH]),));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Delete Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.red, size: 22),
                          onPressed: () {
                            value.deleteStudent(data[DbHelper.COLUMN_ID]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
