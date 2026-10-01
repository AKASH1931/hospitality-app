/// Luxero shared content — mirrors web lib/content.ts + lib/events.ts (APP-HANDOFF.md).
/// Keep email payloads byte-identical so inbox parsing never breaks.

class Head {
  final String id;
  final int index;
  final String title;
  final String text;
  const Head({required this.id, required this.index, required this.title, required this.text});
}

const List<Head> heads = [
  Head(id: 'operations', index: 1, title: 'Operations', text: 'Day-to-day hotel and venue operations run with gold-standard SOPs.'),
  Head(id: 'fb', index: 2, title: 'F&B Management', text: 'Menus, kitchen systems and banquet service that lift revenue.'),
  Head(id: 'artist', index: 3, title: 'Artists', text: 'Curated performers for weddings, corporate nights and festivals.'),
  Head(id: 'catering', index: 4, title: 'Catering', text: 'Banquet and outdoor catering with tasting-led menu design.'),
  Head(id: 'vendor', index: 5, title: 'Vendors', text: 'Verified decor, light, sound and logistics partners in one place.'),
  Head(id: 'training', index: 6, title: 'Training', text: 'Grooming, service and etiquette training for your whole team.'),
];

class Pricing {
  static const perHead = 20000;
  static const combo = 50000;
  static const comboHeads = 4;
}

class Quote {
  final int total;
  final String plan;
  final int savings;
  const Quote({required this.total, required this.plan, required this.savings});
}

/// Mirrors web quoteFor(): combo auto-applies at 4+ heads.
Quote quoteFor(List<String> selected) {
  if (selected.length >= Pricing.comboHeads) {
    final mrp = selected.length * Pricing.perHead;
    return Quote(total: Pricing.combo, plan: 'Combo — any 4 heads', savings: mrp - Pricing.combo);
  }
  return Quote(total: selected.length * Pricing.perHead, plan: 'Individual', savings: 0);
}

class LuxeroEvent {
  final String id;
  final String title;
  final String date;
  final String venue;
  final String city;
  final String blurb;
  const LuxeroEvent({required this.id, required this.title, required this.date, required this.venue, required this.city, required this.blurb});
}

const List<LuxeroEvent> upcomingEvents = [
  LuxeroEvent(id: 'crystal-eve-2026', title: 'Crystal Eve 2026', date: '31 Dec 2026', venue: 'Taj', city: 'Lucknow', blurb: 'New Year Eve gala — dinner, artists and countdown celebration.'),
  LuxeroEvent(id: 'block-party', title: 'Block Party', date: 'TBA', venue: 'MOB', city: 'Lucknow', blurb: 'High-energy night with DJs, F&B counters and brand stalls.'),
];

const List<LuxeroEvent> pastEvents = [
  LuxeroEvent(id: 'bananas', title: 'Bananas', date: 'Past', venue: 'Lucknow', city: 'Lucknow', blurb: 'Themed party night.'),
  LuxeroEvent(id: 'cio', title: 'CIO Horizon', date: 'Past', venue: 'Lucknow', city: 'Lucknow', blurb: 'Corporate gathering.'),
  LuxeroEvent(id: 'sufi', title: 'Sufi Night', date: 'Past', venue: 'Lucknow', city: 'Lucknow', blurb: 'Soulful evening.'),
  LuxeroEvent(id: 'skyline', title: 'Skyline Romance', date: 'Past', venue: 'Lucknow', city: 'Lucknow', blurb: 'Rooftop celebration.'),
  LuxeroEvent(id: 'santa', title: "Santa's Wonderland", date: 'Past', venue: 'Lucknow', city: 'Lucknow', blurb: 'Christmas special.'),
];

const List<String> approachSteps = ['Discover', 'Diagnose', 'Design', 'Deliver', 'Drive'];

const List<String> whoWeServe = ['Hotels', 'Banquets', 'Restaurants', 'Corporate', 'Weddings', 'Events'];

const List<String> differencePoints = [
  'Gold-standard SOPs from Taj-trained leadership',
  'Single partner for staff, vendors and artists',
  'Transparent combo pricing — save Rs 30,000 on 4 heads',
  'Lucknow-based team with on-ground support',
  'Training included so quality sustains after handover',
];

// Integrations (reuse as-is from handoff)
const String whatsappNumber = '919305608569';
const String whatsappDefaultText = 'Hello Luxero, I would like to discuss about my plan.';
const String instagramUrl = 'https://www.instagram.com/luxerohospitality/';
const String contactPhone = '+919305608569';
const String contactEmail = 'info@luxerohospitalitysolutions.com';
const String formSubmitUrl = 'https://formsubmit.co/ajax/info@luxerohospitalitysolutions.com';

String whatsappLink([String? text]) {
  final t = Uri.encodeComponent(text ?? whatsappDefaultText);
  return 'https://wa.me/$whatsappNumber?text=$t';
}

/// Quiz payload — ALL mandatory except message (web parity).
Map<String, dynamic> quizPayload({
  required List<String> needs,
  required String first,
  required String last,
  required String business,
  required String email,
  required String phone,
  required String message,
}) {
  return {
    'name': '$first $last'.trim(),
    'business': business,
    'phone': phone,
    'email': email,
    'interest': needs.join(', '),
    'message': message,
    '_subject': 'New Luxero enquiry from $first $last',
    '_template': 'table',
  };
}

Map<String, dynamic> reservePayload({required String name, required String phone, required LuxeroEvent event}) {
  return {
    'name': name,
    'phone': phone,
    'event': '${event.title} — ${event.date} · ${event.venue}, ${event.city}',
    '_subject': 'Event reservation: ${event.title}',
    '_template': 'table',
  };
}
