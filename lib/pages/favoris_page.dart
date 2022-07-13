import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavorisPage extends StatelessWidget {
  final List<Meal> favorite;

  FavorisPage(this.favorite);
  @override
  Widget build(BuildContext context) {
    if (favorite.isEmpty) {
      return Center(
        child: Text("You don't have any favorite yet!"),
      );
    } else {
      return ListView.builder(
          itemBuilder: ((context, index) {
            return MealItem(
              id: favorite[index].id,
              affordability: favorite[index].affordable,
              complexity: favorite[index].complexity,
              duration: favorite[index].duration,
              imageUrl: favorite[index].imageUrl,
              title: favorite[index].name,
            );
          }),
          itemCount: favorite.length);
    }
  }
}
