import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fourth_app/data/dummyData.dart';
import 'package:fourth_app/models/meal.dart';
import 'package:fourth_app/screens/categoriesScreen.dart';
import 'package:fourth_app/screens/filterScreen.dart';
import 'package:fourth_app/screens/meals.dart';
import 'package:fourth_app/widgets/mainDrawer.dart';

const initialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Map<Filter, bool> _selectedFilters = initialFilters;

  _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
            builder: (ctx) => FilterScreen(
                  currentFilters: _selectedFilters,
                )),
      );
      setState(() {
        _selectedFilters = result ?? initialFilters;
      });
    }
  }

  final List<Meal> _favMeals = [];
  void _showingMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _favMealStatus(Meal meal) {
    final isExist = _favMeals.contains(meal);

    if (isExist) {
      setState(() {
        _favMeals.remove(meal);
        _showingMessage('Meal removed from your favorites');
      });
    } else {
      setState(() {
        _favMeals.add(meal);
        _showingMessage('Meal added to your favorites');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoryScreen(
      onStatusMealFav: _favMealStatus,
      availableMeals: availableMeals,
    );
    var activeTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favMeals,
        onStatusMealFav: _favMealStatus,
      );
      activeTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
