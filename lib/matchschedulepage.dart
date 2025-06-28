import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'match_provider.dart';
import 'MatchDetailsPage.dart'; // Required for navigation

class MatchSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 8,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Match Schedule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: matchProvider.matches.isEmpty
          ? const Center(
        child: Text(
          'No matches scheduled yet!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: matchProvider.matches.length,
        itemBuilder: (context, index) {
          final match = matchProvider.matches[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchDetailsPage(matchIndex: index),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Match Details Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${match.homeTeam} vs ${match.awayTeam}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              icon: Icons.date_range,
                              text: match.date,
                            ),
                            const SizedBox(height: 5),
                            _buildInfoRow(
                              icon: Icons.access_time,
                              text: match.time,
                            ),
                            const SizedBox(height: 5),
                            _buildInfoRow(
                              icon: Icons.sports_soccer,
                              text: match.league,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Score: ${match.score}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Buy Ticket Button
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MatchDetailsPage(matchIndex: index),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Buy Ticket',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
