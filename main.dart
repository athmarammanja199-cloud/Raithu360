import 'package:flutter/material.dart';

void main() => runApp(const Raithu360App());

const brandGreen = Color(0xFF21864A);
const paleGreen = Color(0xFFEAF6ED);

class Raithu360App extends StatelessWidget {
  const Raithu360App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'RAITHU 360',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: brandGreen),
      scaffoldBackgroundColor: const Color(0xFFF6FAF6),
    ),
    home: const LoginScreen(),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phone = TextEditingController();
  String language = 'English';

  @override
  void dispose() { phone.dispose(); super.dispose(); }

  void continueLogin() {
    if (phone.text.trim().length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
      );
      return;
    }
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => OtpScreen(mobile: phone.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 26),
          Center(child: Container(
            width: 86, height: 86,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: const [BoxShadow(color: Color(0x18000000), blurRadius: 14)]),
            child: const Icon(Icons.agriculture, color: brandGreen, size: 53),
          )),
          const SizedBox(height: 13),
          const Text('RAITHU 360', textAlign: TextAlign.center, style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900, color: brandGreen, letterSpacing: 1)),
          const Text('Farmers First. Everyone Connected.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 30),
          Container(
            height: 155,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(colors: [Color(0xFF21864A), Color(0xFF75B77B)], begin: Alignment.bottomLeft, end: Alignment.topRight),
            ),
            child: const Stack(children: [
              Positioned(left: 18, top: 22, child: Icon(Icons.agriculture, color: Colors.white24, size: 105)),
              Positioned(right: 18, bottom: 18, child: Icon(Icons.eco, color: Colors.white24, size: 90)),
              Padding(padding: EdgeInsets.all(20), child: Align(alignment: Alignment.centerLeft, child: SizedBox(width: 220, child: Text('One app for farming, learning, jobs and daily services.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19))))),
            ]),
          ),
          const SizedBox(height: 28),
          const Text('Welcome back!', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Login with your mobile number', style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 18),
          DropdownButtonFormField<String>(
            value: language,
            decoration: const InputDecoration(labelText: 'App language', prefixIcon: Icon(Icons.language), border: OutlineInputBorder()),
            items: const ['English','తెలుగు','हिन्दी','தமிழ்','ಕನ್ನಡ','മലയാളം','मराठी','বাংলা','ગુજરાતી','ਪੰਜਾਬੀ']
              .map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => language = v ?? 'English'),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: const InputDecoration(labelText: 'Mobile number', prefixText: '+91  ', prefixIcon: Icon(Icons.phone_android), border: OutlineInputBorder(), counterText: ''),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: continueLogin,
            style: FilledButton.styleFrom(backgroundColor: brandGreen, padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text('Continue with OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 14),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("New to RAITHU 360? "),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())), child: const Text('Create account')),
          ]),
          const SizedBox(height: 10),
          const Text('Free to use • Your details stay private', textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontSize: 12)),
        ]),
      ),
    ),
  );
}

class OtpScreen extends StatefulWidget {
  final String mobile;
  const OtpScreen({super.key, required this.mobile});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otp = TextEditingController();
  @override
  void dispose() { otp.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Verify mobile number')),
    body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Icon(Icons.mark_email_read_outlined, size: 64, color: brandGreen),
      const SizedBox(height: 18),
      const Text('Enter OTP', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text('Enter the 6-digit code sent to +91 ${widget.mobile}', textAlign: TextAlign.center),
      const SizedBox(height: 24),
      TextField(controller: otp, keyboardType: TextInputType.number, maxLength: 6, textAlign: TextAlign.center, decoration: const InputDecoration(labelText: '6-digit OTP', border: OutlineInputBorder(), counterText: '')),
      const SizedBox(height: 14),
      FilledButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP verification needs a connected SMS service. This is a UI demo.'))),
        style: FilledButton.styleFrom(backgroundColor: brandGreen, padding: const EdgeInsets.all(16)),
        child: const Text('Verify OTP'),
      ),
    ])),
  );
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final mobile = TextEditingController();
  final state = TextEditingController();
  final district = TextEditingController();
  final town = TextEditingController();
  String category = 'Farmer';
  String language = 'English';

  @override
  void dispose() {
    name.dispose(); mobile.dispose(); state.dispose(); district.dispose(); town.dispose(); super.dispose();
  }

  Widget field(String label, TextEditingController c, IconData icon, {TextInputType type = TextInputType.text}) =>
    Padding(padding: const EdgeInsets.only(bottom: 13), child: TextField(
      controller: c, keyboardType: type,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon), border: const OutlineInputBorder()),
    ));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Create your account')),
    body: SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Join RAITHU 360', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: brandGreen)),
      const SizedBox(height: 5),
      const Text('A free platform for farmers and everyone.'),
      const SizedBox(height: 20),
      field('Full name', name, Icons.person_outline),
      field('Mobile number', mobile, Icons.phone_android, type: TextInputType.phone),
      field('State', state, Icons.map_outlined),
      field('District', district, Icons.location_city),
      field('Village / City (optional)', town, Icons.place_outlined),
      DropdownButtonFormField<String>(
        value: category,
        decoration: const InputDecoration(labelText: 'I am a', prefixIcon: Icon(Icons.group_outlined), border: OutlineInputBorder()),
        items: const ['Farmer','Student','Employee','Business','General Public'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => category = v ?? 'Farmer'),
      ),
      const SizedBox(height: 13),
      DropdownButtonFormField<String>(
        value: language,
        decoration: const InputDecoration(labelText: 'Preferred language', prefixIcon: Icon(Icons.language), border: OutlineInputBorder()),
        items: const ['English','తెలుగు','हिन्दी','தமிழ்','ಕನ್ನಡ','മലയാളം','मराठी','বাংলা','ગુજરાતી','ਪੰਜਾਬੀ'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => language = v ?? 'English'),
      ),
      const SizedBox(height: 20),
      FilledButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration UI is ready. OTP, database and secure account creation must be connected next.'))),
        style: FilledButton.styleFrom(backgroundColor: brandGreen, padding: const EdgeInsets.all(16)),
        child: const Text('Register with OTP', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 12),
      const Text('We do not ask for Aadhaar or bank details during registration.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
    ])),
  );
}
