import 'package:flutter/material.dart';
import 'create_match_page.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final TextEditingController _leagueController = TextEditingController();
  final TextEditingController _teamController = TextEditingController();
  List<String> leagues = [];
  Map<String, List<String>> teams = {};
  String? _selectedLeague;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create League and Teams',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _leagueController,
              decoration: InputDecoration(
                labelText: 'League Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  leagues.add(_leagueController.text);
                  teams[_leagueController.text] = [];
                  _leagueController.clear();
                });
              },
              child: const Text('Add League'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedLeague,
              items: leagues
                  .map((league) => DropdownMenuItem(value: league, child: Text(league)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLeague = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Select League'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _teamController,
              decoration: InputDecoration(
                labelText: 'Team Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_selectedLeague != null) {
                  setState(() {
                    teams[_selectedLeague]!.add(_teamController.text);
                    _teamController.clear();
                  });
                }
              },
              child: const Text('Add Team'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateMatchPage(teams: teams)),
                );
              },
              child: const Text('Proceed to Create Matches'),
            ),
          ],
        ),
      ),
    );
  }
}
