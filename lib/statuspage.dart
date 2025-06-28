// statuspage.dart
import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('League Status'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh logic if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.emoji_events, size: 40, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Current League Standings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Table Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Team',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'Points',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'Rank',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),

          const Divider(),

          // List of Teams with Points and Ranks
          Expanded(
            child: ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return TeamRow(
                  teamName: team['name'],
                  points: team['points'],
                  rank: index + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Data for teams
List<Map<String, dynamic>> teams = [
  {"name": "UMMA FC", "points": 42},
  {"name": "Tigers", "points": 36},
  {"name": "Eagles", "points": 34},
  {"name": "Spartans", "points": 30},
  {"name": "Warriors", "points": 27},
  {"name": "Rangers", "points": 24},
];

// A custom widget for displaying each team row
class TeamRow extends StatelessWidget {
  final String teamName;
  final int points;
  final int rank;

  const TeamRow({
    Key? key,
    required this.teamName,
    required this.points,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Team Icon and Name
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  teamName[0],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                teamName,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),

          // Points Column
          Text(
            '$points',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // Rank Column with Rank Icons
          Row(
            children: [
              Text(
                '$rank',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (rank == 1) ...[
                const Icon(Icons.star, color: Colors.yellow, size: 20),
              ] else if (rank == 2) ...[
                const Icon(Icons.star_half, color: Colors.grey, size: 20),
              ] else if (rank == 3) ...[
                const Icon(Icons.star_outline, color: Colors.brown, size: 20),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

