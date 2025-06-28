import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'match_provider.dart';

class CreateMatchPage extends StatefulWidget {
  final Map<String, List<String>> teams;

  const CreateMatchPage({Key? key, required this.teams}) : super(key: key);

  @override
  _CreateMatchPageState createState() => _CreateMatchPageState();
}

class _CreateMatchPageState extends State<CreateMatchPage> {
  String? selectedLeague;
  String? selectedHomeTeam;
  String? selectedAwayTeam;
  final TextEditingController matchDateController = TextEditingController();
  final TextEditingController matchTimeController = TextEditingController();
  final TextEditingController venueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Match',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              hint: const Text(
                'Select League',
                style: TextStyle(fontSize: 18),
              ),
              value: selectedLeague,
              items: widget.teams.keys
                  .map(
                    (league) => DropdownMenuItem(
                  value: league,
                  child: Text(
                    league,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLeague = value;
                  selectedHomeTeam = null;
                  selectedAwayTeam = null;
                });
              },
              decoration: InputDecoration(
                labelText: 'League',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              hint: const Text(
                'Select Home Team',
                style: TextStyle(fontSize: 18),
              ),
              value: selectedHomeTeam,
              items: selectedLeague == null
                  ? []
                  : widget.teams[selectedLeague]!
                  .map(
                    (team) => DropdownMenuItem(
                  value: team,
                  child: Text(
                    team,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedHomeTeam = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Home Team',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              hint: const Text(
                'Select Away Team',
                style: TextStyle(fontSize: 18),
              ),
              value: selectedAwayTeam,
              items: selectedLeague == null
                  ? []
                  : widget.teams[selectedLeague]!
                  .where((team) => team != selectedHomeTeam)
                  .map(
                    (team) => DropdownMenuItem(
                  value: team,
                  child: Text(
                    team,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAwayTeam = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Away Team',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: matchDateController,
              decoration: InputDecoration(
                labelText: 'Match Date (YYYY-MM-DD)',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: matchTimeController,
              decoration: InputDecoration(
                labelText: 'Match Time (HH:MM)',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: venueController,
              decoration: InputDecoration(
                labelText: 'Venue',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedLeague != null &&
                      selectedHomeTeam != null &&
                      selectedAwayTeam != null &&
                      matchDateController.text.isNotEmpty &&
                      matchTimeController.text.isNotEmpty &&
                      venueController.text.isNotEmpty) {
                    Match newMatch = Match(
                      league: selectedLeague!,
                      homeTeam: selectedHomeTeam!,
                      awayTeam: selectedAwayTeam!,
                      date: matchDateController.text,
                      time: matchTimeController.text,
                      venue: venueController.text,
                    );

                    matchProvider.addMatch(newMatch);

                    setState(() {
                      selectedLeague = null;
                      selectedHomeTeam = null;
                      selectedAwayTeam = null;
                      matchDateController.clear();
                      matchTimeController.clear();
                      venueController.clear();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Match created successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Create Match',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
