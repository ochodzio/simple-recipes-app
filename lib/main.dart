// ignore_for_file: empty_statements

import 'dart:ui';

import 'package:adv_app/dummy_data.dart';
import 'package:adv_app/screens/categories_screen.dart';
import 'package:adv_app/screens/category_meals_screen.dart';
import 'package:adv_app/screens/filters_screen.dart';
import 'package:adv_app/screens/meal_detail_screen.dart';
import 'package:adv_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters ={
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favoritedMeals =[];

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters= filterData;
      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten']==true && !meal.isGlutenFree) {
          return false;
        }if(_filters['lactose']==true && !meal.isLactoseFree) {
          return false;
        }
        if(_filters['vegan']==true && !meal.isVegan) {
          return false;
        }
        if(_filters['vegetarian']==true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });

  }

  void _toggleFavorite(String mealId){
   final existringIndex= _favoritedMeals.indexWhere((meal) => meal.id==mealId);
    if(existringIndex >=0){
      setState(() {
        _favoritedMeals.removeAt(existringIndex);
      });
    }else{
      setState(() {
        _favoritedMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }
  }

  bool _isMealFavrite(String id){
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabsScreen(_favoritedMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavrite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
