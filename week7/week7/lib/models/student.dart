class Student {
  final int? id;
  final String name;
  final String course;
  final int yearOfStudy;
  final String phoneNumber;

  Student({
    this.id,
    required this.name,
    required this.course,
    required this.yearOfStudy,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'year_of_study': yearOfStudy,
      'phone_number': phoneNumber,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      course: map['course'],
      yearOfStudy: map['year_of_study'],
      phoneNumber: map['phone_number'],
    );
  }
}
