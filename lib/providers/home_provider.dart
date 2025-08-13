import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqlite_image_crud/utils/db_helper.dart';

class HomeProvider with ChangeNotifier {

  DbHelper dbHelper=DbHelper();
  XFile? imageStore;

  var globalKeyAdd=GlobalKey<FormState>();
  TextEditingController addNameController=TextEditingController();

  var globalKeyUpdate=GlobalKey<FormState>();
  TextEditingController updateNameController=TextEditingController();

  List<Map<String,dynamic>> userData=[];
  Future<void> getCameraAccess() async {
    final ImagePicker picker = ImagePicker();
    var status = await Permission.camera.status;
    if(status.isGranted){
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if(photo != null){
        imageStore=photo;
        notifyListeners();
      }
    }else if(status.isDenied){
      var status = await Permission.camera.request();
      if(status.isGranted){
        final XFile? photo = await picker.pickImage(source: ImageSource.camera);
        if(photo != null){
          imageStore=photo;
          notifyListeners();
        }
      }
    }
  }
  Future<void> getGalleryAccess() async {
    final ImagePicker picker = ImagePicker();
    var status = await Permission.photos.status;
    if(status.isGranted){
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if(photo != null){
        imageStore=photo;
        notifyListeners();
      }
    }else if(status.isDenied){
      var status = await Permission.photos.request();
      if(status.isGranted){
        final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
        if(photo != null){
          imageStore=photo;
          notifyListeners();
        }
      }
    }
  }

  Future<void> addStudent() async {
    await dbHelper.insertData({
      DbHelper.COLUMN_NAME : addNameController.text.toString(),
      DbHelper.COLUMN_IMAGE_PATH : imageStore!.path
    });
    getAllData();
  }

  Future<void> getAllData() async {
    userData= await dbHelper.fetchAllData();
    notifyListeners();
  }
}