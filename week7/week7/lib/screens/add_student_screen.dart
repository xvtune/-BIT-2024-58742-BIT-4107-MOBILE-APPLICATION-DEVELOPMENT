import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/student.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _phoneController = TextEditingController();
  int _selectedYear = 1;
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final students = await DatabaseHelper.instance.getAllStudents();
    setState(() => _students = students);
  }

  Future<void> _addStudent() async {
    if (_nameController.text.isEmpty ||
        _courseController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final student = Student(
      name: _nameController.text.trim(),
      course: _courseController.text.trim(),
      yearOfStudy: _selectedYear,
      phoneNumber: _phoneController.text.trim(),
    );

    await DatabaseHelper.instance.insertStudent(student);
    _nameController.clear();
    _courseController.clear();
    _phoneController.clear();
    setState(() => _selectedYear = 1);
    _loadStudents();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student added successfully!')),
    );
  }

  Future<void> _deleteStudent(int id) async {
    await DatabaseHelper.instance.deleteStudent(id);
    _loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Students'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _selectedYear,
              decoration: const InputDecoration(
                labelText: 'Year of Study',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              items: [1, 2, 3, 4].map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text('Year $year'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedYear = val!),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addStudent,
                icon: const Icon(Icons.add),
                label: const Text('Add Student'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Registered Students',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _students.isEmpty
                  ? const Center(child: Text('No students yet'))
                  : ListView.builder(
                      itemCount: _students.length,
                      itemBuilder: (context, index) {
                        final s = _students[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.person, color: Colors.blue),
                            title: Text(s.name),
                            subtitle: Text('${s.course} • Year ${s.yearOfStudy}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteStudent(s.id!),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
