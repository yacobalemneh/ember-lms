class Announcement {


  String announcer;
  String announcement;
  DateTime date;


  Announcement({this.announcer,  this.announcement}) {
    this.date = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'announcer' : announcer,
      'date' : date,
      'announcement' : announcement,
    };
  }


}

