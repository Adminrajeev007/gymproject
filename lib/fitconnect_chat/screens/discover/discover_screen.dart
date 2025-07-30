// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../models/gym.dart';
// import '../../services/api_service.dart';
// import '../../widgets/city_selector.dart';
// import 'gym_members_screen.dart';
//
// class DiscoverScreen extends StatefulWidget {
//   const DiscoverScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DiscoverScreen> createState() => _DiscoverScreenState();
// }
//
// class _DiscoverScreenState extends State<DiscoverScreen> {
//   List<Gym> gyms = [];
//   bool isLoading = false;
//   String searchQuery = '';
//   City? selectedCity;
//   Position? currentPosition;
//   String selectedFilter = 'nearby';
//
//   final List<Map<String, dynamic>> filterButtons = [
//     {'id': 'nearby', 'label': 'Nearby', 'icon': Icons.location_on},
//     {'id': 'premium', 'label': 'Premium', 'icon': Icons.star},
//     {'id': '24h', 'label': '24/7 Open', 'icon': Icons.access_time},
//     {'id': 'rating', 'label': 'Top Rated', 'icon': Icons.thumb_up},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//
//       if (permission == LocationPermission.whileInUse ||
//           permission == LocationPermission.always) {
//         final position = await Geolocator.getCurrentPosition();
//         setState(() {
//           currentPosition = position;
//         });
//         _fetchGyms();
//       } else {
//         _fetchGyms(); // Fetch without location
//       }
//     } catch (e) {
//       _fetchGyms(); // Fetch without location
//     }
//   }
//
//   Future<void> _fetchGyms() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       double? lat = selectedCity?.lat ?? currentPosition?.latitude;
//       double? lng = selectedCity?.lng ?? currentPosition?.longitude;
//
//       final gymData = await ApiService.getGyms(
//         query: searchQuery.isNotEmpty ? searchQuery : null,
//         lat: lat,
//         lng: lng,
//       );
//
//       setState(() {
//         gyms = gymData.map((json) => Gym.fromJson(json)).toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch gyms: $e')),
//       );
//     }
//   }
//
//   List<Gym> get filteredGyms {
//     switch (selectedFilter) {
//       case 'rating':
//         return gyms.where((gym) =>
//         gym.rating != null && double.parse(gym.rating!) >= 4.5
//         ).toList();
//       case '24h':
//         return gyms.where((gym) =>
//         gym.hours?.contains('24') == true || gym.hours?.contains('11 PM') == true
//         ).toList();
//       case 'premium':
//         return gyms.where((gym) =>
//             gym.amenities.any((amenity) =>
//             amenity.toLowerCase().contains('premium') ||
//                 amenity.toLowerCase().contains('pool') ||
//                 amenity.toLowerCase().contains('spa')
//             )
//         ).toList();
//       default:
//         return gyms;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Discover Gyms',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Search and Location Section
//           Container(
//             color: Colors.white,
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 // Location Status
//                 if (selectedCity != null)
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     margin: const EdgeInsets.only(bottom: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.green[50],
//                       border: Border.all(color: Colors.green[200]!),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.green[600], size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Location: ${selectedCity!.name}',
//                                 style: TextStyle(
//                                   color: Colors.green[800],
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Text(
//                                 'Showing gyms in ${selectedCity!.name}, ${selectedCity!.state}',
//                                 style: TextStyle(
//                                   color: Colors.green[600],
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedCity=null;
//                             });
//                             _fetchGyms();
//                           },
//                           child: Text(
//                             'Use Current Location',
//                             style: TextStyle(color: Colors.green[600]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 // City Selector
//                 CitySelector(
//                   selectedCity: selectedCity,
//                   onCitySelected: (city) {
//                     setState(() {
//                       selectedCity = city;
//                     });
//                     _fetchGyms();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Location set to ${city.name}'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                   },
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Search Bar
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: selectedCity != null
//                         ? 'Search gyms in ${selectedCity!.name}...'
//                         : 'Search gyms...',
//                     prefixIcon: const Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey[100],
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value;
//                     });
//                     _fetchGyms();
//                   },
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Filter Buttons
//                 SizedBox(
//                   height: 40,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: filterButtons.length,
//                     itemBuilder: (context, index) {
//                       final filter = filterButtons[index];
//                       final isSelected = selectedFilter == filter['id'];
//
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 8),
//                         child: FilterChip(
//                           label: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 filter['icon'],
//                                 size: 16,
//                                 color: isSelected ? Colors.white : Colors.grey[600],
//                               ),
//                               const SizedBox(width: 4),
//                               Text(filter['label']),
//                             ],
//                           ),
//                           selected: isSelected,
//                           onSelected: (selected) {
//                             setState(() {
//                               selectedFilter = filter['id'];
//                             });
//                           },
//                           backgroundColor: Colors.grey[200],
//                           selectedColor: Colors.blue,
//                           labelStyle: TextStyle(
//                             color: isSelected ? Colors.white : Colors.grey[700],
//                             fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Gym List
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : filteredGyms.isEmpty
//                 ? const Center(
//               child: Text(
//                 'No gyms found matching your criteria.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             )
//                 : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: filteredGyms.length,
//               itemBuilder: (context, index) {
//                 final gym = filteredGyms[index];
//                 return _buildGymCard(gym);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGymCard(Gym gym) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Gym Image
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: CachedNetworkImage(
//               imageUrl: gym.image ?? '',
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//               placeholder: (context, url) => Container(
//                 height: 200,
//                 color: Colors.grey[300],
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//               errorWidget: (context, url, error) => Container(
//                 height: 200,
//                 color: Colors.grey[300],
//                 child: const Icon(Icons.fitness_center, size: 50, color: Colors.grey),
//               ),
//             ),
//           ),
//
//           // Gym Details
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name and Rating
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         gym.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     if (gym.rating != null)
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.orange[100],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.star, size: 16, color: Colors.orange),
//                             const SizedBox(width: 4),
//                             Text(
//                               gym.rating!,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // Address
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         gym.address,
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // Member Count and Hours
//                 Row(
//                   children: [
//                     Icon(Icons.people, size: 16, color: Colors.blue[600]),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${gym.memberCount} members',
//                       style: TextStyle(color: Colors.blue[600]),
//                     ),
//                     const SizedBox(width: 16),
//                     if (gym.hours != null) ...[
//                       Icon(Icons.access_time, size: 16, color: Colors.green[600]),
//                       const SizedBox(width: 4),
//                       Text(
//                         gym.hours!,
//                         style: TextStyle(color: Colors.green[600]),
//                       ),
//                     ],
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Amenities
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 4,
//                   children: gym.amenities.take(3).map((amenity) => Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       amenity,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   )).toList(),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Action Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           // Join gym logic here
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Joined gym successfully!')),
//                           );
//                         },
//                         icon: const Icon(Icons.add),
//                         label: const Text('Join'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: OutlinedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => GymMembersScreen(
//                                 gymId: gym.id,
//                                 gymName: gym.name,
//                               ),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.people),
//                         label: const Text('View Members'),
//                         style: OutlinedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }