import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 4 - Event Handling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E75B6)),
        useMaterial3: true,
      ),
      home: const EventHandlingScreen(),
    );
  }
}

class EventHandlingScreen extends StatefulWidget {
  const EventHandlingScreen({super.key});
  @override
  State<EventHandlingScreen> createState() => _EventHandlingScreenState();
}

class _EventHandlingScreenState extends State<EventHandlingScreen> {
  int counter = 0;
  String lastEvent = 'No event yet';
  Color bgColor = const Color(0xFFEBF5FF);
  final textController = TextEditingController();
  String submittedText = '';
  bool switchValue = false;
  double sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Event Handling',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E75B6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Button Events'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => setState(() {
                    counter++;
                    lastEvent = 'Increment tapped';
                  }),
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                Text(
                  '$counter',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3864),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => setState(() {
                    if (counter > 0) counter--;
                    lastEvent = 'Decrement tapped';
                  }),
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _sectionTitle('Text Input Event'),
            const SizedBox(height: 12),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Type something and submit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => setState(() {
                    submittedText = textController.text;
                    lastEvent = 'Text submitted: "$submittedText"';
                    textController.clear();
                  }),
                ),
              ),
              onSubmitted: (val) => setState(() {
                submittedText = val;
                lastEvent = 'Text submitted: "$submittedText"';
                textController.clear();
              }),
            ),
            if (submittedText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'You submitted: $submittedText',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            _sectionTitle('Toggle & Slider Events'),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dark Mode Toggle',
                          style: TextStyle(fontSize: 16),
                        ),
                        Switch(
                          value: switchValue,
                          onChanged: (val) => setState(() {
                            switchValue = val;
                            bgColor = val
                                ? const Color(0xFF1A1A2E)
                                : const Color(0xFFEBF5FF);
                            lastEvent =
                                'Switch: ${val ? "ON" : "OFF"}';
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Brightness: ${(sliderValue * 100).toInt()}%'),
                    Slider(
                      value: sliderValue,
                      onChanged: (val) => setState(() {
                        sliderValue = val;
                        lastEvent =
                            'Slider: ${(val * 100).toInt()}%';
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle('Gesture Detection'),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => setState(() => lastEvent = 'Box tapped!'),
              onLongPress: () =>
                  setState(() => lastEvent = 'Box long pressed!'),
              onDoubleTap: () =>
                  setState(() => lastEvent = 'Box double tapped!'),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E75B6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Tap / Double Tap / Long Press me!',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F3864),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Last Event: $lastEvent',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F3864),
      ),
    );
  }
}
