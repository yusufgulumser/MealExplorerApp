import 'package:flutter/material.dart';
import 'package:fourth_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  MealDetailScreen(
      {super.key, required this.meal, required this.onStatusMealFav});
  Meal meal;
  final void Function(Meal meal) onStatusMealFav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: () {
                  onStatusMealFav(meal);
                },
                icon: const Icon(Icons.favorite))
          ],
        ),
        body: ListView(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Ingredients',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Steps',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
            ),
            for (final steps in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                child: Text(
                  steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
          ],
        ));
  }
}
