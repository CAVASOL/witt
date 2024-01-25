import 'package:flutter/material.dart';

class CategoryNav extends StatelessWidget {
  const CategoryNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 32,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCategoryItem('assets/images/fire.png', 'Trending'),
            _buildCategoryItem('assets/images/palm-tree.png', 'Island'),
            _buildCategoryItem('assets/images/cave.png', 'Cave'),
            _buildCategoryItem('assets/images/cactus.png', 'Desert'),
            _buildCategoryItem('assets/images/island.png', 'Tropical'),
            _buildCategoryItem('assets/images/art.png', 'Art'),
            _buildCategoryItem('assets/images/swimming-pool.png', 'Pool'),
            _buildCategoryItem('assets/images/villa.png', 'Mansion'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 32,
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 20,
            width: 20,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
