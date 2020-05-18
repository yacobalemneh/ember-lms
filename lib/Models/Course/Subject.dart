class Subject {

  String subjectName;
  int classesInSubject;



  Subject({this.subjectName});

  Map<String, dynamic> toMap() {
    return {
      'subject_name' : subjectName,
    };
  }

}