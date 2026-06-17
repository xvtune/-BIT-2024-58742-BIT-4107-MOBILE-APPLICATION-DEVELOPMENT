import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 5 - Data Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E75B6)),
        useMaterial3: true,
      ),
      home: const DataManagementScreen(),
    );
  }
}

class Student {
  final String id;
  String name;
  String email;
  String course;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.course,
  });
}

class DataManagementScreen extends StatefulWidget {
  const DataManagementScreen({super.key});
  @override
  State<DataManagementScreen> createState() => _DataManagementScreenState();
}

class _DataManagementScreenState extends State<DataManagementScreen> {
  final List<Student> students = [
    Student(
      id: 'STU001',
      name: 'John Doe',
      email: 'john@uni.com',
      course: 'BSc Computer Science',
    ),
    Student(
      id: 'STU002',
      name: 'Jane Smith',
      email: 'jane@uni.com',
      course: 'BSc IT',
    ),
    Student(
      id: 'STU003',
      name: 'Ali Hassan',
      email: 'ali@uni.com',
      course: 'BSc Software Engineering',
    ),
  ];

  List<Student> filtered = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filtered = List.from(students);
  }

  void search(String query) {
    setState(() {
      filtered = students
          .where(
            (s) =>
                s.name.toLowerCase().contains(query.toLowerCase()) ||
                s.id.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  void addStudent() {
    final nameC = TextEditingController();
    final emailC = TextEditingController();
    final courseC = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: courseC,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameC.text.isNotEmpty) {
                setState(() {
                  final newStudent = Student(
                    id: 'STU00${students.length + 1}',
                    name: nameC.text,
                    email: emailC.text,
                    course: courseC.text,
                  );
                  students.add(newStudent);
                  filtered = List.from(students);
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void editStudent(Student student) {
    final nameC = TextEditingController(text: student.name);
    final emailC = TextEditingController(text: student.email);
    final courseC = TextEditingController(text: student.course);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: courseC,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                student.name = nameC.text;
                student.email = emailC.text;
                student.course = courseC.text;
                filtered = List.from(students);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void deleteStudent(Student student) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Remove ${student.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                students.remove(student);
                filtered = List.from(students);
              });
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF5FF),
      appBar: AppBar(
        title: const Text(
          'Data Management',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E75B6),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: search,
              decoration: InputDecoration(
                labelText: 'Search students...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Total: ${filtered.length} students',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3864),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No students found'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final student = filtered[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF2E75B6),
                            child: Text(
                              student.name[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            student.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${student.id} • ${student.course}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xFF2E75B6),
                                ),
                                onPressed: () => editStudent(student),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => deleteStudent(student),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2E75B6),
        onPressed: addStudent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Student', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
