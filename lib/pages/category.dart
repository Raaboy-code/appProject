import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String kBaseUrl = "http://10.0.2.2:5280";
const String kCategoryUrl = "/api/Category";

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State <CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State <CategoriesPage> {
  Future<List> getCategories() async {
    final response = await http.get(Uri.parse('$kBaseUrl/api/Category'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }


  late Future<List> _futureCategories;
  @override
  void initState() {
    super.initState();
    _futureCategories = getCategories(); // store it once
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: _buildSearchBar(),
      ),
      body: FutureBuilder<List>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null){
            return Center(child: Text('No Data'));
          }
          if(snapshot.data!.isEmpty){
            return Center(child: Text('Data is Empty'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final category = snapshot.data![index];
              String imagePath = category['image'] ?? '';
              String fullImageUrl = '$kBaseUrl/${imagePath.startsWith('/Images/') ? imagePath.substring(1) : imagePath}';;
              print('Image path from API: $imagePath');
              print('Full Image URL: $fullImageUrl');

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                elevation: 2,
                child: ListTile(
                  leading: Image.network(
                    fullImageUrl,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image),
                  ),
                  title: Text(category['categoryName'] ?? 'No Category'),
                  subtitle: Text(category['description'] ?? 'No Description'),
                  trailing: Text(category['status']?.toString() ?? 'No Status'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search ...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
        ),
      ),
    );
  }
}


// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'type_detail.dart';
// import 'brand_detail.dart';
// import 'package:http/http.dart' as http;
//
// class CategoriesPage extends StatelessWidget {
//   const CategoriesPage({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> categoriesData = [
//       {'id': 'type_001', 'icon': Icons.speaker, 'name': 'Speaker'},
//       {'id': 'type_002', 'icon': Icons.headphones, 'name': 'Headphone'},
//       {'id': 'type_003', 'icon': Icons.headset_mic, 'name': 'Earbuds'},
//       {'id': 'type_004', 'icon': Icons.keyboard, 'name': 'Keyboard'},
//     ];
//
//     final List<Map<String, dynamic>> brandsData = [
//       {'id': 'brand_001', 'icon': Icons.abc, 'name': 'Brand A'},
//       {'id': 'brand_002', 'icon': Icons.business, 'name': 'Brand B'},
//       {'id': 'brand_003', 'icon': Icons.devices, 'name': 'Brand C'},
//       {'id': 'brand_004', 'icon': Icons.desktop_mac, 'name': 'Brand D'},
//       {'id': 'brand_005', 'icon': Icons.e_mobiledata, 'name': 'Brand E'},
//       {'id': 'brand_006', 'icon': Icons.settings, 'name': 'Tech Corp'},
//     ];
//
//     Future<List<Map<String, dynamic>>> getCategories() async {
//       var url = Uri.https(kBaseUrl, kCategoryUrl);
//       final response = await http.get(url);
//       final data = jsonDecode(response.body);
//
//       return data;
//     }
//
//
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           title: _buildSearchBar(),
//           bottom: const TabBar(
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.grey,
//             indicatorColor: Colors.blue,
//             tabs: [
//               Tab(text: 'type'),
//               Tab(text: 'Brand'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             CategoryListTab(
//               items: categoriesData,
//               categoryType: 'type',
//               itemBuilder: (item) => TypeItemWidget(item: item),
//             ),
//             CategoryListTab(
//               items: brandsData,
//               categoryType: 'Brand',
//               itemBuilder: (item) => BrandItemWidget(item: item),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search ...',
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//           filled: true,
//           fillColor: Colors.grey[100],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide.none,
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(color: Colors.blue, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryListTab extends StatelessWidget {
//   final List<Map<String, dynamic>> items;
//   final String categoryType;
//   final Widget Function(Map<String, dynamic> item) itemBuilder;
//
//   const CategoryListTab({
//     super.key,
//     required this.items,
//     required this.categoryType,
//     required this.itemBuilder,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) {
//       return Center(child: Text('No $categoryType found.'));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GridView.builder(
//         itemCount: items.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 40,
//           mainAxisSpacing: 40,
//           childAspectRatio: 1.2,
//         ),
//         itemBuilder: (context, index) => itemBuilder(items[index]),
//       ),
//     );
//   }
// }
//
// class TypeItemWidget extends StatelessWidget {
//   final Map<String, dynamic> item;
//
//   const TypeItemWidget({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => TypeDetailsPage(item: item)),
//         );
//       },
//       child: AspectRatio(
//         aspectRatio: 1,
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF0273d5),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 3,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(item['icon'], size: 32, color: Colors.white),
//               const SizedBox(height: 8),
//               Text(
//                 item['name'],
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class BrandItemWidget extends StatelessWidget {
//   final Map<String, dynamic> item;
//
//   const BrandItemWidget({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => BrandDetailsPage(item: item)),
//         );
//       },
//       child: AspectRatio(
//         aspectRatio: 1,
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFF0273d5),
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 3,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(item['icon'], size: 32, color: Colors.white),
//               const SizedBox(height: 8),
//               Text(
//                 item['name'],
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


