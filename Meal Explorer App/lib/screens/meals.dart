import 'package:flutter/material.dart';
import 'package:fourth_app/models/meal.dart';
import 'package:fourth_app/screens/mealDetailsScreeen.dart';
import 'package:fourth_app/widgets/mealItem.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onStatusMealFav});
  String? title;
  List<Meal> meals;
  final void Function(Meal meal) onStatusMealFav;
  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetailScreen(meal: meal, onStatusMealFav: onStatusMealFav),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onTapSelectedMeal: onSelectMeal,
      ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'NOTHING HERE',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onError,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Select another category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
