import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class UpdateTaskScreen extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  const UpdateTaskScreen({super.key, required this.id, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<HomeProvider>(context);
    provider.updateNameController.text=name;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: provider.globalKeyUpdate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Column(
            children: [
              CircleAvatar(radius: 80, backgroundImage: provider.imageStore==null?FileImage(File(image)): FileImage(File(provider.imageStore!.path))),
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
              TextFormField(  textCapitalization: TextCapitalization.words ,controller: provider.updateNameController, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)  ,labelText: "Enter your name."),validator: (value) {
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
                  if (provider.globalKeyUpdate.currentState!.validate()) {

                    provider.updateStudent(id, oldImagePath: image);
                    Navigator.pop(context);
                    provider.updateNameController.clear();
                    provider.clearImage();
                    FocusScope.of(context).unfocus();
                  }
                }, child: Text("Update Task")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
