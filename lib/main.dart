import 'package:cooking_papa/models/mealDetails.dart';
import 'package:cooking_papa/screens/home_screen.dart';
import 'package:cooking_papa/screens/ingredient_screen.dart';
import 'package:cooking_papa/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cooking_papa/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';
import './screens/home_screen.dart';
import 'firebase_options.dart';
import './providers/Recipe.dart';
import 'package:provider/provider.dart';
import 'package:cooking_papa/screens/ForgotPassword.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<MealDetails> _favoriteMeals = [];
  var _loadedInitData = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    getData();
    super.didChangeDependencies();
  }

  getData() async {
    if (!_loadedInitData) {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user.uid;
      final ref = FirebaseDatabase.instance.ref();
      print(uid);
      setState(() {
        _isLoading = true;
      });
      final snapshot = await ref.child('$uid/favorite').get();
      print(snapshot);
      if (snapshot.exists) {
        print(snapshot.value);
        Provider.of<Recipe>(context).setFavoriteList(snapshot.value);
        setState(() {
          _isLoading = false;
        });
      } else {
        print('No data available.');
      }
      _favoriteMeals = Provider.of<Recipe>(context).favoriteList;
      _loadedInitData = true;
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
    });
  }

  void _toggleFavorite(int mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {});
    }
  }

  bool _isMealFavorite(int id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Recipe>(
        create: (BuildContext context) => Recipe(),
        child: MaterialApp(
          title: 'DeliMeals',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.red)),
            primaryColor: Colors.white,
            accentColor: Colors.red,
            canvasColor: Colors.white,
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                )),
          ),
          initialRoute: '/login', // default is '/'
          routes: {
            '/': (ctx) => TabsScreen(_favoriteMeals),
            LoginPage.routeName: (ctx) => LoginPage(),
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            IngredientScreen.routeName: (ctx) => const IngredientScreen(),
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
            MealDetailScreen.routeName: (ctx) =>
                MealDetailScreen(_toggleFavorite, _isMealFavorite),
            FiltersScreen.routeName: (ctx) =>
                FiltersScreen(_filters, _setFilters),
          },
          onGenerateRoute: (settings) {},
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (ctx) => CategoriesScreen(),
            );
          },
        ));
  }
}
