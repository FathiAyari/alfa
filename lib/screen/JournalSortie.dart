import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(JournalSortie());

class JournalSortie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal de sortie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogScreen(),
    );
  }
}

class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<String> logs = [];

  void addToLog(String message) {
    setState(() {
      logs.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal de sortie'),
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(logs[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addToLog('Un nouvel événement s\'est produit !');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
