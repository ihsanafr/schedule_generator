import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:schedule_generator/services/openai_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String? Priority;
  bool isLoading = false; //ini kosong karena tidak punya data apa2
  String scheduleResult = "";

  void _addTask() {
    if (taskController.text.isNotEmpty &&
        Priority != null &&
        durationController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'name': taskController.text,
          'priority': Priority,
          'Duration': int.tryParse(durationController.text) ?? 30,
          'Dateline': "Tidak ada"
        });
      });
      taskController.clear();
      durationController.clear();
      Priority = null;
    }
  }

  Future<void> _generateSchedule() async {
    setState(() => isLoading = true);
    try {
      String schedule = await OpenAiService.generateSchedule(tasks);
      setState(() => scheduleResult = schedule);
    }  catch (e){
      setState(() => scheduleResult = "Failed to generate schedule");
    }
    setState(() => isLoading = false);
    
  
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
