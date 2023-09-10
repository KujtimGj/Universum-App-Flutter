class Student{
  String fullName,email,studentID, studentField,generation;

  Student({required this.fullName, required this.email,required this.studentID, required this.studentField, required this.generation});

  factory Student.fromJson(Map<String, dynamic> fromJson){
    final studentData = fromJson['student'];
    return Student(
        fullName: fromJson['fullName'],
        email: fromJson['email'],
        studentID: studentData['studentID'],
        studentField: studentData['studentField'],
        generation: studentData['generation']
    );
  }
}