import 'package:flutter/material.dart';

void main() {
  runApp(const Raithu360App());
}

class Raithu360App extends StatelessWidget {
  const Raithu360App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RAITHU 360',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F8F4),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> services = [
    {'name': 'Weather', 'icon': Icons.cloud, 'desc': 'Weather updates and rain alerts'},
    {'name': 'Farming Tips', 'icon': Icons.agriculture, 'desc': 'Useful farming information'},
    {'name': 'Market Prices', 'icon': Icons.currency_rupee, 'desc': 'Mandi and crop price information'},
    {'name': 'Seeds & Fertilizers', 'icon': Icons.grass, 'desc': 'Seeds and fertilizer information'},
    {'name': 'Education', 'icon': Icons.school, 'desc': 'Study materials and scholarships'},
    {'name': 'Jobs', 'icon': Icons.work, 'desc': 'Government and private job information'},
    {'name': 'Buy & Sell', 'icon': Icons.store, 'desc': 'Agriculture products marketplace'},
    {'name': 'Government Schemes', 'icon': Icons.account_balance, 'desc': 'Farmer welfare schemes'},
    {'name': 'Chat', 'icon': Icons.chat, 'desc': 'Connect with other users'},
    {'name': 'News', 'icon': Icons.newspaper, 'desc': 'Latest news and updates'},
  ];

  void openService(Map<String, dynamic> service) {
  if (service['name'] == 'Weather') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WeatherPage(),
      ),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ServicePage(
        title: service['name'],
        description: service['desc'],
        icon: service['icon'],
      ),
    ),
  );
  }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServicePage(
          title: service['name'],
          description: service['desc'],
          icon: service['icon'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        title: const Text(
          'RAITHU 360',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: selectedIndex == 0
          ? homeContent()
          : ServicePage(
              title: ['Home', 'Farming', 'Market', 'Chat', 'Profile'][selectedIndex],
              description: 'This section is coming soon.',
              icon: Icons.construction,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green.shade800,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'Farming'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget homeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Farmers First. Everyone Connected.',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Welcome to RAITHU 360'),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final service = services[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => openService(service),
                  child: Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          service['icon'],
                          size: 38,
                          color: Colors.green.shade700,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            service['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Weather'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Weather feature coming next!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
class ServicePage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ServicePage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 75, color: Colors.green.shade700),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'More features coming soon!',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
