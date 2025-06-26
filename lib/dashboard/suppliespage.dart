import 'package:flutter/material.dart';

class SuppliesPage extends StatelessWidget {
  const SuppliesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample product data
    final List<Map<String, String>> products = [
      {
        'image': 'lib/assets/Ecofarm.png',
        'name': 'Ecofarm Adult Cats Dry Food Chicken Recipe (10 Kg)',
        'price': '1,150.00 EGP',
      },
      {
        'image': 'lib/assets/Simba.png',
        'name': 'Simba Chunks With Guinea Fowl & Duck Wet Cat Food (415g)',
        'price': '60.00 EGP',
      }
      // Add more products here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplies'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 110,
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Image.asset(
                      product['image']!,
                      width: 50,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product['name']!),
                    subtitle: Text(product['price']!),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}