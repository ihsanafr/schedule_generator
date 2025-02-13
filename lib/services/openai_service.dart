import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenAiService {
  static const String apikey =
      "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";
  static const String baseUrl = "https://api.openai.com/v1/chat/completions";

  static Future<String> generateSchedule(
      List<Map<String, dynamic>> tasks) async {
    final prompt = _buildPrompt(tasks);

    final response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apikey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "store": true,
          "messages": [
            {
              "role": "system",
              "content":
                  "you are a student an you need to schedule the following tasks, please provided a schedule for the tasks"
            },
            {"role": "user", "content": prompt}
          ],
          "max_tokens": 500
        }));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"];
    } else {
      throw Exception("Failed to generate schedule");
    }
  }

  static String _buildPrompt(List<Map<String, dynamic>> tasks) {
    String taskList = tasks.map((task) =>
        "- ${task['name']} (Priority: ${task['priority']},Duration: ${task['Duration']} minutes),Deadline:${task['deadline']}"
            ).join("\n");
    return "buatkan jadwal harian yg optimal untuk tugas tugas berikut: \n $taskList \n susun jadwal dari pagi hingga malam dengan efisien dan pastikan jadwal tersebut sesuai dengan deadline dari setia[ tugas";}
}
