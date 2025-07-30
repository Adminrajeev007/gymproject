import 'package:flutter/material.dart';
import 'package:gymproject/HomeScreen/homeScreen.dart';
import 'package:gymproject/Screens/home.dart';


class notificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // Light background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () {


              // Handle edit button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Info Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300], // Placeholder background
                      image: const DecorationImage(
                        image: NetworkImage('YOUR_PROFILE_IMAGE_URL'), // Replace with actual image source
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_userName',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const Text(
                    'ID 102886072559',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF888888),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(value: "5'10\"", label: "Height (FT)"),
                        _StatDivider(),
                        _StatItem(value: "75.6", label: "Weight (KG)"),
                        _StatDivider(),
                        _StatItem(value: "23.9", label: "BMI"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Voucher and Invite Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: _VoucherCard(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _InviteFriendsCard(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Menu Items Section
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.event_note_outlined, // Closer to calendar-check
                    title: "My Bookings",
                    description: "View your latest workout reservations & upcoming workouts",
                    onTap: (){

                      },


                  ),

                  _MenuItem(

                    icon: Icons.card_giftcard,
                    title: "Gift FITPASS",
                    description: "Give the gift of fitness and help them start their fitness journey",
                  ),
                  _MenuItem(
                    icon: Icons.sick_outlined, // Placeholder, might need custom icon
                    title: "Health Risk Assessment (HRA)",
                    description: "Your health, lifestyle, and diet preferences",
                  ),
                  _MenuItem(
                    icon: Icons.wallet_outlined,
                    title: "FITCASH and Rewards",
                    description: "Balance: 0",
                  ),
                  _MenuItem(
                    icon: Icons.link,
                    title: "Third-party app connections",
                    description: "Sync your data with health apps to track your workouts and overall health",
                  ),
                  _MenuItem(
                    icon: Icons.history, // Closer to order-bool-descending-variant
                    title: "My Orders",
                    description: "Check your transactions on the FITPASS and web",
                  ),
                  _MenuItem(
                    icon: Icons.location_on_outlined,
                    title: "My Addresses",
                    description: "Your delivery addresses for store orders",
                  ),
                  _MenuItem(
                    icon: Icons.monitor_heart_outlined, // Placeholder for health tracker
                    title: "Health Tracker",
                    description: "Track your calorie, rate, steps, weight intake, and weight with ease. Stay consistent and take charge of your health journey!",
                  ),
                  _MenuItem(
                    icon: Icons.credit_card_outlined,
                    title: "Payment Methods",
                    description: "Manage your saved Cards, UPI and other payment options",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Other Settings Section
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 5),
                child: Text(
                  'OTHERS',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _MenuItem(icon: Icons.notifications_none, title: "App Settings & Notifications"),
                  _MenuItem(icon: Icons.help_outline, title: "Help & Support"),
                  _MenuItem(icon: Icons.info_outline, title: "About"),
                  _MenuItem(icon: Icons.description_outlined, title: "Terms & Conditions"),
                  _MenuItem(icon: Icons.description_outlined, title: "Subscription Terms & Conditions"),
                  _MenuItem(icon: Icons.privacy_tip_outlined, title: "Privacy Policy"),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Logout Button
            Container(
              color: Colors.white,
              child: _MenuItem(
                icon: Icons.logout,
                title: "Logout",
                iconColor: Colors.red,
                titleColor: Colors.red,
                showArrow: false, // Hide arrow for logout
              ),
            ),
            const SizedBox(height: 20),

            // Footer
            const Text(
              '"FITPASS"',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Text(
              'App version 7.4.7 (618)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget for Stat Items
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}

// Reusable Widget for Stat Divider
class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40, // Adjust height as needed
      color: Colors.grey[300],
    );
  }
}

// Reusable Widget for Voucher Card
class _VoucherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.confirmation_num_outlined, color: Colors.amber, size: 24),
            const SizedBox(height: 8),
            const Text(
              'VOUCHER BALANCE',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF666666),
              ),
            ),
            const Text(
              '₹0',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Handle Add Balance
              },
              child: const Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.blue, size: 16),
                  SizedBox(width: 5),
                  Text(
                    'Add Balance',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget for Invite Friends Card
class _InviteFriendsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.people_alt_outlined, color: Colors.blue, size: 24),
            const SizedBox(height: 8),
            const Text(
              'Invite Friends',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF666666),
              ),
            ),
            const Text(
              'Get friends to join FITPASS & get benefits',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Handle Invite now
              },
              child: const Row(
                children: [
                  Icon(Icons.add_circle, color: Colors.blue, size: 16),
                  SizedBox(width: 5),
                  Text(
                    'Invite now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Widget for Menu Items
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final Color iconColor;
  final Color titleColor;
  final bool showArrow;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.description,
    this.iconColor = Colors.black,
    this.titleColor = const Color(0xFF333333),
    this.showArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle menu item tap
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: titleColor,
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF888888),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (showArrow)
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}