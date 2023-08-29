import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduateproject/app_layout/app_layout_imports.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> reservedQuestions = [
    " New references about data structure",
    "Sample questions about data structure",
    "Names of researchers in the field of artificial intelligence",
    "Scientific conferences in the field of software engineering",
    "Classified scientific fields suitable for publishing research in the field of computer science",
    "Available Grants to support research projects in software field",
    " Websites to learn Python",
    " Books to learn computer architecture",
    "Books to learn  about university training methods",
    " Best websites to learn more about cybersecurity",
    // "Question bank for data structures?",
    // "Give me references for the Data Structures subject?",
    // "Do you have office hours?",
    // "What textbooks are required?",
    // "Is attendance mandatory?",
    // "Are there any assignments?",
    // "What is the grading policy?",
    // "Can you recommend additional resources?",
    // "Are there any prerequisites for this course?",
    // "How can I prepare for exams?"
  ];

  Future<String> getChatGPTResponse(String userInput) async {
    final apiKey = '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';
    final url = 'https://api.openai.com/v1/chat/completions';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final payload = {
      'messages': [
        {
          "role": "system",
          "content": "You're an assistant professor at a university"
        },
        {"role": "user", "content": userInput}
      ],
      'model': 'gpt-3.5-turbo',
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(payload));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final chatGPTReply = data['choices'][0]['message']['content'];
      return chatGPTReply;
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      return 'Error: Failed to get response';
    }
  }

  void handleQuestionTap(String question) async {
    final answer = await getChatGPTResponse(question);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Assistant Reply'),
          content: Text(answer),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(
          function: (){
        maybePop(context);
      }, title: 'Professor Assistant'),
      body: ListView.builder(
        itemCount: reservedQuestions.length,
        itemBuilder: (context, index) {
          final question = reservedQuestions[index];
          return ListTile(
            title: Text(question),
            onTap: () {
              handleQuestionTap(question);
            },
          );
        },
      ),
    );
  }
}
