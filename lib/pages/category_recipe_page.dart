import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryRecipePage extends StatefulWidget {
  static const routeName = '/category-recipe';

  final List<Meal> availableMeals;

  CategoryRecipePage(this.availableMeals);

  @override
  State<CategoryRecipePage> createState() => _CategoryRecipePageState();
}

class _CategoryRecipePageState extends State<CategoryRecipePage> {
  String _title = '';
  List<Meal> _categoryMeals;
  var _loadInitData = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final id = routeArgs['id'];
      _title = routeArgs['title'];
      _categoryMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(id),
          )
          .toList();
      _loadInitData = true;
    }
  }

/*   void _DeletedMeal(String mealId) {
    setState(() {
      _categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: ListView.builder(
            itemBuilder: ((context, index) {
              return MealItem(
                id: _categoryMeals[index].id,
                affordability: _categoryMeals[index].affordable,
                complexity: _categoryMeals[index].complexity,
                duration: _categoryMeals[index].duration,
                imageUrl: _categoryMeals[index].imageUrl,
                title: _categoryMeals[index].name,
              );
            }),
            itemCount: _categoryMeals.length));
  }
}
