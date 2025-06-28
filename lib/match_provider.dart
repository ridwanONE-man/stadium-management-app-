import 'package:flutter/material.dart';

class Match {
  String league;
  String homeTeam;
  String awayTeam;
  String date;
  String time;
  String score;
  String venue;
  int vipSeatsAvailable;
  int normalSeatsAvailable;

  Match({
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.time,
    this.score = '0 - 0',
    this.venue = '',
    this.vipSeatsAvailable = 200, // Default to 200 VIP seats
    this.normalSeatsAvailable = 800, // Default to 800 Normal seats
  });
}

class MatchProvider with ChangeNotifier {
  final List<Match> _matches = [];
  final List<Map<String, dynamic>> _bookedTickets = [];

  List<Match> get matches => _matches;
  List<Map<String, dynamic>> get bookedTickets => _bookedTickets;

  /// Add a new match with default seat values
  void addMatch(Match match) {
    match.vipSeatsAvailable = 200; // Set VIP seats to 200
    match.normalSeatsAvailable = 800; // Set Normal seats to 800
    _matches.add(match);
    notifyListeners();
  }

  /// Update match score
  void updateMatchScore(int matchIndex, String score) {
    _matches[matchIndex].score = score;
    notifyListeners();
  }

  /// Update match venue
  void updateMatchVenue(int matchIndex, String venue) {
    _matches[matchIndex].venue = venue;
    notifyListeners();
  }

  /// Book a ticket for a match
  void bookTicket({
    required int matchIndex,
    required String seatType,
    required int seatPrice,
    required String paymentStatus,
  }) {
    final match = _matches[matchIndex];

    if (seatType == 'VIP' && match.vipSeatsAvailable > 0) {
      match.vipSeatsAvailable--;
    } else if (seatType == 'Normal' && match.normalSeatsAvailable > 0) {
      match.normalSeatsAvailable--;
    } else {
      return; // No seats available for the chosen type
    }

    _bookedTickets.add({
      'homeTeam': match.homeTeam,
      'awayTeam': match.awayTeam,
      'league': match.league,
      'date': match.date,
      'time': match.time,
      'seatType': seatType,
      'seatPrice': seatPrice,
      'paymentStatus': paymentStatus,
    });

    notifyListeners();
  }

  /// Cancel a booked ticket (optional functionality)
  void cancelTicket(int ticketIndex) {
    final ticket = _bookedTickets[ticketIndex];
    final matchIndex = _matches.indexWhere((match) =>
    match.homeTeam == ticket['homeTeam'] &&
        match.awayTeam == ticket['awayTeam'] &&
        match.date == ticket['date']);

    if (matchIndex != -1) {
      final seatType = ticket['seatType'];
      if (seatType == 'VIP') {
        _matches[matchIndex].vipSeatsAvailable++;
      } else if (seatType == 'Normal') {
        _matches[matchIndex].normalSeatsAvailable++;
      }
    }

    _bookedTickets.removeAt(ticketIndex);
    notifyListeners();
  }

  /// Adjust seat availability (admin functionality)
  void updateAvailableSeats({
    required int matchIndex,
    required int vipSeats,
    required int normalSeats,
  }) {
    _matches[matchIndex].vipSeatsAvailable = vipSeats;
    _matches[matchIndex].normalSeatsAvailable = normalSeats;
    notifyListeners();
  }
}
