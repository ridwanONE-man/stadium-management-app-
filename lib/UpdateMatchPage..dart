import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'match_provider.dart';

class UpdateMatchPage extends StatefulWidget {
  final int matchIndex;

  const UpdateMatchPage({Key? key, required this.matchIndex}) : super(key: key);

  @override
  _UpdateMatchPageState createState() => _UpdateMatchPageState();
}

class _UpdateMatchPageState extends State<UpdateMatchPage> {
  final TextEditingController scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final match = matchProvider.matches[widget.matchIndex];

    scoreController.text = match.score;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Match'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('League: ${match.league}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Home Team: ${match.homeTeam}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Away Team: ${match.awayTeam}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Date: ${match.date}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Time: ${match.time}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Venue: ${match.venue}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: scoreController,
              decoration: InputDecoration(
                labelText: 'Enter Score (Home - Away)',
                labelStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  matchProvider.updateMatchScore(widget.matchIndex, scoreController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Score updated!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: const Text('Update Score', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
