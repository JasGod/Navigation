import 'package:flutter/material.dart';
import 'package:flutter_nav/dummy_data.dart';
import 'package:flutter_nav/pages/Filters_page.dart';
import 'package:flutter_nav/pages/meal_detail_page.dart';
import 'package:flutter_nav/pages/tabs_page.dart';
import './pages/category_page.dart';
import './pages/category_recipe_page.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _setFavoriteMeals(String mealId) {
    final exitingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (exitingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exitingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavoriteMeal(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme:
            ColorScheme.light(primary: Colors.pink, secondary: Colors.amber),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
      ),
      home: TabsPage(_favoriteMeals),
      // initialRoute: '/', // default route.
      routes: {
        // '/':(context) => CategoryPage(),
        CategoryRecipePage.routeName: (context) =>
            CategoryRecipePage(_availableMeals),
        MealDetailPage.routeName: (context) =>
            MealDetailPage(_setFavoriteMeals, _isFavoriteMeal),
        FiltersPage.routeName: (context) => FiltersPage(_filters, _setFilters),
      },
/*       onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: ((context) => CategoryPage()));
      }, */
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => CategoryPage()));
      },
    );
  }
}
