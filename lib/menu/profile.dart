import 'package:flutter/material.dart';


class FitPassProfileApp extends StatelessWidget {
  const FitPassProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        toolbarHeight: 0, // Hides default app bar height
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.brown,
                  child: Icon(Icons.person, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Raj", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("ID: 192686072559", style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                )
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              InfoTile(title: "5'10\"", subtitle: "Height"),
              InfoTile(title: "75.6", subtitle: "Weight (kg)"),
              InfoTile(title: "23.9", subtitle: "BMI"),
            ],
          ),

          const Divider(thickness: 8, height: 32, color: Color(0xFFF2F2F2)),

          Expanded(
            child: ListView(
              children: [
                cardSection([
                  profileItem("My Bookings", Icons.calendar_today),
                  // profileItem("Gift FITPASS", Icons.card_giftcard),
                  profileItem("Health Risk Assessment (HRA)", Icons.favorite_outline),
                  // profileItem("FITCASH and Rewards", Icons.monetization_on_outlined),
                  profileItem("Third-party app connections", Icons.link),
                  profileItem("My Orders", Icons.receipt_long),
                  profileItem("My Addresses", Icons.location_on),
                  profileItem("Health Tracker", Icons.monitor_heart),
                  profileItem("Payment Methods", Icons.payment),
                ]),
                const Divider(thickness: 8, color: Color(0xFFF2F2F2)),
                cardSection([
                  profileItem("App Settings & Notifications", Icons.settings),
                  profileItem("Help & Support", Icons.help_outline),
                  profileItem("About", Icons.info_outline),
                  profileItem("Terms & Conditions", Icons.description_outlined),
                  profileItem("Subscription Terms & Conditions", Icons.receipt_outlined),
                  profileItem("Privacy Policy", Icons.privacy_tip_outlined),
                ]),
                const Divider(thickness: 8, color: Color(0xFFF2F2F2)),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout", style: TextStyle(color: Colors.red)),
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text("FITPASS\nApp version 7.4.7 (618)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget cardSection(List<Widget> items) {
    return Column(children: items);
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
