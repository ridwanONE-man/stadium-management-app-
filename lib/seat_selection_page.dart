import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'match_provider.dart';
import 'ticketpage.dart';

class SeatSelectionPage extends StatefulWidget {
  final int matchIndex;

  const SeatSelectionPage({Key? key, required this.matchIndex}) : super(key: key);

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  String? selectedSeatType;
  int? seatPrice;

  void proceedToPayment() {
    if (selectedSeatType != null) {
      final matchProvider = Provider.of<MatchProvider>(context, listen: false);

      // Book the ticket
      matchProvider.bookTicket(
        matchIndex: widget.matchIndex,
        seatType: selectedSeatType!,
        seatPrice: seatPrice!,
        paymentStatus: 'Paid', // Assume payment is successful for simplicity
      );

      // Navigate to TicketPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TicketPage()),
      );
    } else {
      // Show an error if no seat type is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a seat type!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final match = matchProvider.matches[widget.matchIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seat Type', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your seat type:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.blue.shade50,
              child: RadioListTile<String>(
                title: Text(
                  'VIP - ${match.vipSeatsAvailable} seats available (1000 Ksh)',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                value: 'VIP',
                groupValue: selectedSeatType,
                onChanged: (value) {
                  if (match.vipSeatsAvailable > 0) {
                    setState(() {
                      selectedSeatType = value;
                      seatPrice = 1000;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No VIP seats available!')),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.green.shade50,
              child: RadioListTile<String>(
                title: Text(
                  'Normal - ${match.normalSeatsAvailable} seats available (500 Ksh)',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                value: 'Normal',
                groupValue: selectedSeatType,
                onChanged: (value) {
                  if (match.normalSeatsAvailable > 0) {
                    setState(() {
                      selectedSeatType = value;
                      seatPrice = 500;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No Normal seats available!')),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            if (selectedSeatType != null && seatPrice != null)
              Text(
                'Price: $seatPrice Ksh',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: proceedToPayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                ),
                child: const Text('Proceed to Payment', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
