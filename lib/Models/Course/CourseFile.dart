
class CourseFile {

  String fileName;
  String description;
  String url;
  DateTime date;

  String displayableDate;
  String fileDocId;

  CourseFile({this.fileName, this.description, this.url, this.displayableDate, this.fileDocId}) {
    this.date = DateTime.now();
  }

  toMap() {
    return {
      'file_name' : fileName,
      'description' : description,
      'url' : url,
      'date' : date
    };
  }

}
