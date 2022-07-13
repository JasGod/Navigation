import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  Widget buildListMenu(String text, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 120,
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.all(20),
            child: Text(
              'Cooking up',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListMenu('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListMenu('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed('/filters');
          }),
        ],
      ),
    );
  }
}
