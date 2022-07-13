import 'package:flutter/material.dart';
import 'package:flutter_nav/pages/category_page.dart';
import 'package:flutter_nav/pages/favoris_page.dart';
import 'package:flutter_nav/widgets/drawer_menu.dart';

import '../models/meal.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsPage(this.favoriteMeals);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'title': 'Categories', 'page': CategoryPage()},
      {'page': FavorisPage(widget.favoriteMeals), 'title': 'Your Favorites'},
    ];
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: DrawerMenu(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          selectedItemColor: Colors.black38,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(153, 228, 16, 86),
                icon: Icon(Icons.category),
                label: 'Categories'),
            BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(173, 247, 59, 122),
                icon: Icon(Icons.star),
                label: 'Favorites'),
          ]),
    );
  }
}
