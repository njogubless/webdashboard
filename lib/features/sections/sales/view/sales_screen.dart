import 'package:flutter/material.dart';
import 'package:webdashboard/features/sections/sales/widgets/_index.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AddCategory(),
        const SizedBox(width: 10),
        CategoryItem(
          color: Colors.blue[400]!,
          categoryTitle: 'Main Course',
          itemsTotal: 13,
        ),
        const SizedBox(width: 10),
        CategoryItem(
          color: Colors.red[400]!,
          categoryTitle: 'Pasta',
          itemsTotal: 13,
        ),
        const SizedBox(width: 10),
        CategoryItem(
          color: Colors.purple[400]!,
          categoryTitle: 'Sushi',
          itemsTotal: 13,
        ),
        const SizedBox(width: 10),
        CategoryItem(
          color: Colors.green[400]!,
          categoryTitle: 'Alcohol',
          itemsTotal: 13,
        ),
      ],
    );
  }
}
