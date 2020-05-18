
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileHandler {

  getFile(Function(dynamic) fileRetrieved) async {
    File file = await FilePicker.getFile();
    fileRetrieved(file);
  }

}