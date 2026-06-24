class Attendance {
  final int? id;
  final int studentId;
  final String date;
  final String status;
  final String? remarks;

  Attendance({
    this.id,
    required this.studentId,
    required this.date,
    required this.status,
    this.remarks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'date': date,
      'status': status,
      'remarks': remarks,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      studentId: map['student_id'],
      date: map['date'],
      status: map['status'],
      remarks: map['remarks'],
    );
  }
}
