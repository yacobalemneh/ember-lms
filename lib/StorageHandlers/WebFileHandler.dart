
import 'package:universal_html/html.dart';

class FileHandler {

  getFile(Function(dynamic) fileRetrieved) async {

    final InputElement input = FileUploadInputElement();
    input.click();

    input.onChange.listen((e) async {

      final File file = input.files.first;
      final reader = new FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((loadEndEvent) async {
        fileRetrieved(file);
        },
      );

    });
  }

}