import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 8 Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EventHandlerScreen(),
    );
  }
}

class KeyboardController {
  String handleKey(String input) {
    if (input.isEmpty) return 'No input received';
    if (input.length < 3) return 'Input too short — minimum 3 characters';
    return 'Input received: $input';
  }

  String validateUsername(String username) {
    if (username.length < 3) return 'Username too short';
    return 'Valid username: $username';
  }
}

class GestureHandler {
  String tap() => 'Tap detected — button pressed';
  String swipeLeft() => 'Swipe Left — Previous Page';
  String swipeRight() => 'Swipe Right — Next Page';
  String longPress() => 'Long Press — Context Menu opened';
  String doubleTap() => 'Double Tap — Item selected';
}

class EventLogger {
  final List<String> _logs = [];

  void addLog(String event) => _logs.add('${_logs.length + 1}. $event');
  List<String> get logs => List.unmodifiable(_logs);
  void clear() => _logs.clear();
}

class EventHandlerScreen extends StatefulWidget {
  const EventHandlerScreen({super.key});

  @override
  State<EventHandlerScreen> createState() => _EventHandlerScreenState();
}

class _EventHandlerScreenState extends State<EventHandlerScreen> {
  final KeyboardController _keyboard = KeyboardController();
  final GestureHandler _gesture = GestureHandler();
  final EventLogger _logger = EventLogger();
  final TextEditingController _textController = TextEditingController();
  String _lastEvent = 'No event yet — interact with the app!';

  void _updateEvent(String event) {
    setState(() {
      _lastEvent = event;
      _logger.addLog(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 8 — Event Handling'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepPurple),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Last Event:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  const SizedBox(height: 4),
                  Text(_lastEvent, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Keyboard Input',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple)),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Type something...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.keyboard),
              ),
              onChanged: (val) => _updateEvent(_keyboard.handleKey(val)),
              onSubmitted: (val) =>
                  _updateEvent(_keyboard.validateUsername(val)),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _updateEvent(
                  _keyboard.validateUsername(_textController.text)),
              icon: const Icon(Icons.check),
              label: const Text('Validate Input'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Touch Gestures',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _updateEvent(_gesture.tap()),
              onDoubleTap: () => _updateEvent(_gesture.doubleTap()),
              onLongPress: () => _updateEvent(_gesture.longPress()),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.touch_app, size: 40, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('Tap, Double Tap, or Long Press here',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('(each triggers a different event)',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  _updateEvent(_gesture.swipeLeft());
                } else {
                  _updateEvent(_gesture.swipeRight());
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.swipe, size: 40, color: Colors.green),
                    SizedBox(height: 8),
                    Text('Swipe Left or Right here',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('(swipe direction determines the event)',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Event Log',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
                TextButton.icon(
                  onPressed: () => setState(() => _logger.clear()),
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: _logger.logs.isEmpty
                  ? const Center(child: Text('No events logged yet'))
                  : ListView.builder(
                      itemCount: _logger.logs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            _logger.logs[index],
                            style: const TextStyle(fontSize: 13),
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
