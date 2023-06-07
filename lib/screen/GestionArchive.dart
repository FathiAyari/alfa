import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/Facture.dart';

class GestionArchive extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'client': 'John Doe', 'date': '10/04/2023'},
    {'client': 'Jane Smith', 'date': '12/04/2023'},
    {'client': 'Bob Johnson', 'date': '15/04/2023'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion Archive'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Action à effectuer lors du clic sur le bouton "Scanner"
                    // Par exemple, lancer une fonctionnalité de scanner de codes
                  },
                  icon: Icon(Icons.scanner),
                  label: Text('Scanner'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Facture()),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text('Ajouter'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher',
                      alignLabelWithHint: true,
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Client')),
                    DataColumn(label: Text('Date')),
                  ],
                  rows: data
                      .map((e) => DataRow(cells: [
                            DataCell(Text(e['client'])),
                            DataCell(Text(e['date'])),
                          ]))
                      .toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              // Action à effectuer lors du clic sur le bouton "Imprimer"
            },
            icon: Icon(Icons.print),
            label: Text('Imprimer'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
