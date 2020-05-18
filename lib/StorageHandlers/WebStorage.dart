
import 'package:firebase/firebase.dart' as fb;
import 'package:ember/StorageHandlers/BaseStorage.dart';



class Storage extends BaseStorage<String> {

  static fb.StorageReference webStorage = fb.storage().refFromURL(BaseStorage.storageURL);

  @override
  Future<String> putData(dynamic data, String fileName, String storageLocation) async {

    var storagePath = storageLocation + '/' + fileName;
    var task = webStorage.child(storagePath).put(data);
    String downloadURL;

    await task.future.then((snapShot) async {
      await snapShot.ref.getDownloadURL().then((url) {
        downloadURL = url.toString();
      });
    });

    return downloadURL;
  }



















//    var converted = Utf8Encoder().convert(data);
//    webStorage.child(storageLocation + '/' + fileName).put(converted);
//    var url = await webStorage.getDownloadURL();
//    task.onStateChanged.listen((event) async {
//      if (event.state == fb.TaskState.SUCCESS) {
//        url = await webStorage.getDownloadURL();
//      }
//    });
//  putData(String data, String fileName, String storageLocation) async {
//    var converted = Utf8Encoder().convert(data);
//    webStorage.child(storageLocation + '/' + fileName).put(converted);
//
//  }

}