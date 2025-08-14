import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_image_crud/providers/home_provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: provider.globalKeyAdd,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Column(
            children: [
              provider.imageStore == null ? CircleAvatar(radius: 80,):CircleAvatar(radius: 80,backgroundImage: FileImage(File(provider.imageStore!.path)),),
              SizedBox(height: 10,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    provider.getGalleryAccess();
                  }, icon: Icon(Icons.camera,size: 35,)),
                  SizedBox(width: 10,),
                  IconButton(onPressed: (){
                    provider.getCameraAccess();
                  }, icon: Icon(Icons.camera_alt,size: 35,)),
                ],
              ),
              SizedBox(height: 10,),
              TextFormField(  textCapitalization: TextCapitalization.words ,controller: provider.addNameController, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)  ,labelText: "Enter your name."),validator: (value) {
                if(value==null||value.isEmpty){
                  return "Name is required";
                }
                return null;
              },),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(onPressed: (){
                  if (provider.globalKeyAdd.currentState!.validate()) {
                    if (provider.imageStore == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a image")),
                      );
                      return;
                    }
                    provider.addStudent();
                    Navigator.pop(context);
                    provider.addNameController.clear();
                    provider.clearImage();
                    FocusScope.of(context).unfocus();
                  }
                }, child: Text("Add Task")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
