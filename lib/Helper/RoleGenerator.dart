

getRole(String role) {
  if (role == 'student')
    return 'Student';
  else if (role == 'instructor')
    return 'Instructor';
  else if (role == 'admin')
    return 'School Administrator';
  else
    return 'Parent';
}