import 'package:flutter/material.dart';
import 'package:fourth_app/models/meal.dart';
import 'package:fourth_app/widgets/mealItemTrait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem(
      {super.key, required this.meal, required this.onTapSelectedMeal});
  final Meal meal;

  final Function(BuildContext context, Meal meal) onTapSelectedMeal;

  String get mealComplexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get mealAffordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onTapSelectedMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black45,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 45),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTr(
                            icon: Icons.schedule_rounded,
                            textt: '${meal.duration} minute'),
                        const SizedBox(width: 10),
                        MealItemTr(
                            icon: Icons.handyman_rounded,
                            textt: mealComplexity),
                        const SizedBox(width: 10),
                        MealItemTr(icon: Icons.money, textt: mealAffordability)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
