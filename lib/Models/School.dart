
class School {

  final String schoolName;
  String schoolId;

  int studentCount;
  int instructorCount;
  int parentCount;
  int adminCount;
  int totalCount;
  int subjectCount;

  bool isHigerEd;
  bool hasAccess;

  DateTime serviceStartDate;
  DateTime serviceEndDate;



  School(
      {this.schoolName,

        this.isHigerEd,
        this.schoolId,
        this.studentCount,
        this.instructorCount,
        this.parentCount,
        this.adminCount,
        this.totalCount,
        this.subjectCount,
        this.hasAccess,
        this.serviceStartDate,
        this.serviceEndDate});

  factory School.fromMap(parsedData) {
    return School(
      schoolName: parsedData['school_name'],
      isHigerEd: parsedData['is_higher_ed'],
      schoolId: parsedData['school_id'],
      studentCount: parsedData['student_count'],
      instructorCount: parsedData['instructor_count'],
      parentCount: parsedData['parent_count'],
      adminCount: parsedData['admin_count'],
      totalCount: parsedData['total_count'],
      subjectCount: parsedData['subject_count'],
      hasAccess: parsedData['has_access'],
      serviceEndDate: parsedData['service_start_date'].toDate(),
      serviceStartDate: parsedData['service_end_date'].toDate(),
    );
  }

}

