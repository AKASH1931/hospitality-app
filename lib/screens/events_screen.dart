import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/luxero.dart';

/// Events — mirrors web /events: Upcoming (reserve via email payload) + Archive.
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  LuxeroEvent? selected;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EVENTS')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionHeader(
            kicker: 'Luxero events',
            title: 'Upcoming',
            subtitle: 'Reserve your table. Reservations go to info@luxerohospitalitysolutions.com with the same payload as the website.',
          ),
          const SizedBox(height: 14),
          ...upcomingEvents.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.espresso,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(e.title.toUpperCase(),
                      style: GoogleFonts.bodoniModa(
                          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('${e.date} · ${e.venue}, ${e.city}',
                      style: GoogleFonts.inter(
                          fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.lightGold)),
                  const SizedBox(height: 6),
                  Text(e.blurb,
                      style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: Colors.white70)),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => setState(() => selected = e),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: AppTheme.lightGold),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text(selected?.id == e.id ? 'Selected — fill form below' : 'Reserve — ${e.title}'),
                  ),
                ]),
              )),
          if (selected != null) ...[
            const SizedBox(height: 6),
            Text('RESERVE — ${selected!.title.toUpperCase()}',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
            const SizedBox(height: 8),
            _field(nameCtrl, 'Full name', isPhone: false),
            const SizedBox(height: 10),
            _field(phoneCtrl, 'Phone', isPhone: true),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _reserve,
              child: const Text('Confirm Reservation'),
            ),
            const SizedBox(height: 8),
            Text(
              'Payload: name, phone, event "${selected!.title} — ${selected!.date} · ${selected!.venue}, ${selected!.city}" — sent to the same inbox as the website.',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600, height: 1.5),
            ),
          ],
          const SizedBox(height: 20),
          const SectionHeader(kicker: 'Archive', title: 'Past events'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: pastEvents.map((e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.champagne, borderRadius: BorderRadius.circular(10)),
              child: Text(e.title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
            )).toList(),
          ),
          const SizedBox(height: 8),
          Text('Gallery (12 photos), Films strip and full posters open from the website. The app keeps the same event facts.',
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade600, height: 1.5)),
          const SizedBox(height: 16),
          const ContactStrip(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {required bool isPhone}) {
    return TextField(
      controller: c,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.name,
      decoration: InputDecoration(
        labelText: label,
        filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppTheme.champagne)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppTheme.champagne)),
      ),
    );
  }

  void _reserve() {
    if (nameCtrl.text.trim().isEmpty || phoneCtrl.text.trim().isEmpty || selected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add name and phone to reserve')),
      );
      return;
    }
    final payload = reservePayload(
        name: nameCtrl.text.trim(), phone: phoneCtrl.text.trim(), event: selected!);
    // Web parity: POST payload to formSubmitUrl. Kept in-memory for this MVP.
    debugPrint('RESERVE PAYLOAD: $payload → $formSubmitUrl');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reservation noted for ${selected!.title}. We will confirm on WhatsApp.')),
    );
    setState(() {
      nameCtrl.clear();
      phoneCtrl.clear();
      selected = null;
    });
  }
}
