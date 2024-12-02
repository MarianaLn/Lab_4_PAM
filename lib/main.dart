import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasources/wine_datasource.dart';
import '../data/repositories/wine_repository_impl.dart';
import '../domain/usecase/get_wines.dart';
import '../presentation/controllers/wine_controller.dart';
import '../presentation/pages/wine_page.dart';
import 'package:http/http.dart' as http;


void main() {
  void main() {
    final wineDataSource = WineDataSourceImpl(http.Client());
    final wineRepository = WineRepositoryImpl(wineDataSource);
    final getWinesUseCase = GetWines(wineRepository);

    Get.put(WineController(getWinesUseCase));

    runApp(MaterialApp(home: WinePage()));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WineShopScreen(),
    );
  }
}

class WineShopScreen extends StatelessWidget {
 // final WineController wineController = Get.put(WineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBar(),
            SizedBox(height: 24),
            buildSectionTitle('Shop wines by'),
            SizedBox(height: 16),
            buildWineCategoryChips(),
            SizedBox(height: 16),
            buildWineCategoriesGrid(),
            SizedBox(height: 24),
            buildNewWineSection(),
            SizedBox(height: 16),
            //Expanded(child: buildWineItemsList()),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white70,
      elevation: 1,
      leading: Icon(Icons.location_on_outlined),
      title: buildLocationDropdown(),
      actions: [buildNotificationIcon()],
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.black54),
          hintText: 'Search',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.mic_none, color: Colors.black54),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget buildLocationDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            print('Dropdown tapped');
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Donnerville Drive',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    '4 Donnerville Hall, Donnerville Drive',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNotificationIcon() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black54),
            onPressed: () {},
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.pink[800],
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: BoxConstraints(minWidth: 24, minHeight: 24),
            child: Text(
              '12',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWineCategoryChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WineCategoryChip(label: 'Type', isSelected: true),
        WineCategoryChip(label: 'Style'),
        WineCategoryChip(label: 'Countries'),
        WineCategoryChip(label: 'Grape'),
      ],
    );
  }

  Widget buildWineCategoriesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        WineCategoryCard(
          imagePath: 'assets/images/poza1.jpg',
          title: 'Red wines',
        ),
        WineCategoryCard(
          imagePath: 'assets/images/poza2.jpg',
          title: 'White wines',
        ),
      ],
    );
  }

  Widget buildNewWineSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSectionTitle('Wine'),
        Text(
          'view all',
          style: TextStyle(fontSize: 14, color: Colors.pink[800]),
        ),
      ],
    );
  }

  /*Widget buildWineItemsList() {
    return Obx(() {
      if (wineController.wineList.isEmpty) {
        return Center(
          child: Text(
            "No wines available.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }

      return ListView.builder(
        itemCount: wineController.wineList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final wine = wineController.wineList[index];
          return WineItemCard(
            title: wine.title,
            subtitle: wine.subtitle,
            country: wine.country,
            price: wine.price,
            score: wine.score,
            imageUrl: wine.imageUrl,
            wineType: wine.wineType,
            isAvailable: wine.isAvailable,
            isFavourite: wine.isFavourite,
            countryFlagPath: wine.countryFlagPath,
            quantity: wine.quantity,
          );
        },
      );
    });
  }*/

}

class WineCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  WineCategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {},
      selectedColor: Colors.pink[50],
      labelStyle: TextStyle(
        color: isSelected ? Colors.pink[800] : Colors.black54,
        fontWeight: FontWeight.bold,
      ),
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? Colors.pink : Colors.black12,
          width: 1.0,
        ),
      ),
    );
  }
}

class WineCategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;

  WineCategoryCard({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 130),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.pink[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),   // Top-left corner straight
                  topRight: Radius.circular(12),  // Top-right corner rounded
                  bottomLeft: Radius.circular(12), // Bottom-left rounded
                  bottomRight: Radius.circular(0), // Bottom-right corner straight
                ),
              ),
              constraints: BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              child: Text(
                '123',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class WineItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String country;
  final String price;
  final String score;
  final String imageUrl;
  final String wineType;
  final bool isAvailable;
  final bool isFavourite;
  final String countryFlagPath;
  final int quantity;

  WineItemCard({
    required this.title,
    required this.subtitle,
    required this.country,
    required this.price,
    required this.score,
    required this.imageUrl,
    required this.wineType,
    required this.isAvailable,
    required this.isFavourite,
    required this.countryFlagPath,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      imageUrl,
                      height: 160,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isAvailable ? Colors.green[100] : Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isAvailable ? "Available" : "Unavailable",
                            style: TextStyle(
                              fontSize: 12,
                              color: isAvailable ? Colors.green[900] : Colors.redAccent,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          title,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/poza7.jpg',
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(width: 4),
                            Text(subtitle),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                countryFlagPath,
                                height: 16,
                                width: 16,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(country),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Section with background
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isFavourite ? Colors.pink : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isFavourite ? Icons.favorite : Icons.favorite_border,
                              color: isFavourite ? Colors.white : Colors.black54,
                            ),
                            SizedBox(width: 4),
                            Text(
                              isFavourite ? 'Added' : 'Favourite',
                              style: TextStyle(
                                color: isFavourite ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Price
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Score and Quantity row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Critics\' Scores: $score',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      'Bottle ($quantity ml)',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
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
