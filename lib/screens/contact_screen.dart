import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/luxero.dart';

/// Contact — native 3-step quiz (same validation as web) + FAQ.
class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int step = 0;
  final Set<String> needs = {};
  final first = TextEditingController();
  final last = TextEditingController();
  final business = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final message = TextEditingController();
  bool privacy = false;
  bool sent = false;

  static const needOptions = ['Operations', 'F&B', 'Artists', 'Catering', 'Vendors', 'Training', 'Staff Hire'];

  @override
  void dispose() {
    first.dispose(); last.dispose(); business.dispose();
    email.dispose(); phone.dispose(); message.dispose();
    super.dispose();
  }

  bool get _step0Ok => needs.isNotEmpty;
  bool get _step1Ok =>
      first.text.trim().isNotEmpty &&
      last.text.trim().isNotEmpty &&
      business.text.trim().isNotEmpty &&
      email.text.trim().contains('@') &&
      phone.text.trim().length >= 10 &&
      privacy;

  @override
  Widget build(BuildContext context) {
    if (sent) return _thanks();
    return Scaffold(
      appBar: AppBar(title: const Text('CONTACT')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionHeader(
            kicker: 'Enquire',
            title: 'Three quick steps',
            subtitle: 'Needs, details, message. All fields mandatory except message — same rule as the website quiz.',
          ),
          const SizedBox(height: 12),
          _stepper(),
          const SizedBox(height: 16),
          if (step == 0) _needsStep(),
          if (step == 1) _detailsStep(),
          if (step == 2) _messageStep(),
          const SizedBox(height: 16),
          Row(children: [
            if (step > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => step--),
                  child: const Text('Back'),
                ),
              ),
            if (step > 0) const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _next,
                child: Text(step == 2 ? 'Send Enquiry' : 'Continue'),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          const SectionHeader(kicker: 'FAQ', title: 'Good to know'),
          const SizedBox(height: 8),
          _faq('Where are you based?', 'Lucknow, India. On-ground support across venues in the city.'),
          _faq('How fast can staff join?', 'Verified pros typically join within 24–48 hours of confirmation.'),
          _faq('What does combo include?', 'Any 4 heads for Rs 50,000 per month — operations, F&B, artists, catering, vendors, training.'),
          const SizedBox(height: 16),
          const ContactStrip(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _stepper() {
    const labels = ['Needs', 'Details', 'Message'];
    return Row(
      children: List.generate(3, (i) {
        final active = i == step;
        final done = i < step;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i == 2 ? 0 : 8),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: active ? AppTheme.espresso : (done ? AppTheme.gold.withOpacity(0.2) : Colors.white),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.champagne),
            ),
            child: Center(
              child: Text('${i + 1}. ${labels[i]}',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w700,
                      color: active ? Colors.white : AppTheme.ink)),
            ),
          ),
        );
      }),
    );
  }

  Widget _needsStep() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('WHAT DO YOU NEED?',
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: needOptions.map((n) {
          final sel = needs.contains(n);
          return FilterChip(
            label: Text(n),
            selected: sel,
            onSelected: (_) => setState(() {
              sel ? needs.remove(n) : needs.add(n);
            }),
          );
        }).toList(),
      ),
      if (!_step0Ok)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('Pick at least one need to continue.',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.red.shade700)),
        ),
    ]);
  }

  Widget _detailsStep() {
    return Column(children: [
      Row(children: [
        Expanded(child: _field(first, 'First name')),
        const SizedBox(width: 10),
        Expanded(child: _field(last, 'Last name')),
      ]),
      const SizedBox(height: 10),
      _field(business, 'Business / Venue'),
      const SizedBox(height: 10),
      _field(email, 'Email', keyboard: TextInputType.emailAddress),
      const SizedBox(height: 10),
      _field(phone, 'Phone', keyboard: TextInputType.phone),
      const SizedBox(height: 10),
      CheckboxListTile(
        value: privacy,
        onChanged: (v) => setState(() => privacy = v ?? false),
        title: Text('I agree to the privacy policy',
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    ]);
  }

  Widget _messageStep() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('ANYTHING ELSE? (OPTIONAL)',
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
      const SizedBox(height: 8),
      TextField(
        controller: message,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Date, venue, headcount...',
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.champagne)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.champagne)),
        ),
      ),
      const SizedBox(height: 10),
      Text('Summary: ${needs.join(', ')} — ${first.text} ${last.text}, ${business.text}',
          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey.shade700, height: 1.5)),
    ]);
  }

  Widget _field(TextEditingController c, String label, {TextInputType? keyboard}) {
    return TextField(
      controller: c,
      keyboardType: keyboard,
      onChanged: (_) => setState(() {}),
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

  Widget _faq(String q, String a) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.champagne),
      ),
      child: ExpansionTile(
        title: Text(q, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Text(a, style: GoogleFonts.inter(fontSize: 14, height: 1.55)),
          ),
        ],
      ),
    );
  }

  void _next() {
    if (step == 0 && !_step0Ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one need to continue')),
      );
      return;
    }
    if (step == 1 && !_step1Ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('First, last, business, valid email, 10-digit phone and privacy consent are required')),
      );
      return;
    }
    if (step < 2) {
      setState(() => step++);
      return;
    }
    final payload = quizPayload(
      needs: needs.toList(),
      first: first.text.trim(), last: last.text.trim(),
      business: business.text.trim(), email: email.text.trim(),
      phone: phoneCtrlText(), message: message.text.trim(),
    );
    debugPrint('QUIZ PAYLOAD: $payload → $formSubmitUrl');
    setState(() => sent = true);
  }

  String phoneCtrlText() => phone.text.trim();

  Widget _thanks() {
    return Scaffold(
      appBar: AppBar(title: const Text('THANK YOU')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('THANK YOU.',
              style: GoogleFonts.bodoniModa(
                  fontSize: 36, fontWeight: FontWeight.w600, color: AppTheme.ink, height: 0.95)),
          const SizedBox(height: 10),
          Text('Your enquiry is noted. Luxero replies within one working day on email and WhatsApp.',
              style: GoogleFonts.inter(fontSize: 15, height: 1.6)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => setState(() {
              sent = false; step = 0;
            }),
            child: const Text('Send Another Enquiry'),
          ),
          const SizedBox(height: 16),
          const ContactStrip(),
        ]),
      ),
    );
  }
}
