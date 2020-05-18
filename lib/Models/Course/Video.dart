

class Video {

  String url;
  String title;
  String description;
  DateTime date;

  String displayableDate;
  String videoDocId;


  Video({this.url, this.title, this.description, this.displayableDate, this.videoDocId}) {
    this.date = DateTime.now();
  }


  Map<String, dynamic> toMap() {
    return {
      'url' : url,
      'title' : title,
      'date' : date,
      'description' : description,
    };
  }

  static fromMap(var video) {

    return Video(
      url: video['url'],
      title: video['title'],
      description: video['description'],
      displayableDate: video['date'],
    );

  }

}