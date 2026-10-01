import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/worker.dart';
import '../models/booking.dart';
import '../data/app_state.dart';
import '../theme/app_theme.dart';

class BookingScreen extends StatefulWidget {
  final Worker worker;
  const BookingScreen({super.key, required this.worker});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime date = DateTime.now().add(const Duration(days: 1));
  String shift = 'Full Day';
  final venueCtrl = TextEditingController();

  int get price => shift == 'Full Day' ? widget.worker.dayRate : (widget.worker.dayRate * 0.6).round();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm booking')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
            child: Row(children: [
              CircleAvatar(backgroundColor: AppTheme.midnight, child: Text(widget.worker.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.worker.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                Text('${widget.worker.category.toUpperCase()} · ${widget.worker.rating.toStringAsFixed(1)} / 5', style: TextStyle(color: Colors.grey.shade600)),
              ])),
            ]),
          ),
          const SizedBox(height: 16),
          const Text('Date', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final d = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 90)), initialDate: date);
              if (d != null) setState(() => date = d);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
              child: Row(children: [const Icon(Icons.calendar_month_rounded), const SizedBox(width: 10), Text(DateFormat('EEE, dd MMM yyyy').format(date), style: const TextStyle(fontWeight: FontWeight.w700)), const Spacer(), const Text('Change', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w700))]),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Shift', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Morning', 'Evening', 'Full Day'].map((s) {
              final sel = s == shift;
              return ChoiceChip(label: Text(s), selected: sel, onSelected: (_) => setState(() => shift = s));
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text('Venue', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          TextField(
            controller: venueCtrl,
            decoration: InputDecoration(hintText: 'Hotel / banquet / address…', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200))),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppTheme.midnight, borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              const Text('Total payable', style: TextStyle(color: Colors.white70)),
              const Spacer(),
              Text('Rs $price', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            ]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (venueCtrl.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add the venue address')));
                return;
              }
              context.read<AppState>().addBooking(Booking(id: DateTime.now().millisecondsSinceEpoch.toString(), worker: widget.worker, date: date, shift: shift, venue: venueCtrl.text.trim(), status: 'Confirmed', totalPrice: price));
              Navigator.popUntil(context, (r) => r.isFirst);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking confirmed')));
            },
            child: const Text('Confirm & Pay Later'),
          ),
        ],
      ),
    );
  }
}
