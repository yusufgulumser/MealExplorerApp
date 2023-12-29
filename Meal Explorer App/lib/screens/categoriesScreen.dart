import 'package:flutter/material.dart';
import 'package:fourth_app/data/dummyData.dart';
import 'package:fourth_app/models/meal.dart';
import 'package:fourth_app/screens/meals.dart';
import 'package:fourth_app/widgets/categoryGridItem.dart';
import 'package:fourth_app/models/categories.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(
      {super.key, required this.onStatusMealFav, required this.availableMeals});

  final void Function(Meal meal) onStatusMealFav;
  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onStatusMealFav: onStatusMealFav,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(18),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // ALTERNATIVE WAY // availableCategories.map((category)=> CategoryGridItem(category: category)).toList()
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onTapSelectedCategory: () {
              _selectedCategory(context, category);
            },
          )
      ],
    );
  }
}
