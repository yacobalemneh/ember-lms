
import 'StorageStub.dart';




class StorageHandler {

  String storagePath;
  Function(String) onStorageComplete;
  
  StorageHandler({this.onStorageComplete, this.storagePath});

  put(var file, String fileName) {
    Storage().putData(file, fileName, storagePath).then((value) {
      onStorageComplete(value);
    });
  }

}













// static FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://ember-11eb1.appspot.com');
// static fb.StorageReference webStorage = fb.storage().refFromURL('gs://ember-11eb1.appspot.com');
//
// static String schoolFolder = FirebaseDB.schoolName;
//
// static getFileUrl(String schoolName, String fileName, String className)  {
//  var url = storage.ref().child('$schoolName/$className/$fileName').getDownloadURL();
//
//  return url;
// }

// static addFile(var file, String fileName, String schoolName, String className, String subject) async  {
//
//   var task = await storage.ref().child(schoolName).child('$className/$fileName').putFile(file).onComplete;
//   var url = await task.ref.getDownloadURL();
//
//
//   await FirebaseDB.addFileToClass(
//        subject, className, fileName, url);
//
// }
//
// static addFileForWeb(var file) {
//
//   webStorage.child('test2').put(file);
//   // var url = await task.onStateChanged
//
//   // return url;
//
// }


