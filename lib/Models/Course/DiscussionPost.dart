
class DiscussionPost {

  String post;
  String first_name;
  String last_name;
  String role;
  DateTime date;
  String userId;


  DiscussionPost({this.post, this.first_name, this.last_name, this.role, this.userId}) {
    this.date = DateTime.now();
  }

  toMap() {
    return {
      'post' : post,
      'first_name' : first_name,
      'last_name' : last_name,
      'role' : role,
      'id' : userId,
      'date' : date
    };
  }

}