import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw; // Alias for pdf widgets
import 'match_provider.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final bookedTickets = matchProvider.bookedTickets;

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
          'My Tickets',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: bookedTickets.isEmpty
          ? const Center(
        child: Text(
          'No tickets booked yet!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bookedTickets.length,
        itemBuilder: (context, index) {
          final ticket = bookedTickets[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 12),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎫 ${ticket['homeTeam']} vs ${ticket['awayTeam']}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoText(
                        label: 'League',
                        value: ticket['league'],
                      ),
                      _buildInfoText(
                        label: 'Date',
                        value: ticket['date'],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildInfoText(label: 'Time', value: ticket['time']),
                  const SizedBox(height: 15),
                  _buildInfoText(
                    label: 'Seat Type',
                    value: ticket['seatType'],
                    isBold: true,
                  ),
                  _buildInfoText(
                    label: 'Price',
                    value: '${ticket['seatPrice']} Ksh',
                    isBold: true,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Payment: ${ticket['paymentStatus']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _printTicket(ticket);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Print Ticket',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoText({
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Text(
      '$label: $value',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white70,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  void _printTicket(Map<String, dynamic> ticket) async {
    await Printing.layoutPdf(
      onLayout: (format) async {
        final doc = pw.Document();
        doc.addPage(
          pw.Page(
            build: (context) {
              return pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.blue, width: 2),
                  borderRadius: pw.BorderRadius.circular(20),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '🎫 Ticket for ${ticket['homeTeam']} vs ${ticket['awayTeam']}',
                      style: pw.TextStyle(
                          fontSize: 28, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('League: ${ticket['league']}',
                            style: const pw.TextStyle(fontSize: 18)),
                        pw.Text('Date: ${ticket['date']}',
                            style: const pw.TextStyle(fontSize: 18)),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text('Time: ${ticket['time']}',
                        style: const pw.TextStyle(fontSize: 18)),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      'Seat Type: ${ticket['seatType']}',
                      style: const pw.TextStyle(fontSize: 20),
                    ),
                    pw.Text(
                      'Price: ${ticket['seatPrice']} Ksh',
                      style: const pw.TextStyle(fontSize: 20),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Payment: ${ticket['paymentStatus']}',
                      style: pw.TextStyle(
                          fontSize: 18, color: PdfColors.green),
                    ),
                  ],
                ),
              );
            },
          ),
        );
        return doc.save();
      },
    );
  }
}
