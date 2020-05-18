
import 'dart:io';
import 'package:ember/StorageHandlers/BaseStorage.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Storage extends BaseStorage<File> {

  static FirebaseStorage storage = FirebaseStorage(storageBucket: BaseStorage.storageURL);

  @override
  Future<String> putData(File data, String fileName, String storageLocation) async {
    // TODO: implement putData
    var task = await storage.ref().child(storageLocation + '/' + fileName).putFile(data).onComplete;
    var url = await task.ref.getDownloadURL();

    return url;
  }

}
















//static getFileUrl(String schoolName, String fileName, String className)  async {
//  var url = await storage.ref().child('$schoolName/$className/$fileName').getDownloadURL();
//
//  print('In function $url');
//
//  return url;
//}
//
//static addFile(var file, String fileName, String schoolName, String className, String subject) async  {
//
//  print('Filename: $fileName');
//  print('Schoolname: $schoolName');
//  print('className: $className');
//
//  var task = await storage.ref().child(schoolName).child('$className/$fileName').putFile(file).onComplete;
//  var url = await task.ref.getDownloadURL();
//
////    await FirebaseDB.addFileToClass(subject, className, fileName, url);
//
//}
