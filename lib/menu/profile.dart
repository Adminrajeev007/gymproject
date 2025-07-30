import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymproject/HomeScreen/homeScreen.dart';

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
        // toolbarHeight: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
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
                        Text("Raj",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("ID: 192686072559",
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey.shade800)),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Height, Weight, BMI Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                InfoTile(title: "5'10\"", subtitle: "Height"),
                InfoTile(title: "75.6", subtitle: "Weight (kg)"),
                InfoTile(title: "23.9", subtitle: "BMI"),
              ],
            ),

            const SizedBox(height: 20),

            // Voucher and Invite Cards
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: _customCard("₹0", "VOUCHER BALANCE", Icons.wallet_giftcard),
            //       ),
            //       const SizedBox(width: 12),
            //       Expanded(
            //         child: _customCard("Invite Now", "Invite Friends", Icons.group_add),
            //       ),
            //     ],
            //   ),
            // ),

            const Divider(thickness: 8, height: 32, color: Color(0xFFF2F2F2)),

            // Main menu items
            cardSection([
              profileItem("My Bookings", Icons.calendar_today),
              profileItem(
                  "Health Risk Assessment (HRA)", Icons.favorite_outline),
              profileItem("Third-party app connections", Icons.link),
              profileItem("My Orders", Icons.receipt_long),
              profileItem("My Addresses", Icons.location_on),
              profileItem("Health Tracker", Icons.monitor_heart),
              profileItem("Payment Methods", Icons.payment),
            ]),

            const Divider(thickness: 8, height: 32, color: Color(0xFFF2F2F2)),

            // OTHERS header
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("OTHERS",
                    style:
                        GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
              ),
            ),

            cardSection([
              profileItem("App Settings & Notifications", Icons.settings),
              profileItem("Help & Support", Icons.help_outline),
              profileItem("About", Icons.info_outline),
              profileItem("Terms & Conditions", Icons.description_outlined),
              profileItem(
                  "Subscription Terms & Conditions", Icons.receipt_outlined),
              profileItem("Privacy Policy", Icons.privacy_tip_outlined),
            ]),

            const Divider(thickness: 8, height: 32, color: Color(0xFFF2F2F2)),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text("Logout",
                  style: GoogleFonts.poppins(color: Colors.red, fontSize: 16)),
              onTap: () {},
            ),

            const SizedBox(height: 10),

            // Version
            Center(
              child: Text(
                "FITPASS\nApp version 7.4.7 (618)",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _customCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget profileItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 15)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }

  static Widget cardSection(List<Widget> items) {
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
        Text(title,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(subtitle,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
