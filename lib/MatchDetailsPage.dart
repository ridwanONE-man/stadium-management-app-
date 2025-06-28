import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'match_provider.dart';
import 'seat_selection_page.dart';

class MatchDetailsPage extends StatelessWidget {
  final int matchIndex;

  const MatchDetailsPage({Key? key, required this.matchIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final match = matchProvider.matches[matchIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Details', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.blue.shade500,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blue.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Match Header with Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(Icons.sports_soccer, size: 50, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      '${match.homeTeam} vs ${match.awayTeam}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Match Info Section with Blue Gradient Cards
              _buildMatchInfoCard('Home Team', match.homeTeam),
              _buildMatchInfoCard('Away Team', match.awayTeam),
              _buildMatchInfoCard('Date', match.date),
              _buildMatchInfoCard('Time', match.time),
              _buildMatchInfoCard('Venue', match.venue),
              const SizedBox(height: 20),

              // Score Section with Blue Highlight
              _buildScoreCard(match.score),
              const SizedBox(height: 30),

              // Buy Ticket Button with Blue Accent
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SeatSelectionPage(matchIndex: matchIndex)),
                    );
                  },
                  child: const Text('Buy Ticket', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    backgroundColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 8,
                    shadowColor: Colors.blue.shade300,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Update Match Button (Admin Only) with Slightly Different Shade
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Update Match Page (Admin Only)
                  },
                  child: const Text('Update Match', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 8,
                    shadowColor: Colors.blue.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Match Info Card with Blue Gradient
  Widget _buildMatchInfoCard(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        color: Colors.blue.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ListTile(
          title: Text(
            '$label: $value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.blue.shade500),
        ),
      ),
    );
  }

  // Score Card with Blue Background for Emphasis
  Widget _buildScoreCard(String score) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade300,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        'Score: $score',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
      ),
    );
  }
}
