import 'package:flutter/material.dart';
import 'package:fourth_app/models/categories.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onTapSelectedCategory});
  final Category category;
  final void Function() onTapSelectedCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapSelectedCategory,
      splashColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.50),
              category.color.withOpacity(0.92),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
