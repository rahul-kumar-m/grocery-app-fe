import 'package:flutter/material.dart';
import 'package:grocery_app_fe/home/bloc/home_bloc.dart';

import '../../data/user.dart';

class CustomFilterButton extends StatelessWidget {
  HomeBloc bloc ;
  User user;
  CustomFilterButton({super.key, required this.bloc,required this.user});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list,color:Colors.white), // Filter icon
      onPressed: () {
        // Show the filter menu when the filter icon is pressed
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(MediaQuery.of(context).size.width, 90,0,0 ), // Position the menu below the app bar
          items: [
            PopupMenuItem<String>(
              value: 'ascending',
              child: Text('A-Z(default)'),
              onTap: (){bloc.add(HomeInitialEvent("asc", user: user));},
            ),
            PopupMenuItem<String>(
              value: 'descending',
              child: Text('Z-A'),
              onTap: (){bloc.add(HomeInitialEvent("dsc", user: user));},
            ),
            PopupMenuItem<String>(
              value: 'grains',
              child: Text('Grains'),
              onTap: (){bloc.add(HomeInitialEvent("Grains", user: user));},
            ),
            PopupMenuItem<String>(
              value: 'vegetable',
              child: Text('Vegetables'),
              onTap: (){bloc.add(HomeInitialEvent("vegetable", user: user));},
            ),
            PopupMenuItem<String>(
              value: 'fruits',
              child: Text('Fruits'),
              onTap: (){bloc.add(HomeInitialEvent("fruit", user: user));},

            ),
            PopupMenuItem<String>(
              value: 'meat',
              child: Text('Meat'),
              onTap: (){bloc.add(HomeInitialEvent("meat", user: user));},

            ),
            PopupMenuItem<String>(
              value: 'bread',
              child: Text('Breads'),
              onTap: (){bloc.add(HomeInitialEvent("breads", user: user));},
            ),
            PopupMenuItem<String>(
              value: 'dairy',
              child: Text('Dairy'),
              onTap: (){bloc.add(HomeInitialEvent("dairy", user: user));},
            ),
            // Add more PopupMenuItem widgets for additional options
          ],
        );
      },
    );
  }
}