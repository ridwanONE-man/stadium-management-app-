// shoppage.dart
import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths and item details
    final List<Map<String, String>> shopItems = [
      {"image": "assets/shop/No-Logo-Sports-Wear-Football-Training-Mesh-Vests-in-Stock (2).webp", "name": "Mesh Vest"},
      {"image": "assets/shop/No-Logo-Sports-Wear-Football-Training-Mesh-Vests-in-Stock (1).webp", "name": "Mesh Vest"},
      {"image": "assets/shop/No-Logo-Sports-Wear-Football-Training-Mesh-Vests-in-Stock.webp", "name": "Mesh Vest"},
      {"image": "assets/shop/New-Modle-Man-Wholesale-High-Quality-Custom-Sport-Football-Shirts-Polo-Shirt-Short-Sleeve-Printed-Pattern-Golf-Polo-Jersey-Sports-Wear-T-Shirt.webp", "name": "Polo Shirt"},
      {"image": "assets/shop/New-Factory-Price-TPU-Sole-Fashion-Football-Shoes-Outdoor-Soccer-Shoes.webp", "name": "Soccer Shoes"},
      {"image": "assets/shop/Mesh-T-Shirt-Shorts-Tracksuit-Sports-Wear-for-Men-Jogging-Suit-Football-Basketball-Garments.webp", "name": "Tracksuit"},
      {"image": "assets/shop/Men-s-Soccer-Cleats-Professional-High-Top-Breathable-Athletic-Football-Shoes-Ex-24f7005 (1).webp", "name": "Soccer Cleats"},
      {"image": "assets/shop/Men-s-Soccer-Cleats-Professional-High-Top-Breathable-Athletic-Football-Shoes-Ex-24f7005.webp", "name": "Soccer Cleats"},
      {"image": "assets/shop/Men-and-Women-PU-Upper-Rb-Sole-Soccer-Boots-Football-Footwear.webp", "name": "Soccer Boots"},
      {"image": "assets/shop/Football-Boots-Professional-Training-Turf-Outdoor-Sports-Mens-Soccer-Cleats-Shoes.webp", "name": "Turf Shoes"},
      {"image": "assets/shop/Custom-Sports-Singlet-Australian-Football-Shirt-Jersey-Rugby-Football-Wear-Shirts-Tops.webp", "name": "Singlet Jersey"},
      {"image": "assets/shop/2024-New-Fashion-Men-Football-Shoes-Wholesale-Sneakers-Women-Soccer-Shoe.webp", "name": "Fashion Soccer Shoes"},
      {"image": "assets/shop/23-24-Wholesale-Ajax-Football-Team-White-Jerseys-Training-Wear-Fall-Long-Sleeve-Pants-Half-Zip-Football-Jacket.webp", "name": "Team Jacket"}
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.lightBlue, // Updated AppBar color
        title: const Text(
          '🏟️ Sports Shop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue[50], // Light blue background color
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10.0),
        itemCount: shopItems.length,
        itemBuilder: (context, index) {
          final item = shopItems[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the buy page when the card is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyPage(item: item),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '\$10',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuyPage extends StatelessWidget {
  final Map<String, String> item;

  const BuyPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Consistent AppBar color
        title: const Text('Buy Item'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(item['image']!),
            const SizedBox(height: 20),
            Text(
              item['name']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Price: \$10',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle purchase logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proceeding to checkout...')),
                );
              },
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
