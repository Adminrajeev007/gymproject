import 'package:flutter/material.dart';

class City {
  final String name;
  final double lat;
  final double lng;
  final String state;

  City({required this.name, required this.lat, required this.lng, required this.state});
}

class CitySelector extends StatefulWidget {
  final City? selectedCity;
  final Function(City) onCitySelected;

  const CitySelector({
    Key? key,
    this.selectedCity,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  String searchQuery = '';

  final List<City> indianCities = [
    // Major Metro Cities
    City(name: "Mumbai", lat: 19.0760, lng: 72.8777, state: "Maharashtra"),
    City(name: "Delhi", lat: 28.7041, lng: 77.1025, state: "Delhi"),
    City(name: "Bangalore", lat: 12.9716, lng: 77.5946, state: "Karnataka"),
    City(name: "Kolkata", lat: 22.5726, lng: 88.3639, state: "West Bengal"),
    City(name: "Chennai", lat: 13.0827, lng: 80.2707, state: "Tamil Nadu"),
    City(name: "Hyderabad", lat: 17.3850, lng: 78.4867, state: "Telangana"),
    City(name: "Pune", lat: 18.5204, lng: 73.8567, state: "Maharashtra"),
    City(name: "Ahmedabad", lat: 23.0225, lng: 72.5714, state: "Gujarat"),

    // Other Major Cities
    City(name: "Surat", lat: 21.1702, lng: 72.8311, state: "Gujarat"),
    City(name: "Jaipur", lat: 26.9124, lng: 75.7873, state: "Rajasthan"),
    City(name: "Lucknow", lat: 26.8467, lng: 80.9462, state: "Uttar Pradesh"),
    City(name: "Kanpur", lat: 26.4499, lng: 80.3319, state: "Uttar Pradesh"),
    City(name: "Nagpur", lat: 21.1458, lng: 79.0882, state: "Maharashtra"),
    City(name: "Indore", lat: 22.7196, lng: 75.8577, state: "Madhya Pradesh"),
    City(name: "Thane", lat: 19.2183, lng: 72.9781, state: "Maharashtra"),
    City(name: "Bhopal", lat: 23.2599, lng: 77.4126, state: "Madhya Pradesh"),
    City(name: "Visakhapatnam", lat: 17.6868, lng: 83.2185, state: "Andhra Pradesh"),
    City(name: "Vadodara", lat: 22.3072, lng: 73.1812, state: "Gujarat"),
    City(name: "Ghaziabad", lat: 28.6692, lng: 77.4538, state: "Uttar Pradesh"),
    City(name: "Ludhiana", lat: 30.9010, lng: 75.8573, state: "Punjab"),

    // Tier 2 Cities
    City(name: "Agra", lat: 27.1767, lng: 78.0081, state: "Uttar Pradesh"),
    City(name: "Nashik", lat: 19.9975, lng: 73.7898, state: "Maharashtra"),
    City(name: "Faridabad", lat: 28.4089, lng: 77.3178, state: "Haryana"),
    City(name: "Meerut", lat: 28.9845, lng: 77.7064, state: "Uttar Pradesh"),
    City(name: "Rajkot", lat: 22.3039, lng: 70.8022, state: "Gujarat"),
    City(name: "Kalyan", lat: 19.2437, lng: 73.1355, state: "Maharashtra"),
    City(name: "Vasai", lat: 19.4885, lng: 72.8061, state: "Maharashtra"),
    City(name: "Varanasi", lat: 25.3176, lng: 82.9739, state: "Uttar Pradesh"),
    City(name: "Srinagar", lat: 34.0837, lng: 74.7973, state: "Jammu and Kashmir"),
    City(name: "Dhanbad", lat: 23.7957, lng: 86.4304, state: "Jharkhand"),
    City(name: "Jodhpur", lat: 26.2389, lng: 73.0243, state: "Rajasthan"),
    City(name: "Amritsar", lat: 31.6340, lng: 74.8723, state: "Punjab"),
    City(name: "Raipur", lat: 21.2514, lng: 81.6296, state: "Chhattisgarh"),
    City(name: "Allahabad", lat: 25.4358, lng: 81.8463, state: "Uttar Pradesh"),
    City(name: "Coimbatore", lat: 11.0168, lng: 76.9558, state: "Tamil Nadu"),
    City(name: "Jabalpur", lat: 23.1815, lng: 79.9864, state: "Madhya Pradesh"),
    City(name: "Gwalior", lat: 26.2183, lng: 78.1828, state: "Madhya Pradesh"),
    City(name: "Vijayawada", lat: 16.5062, lng: 80.6480, state: "Andhra Pradesh"),
    City(name: "Madurai", lat: 9.9252, lng: 78.1198, state: "Tamil Nadu"),
    City(name: "Guwahati", lat: 26.1445, lng: 91.7362, state: "Assam"),
    City(name: "Chandigarh", lat: 30.7333, lng: 76.7794, state: "Chandigarh"),
    City(name: "Hubli", lat: 15.3647, lng: 75.1240, state: "Karnataka"),
    City(name: "Mysore", lat: 12.2958, lng: 76.6394, state: "Karnataka"),
  ];

  List<City> get filteredCities {
    if (searchQuery.isEmpty) return indianCities;
    return indianCities.where((city) =>
    city.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        city.state.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Current Selection Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => _showCitySelector(context),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedCity?.name ?? 'Select your city',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: widget.selectedCity != null ? FontWeight.w600 : FontWeight.normal,
                            color: widget.selectedCity != null ? Colors.black : Colors.grey,
                          ),
                        ),
                        if (widget.selectedCity != null)
                          Text(
                            widget.selectedCity!.state,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCitySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Your City',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose your city to find nearby gyms',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search cities...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),

              // Cities List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    return ListTile(
                      leading: const Icon(Icons.location_city, color: Colors.blue),
                      title: Text(
                        city.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(city.state),
                      onTap: () {
                        widget.onCitySelected(city);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}