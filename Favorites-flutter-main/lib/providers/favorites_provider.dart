import 'package:favorites/models/city_model.dart';
import 'package:favorites/models/hobby_model.dart';
import 'package:favorites/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sample_data.dart';

class FavoritesProvider extends ChangeNotifier {

  bool isDarkMode = false;

  final cities = sampleCities;
  final hobbies = sampleHobbies;
  final books = sampleBooks;

  List<CityModel> favoriteCities = [];
  List<HobbyModel> favoriteHobbies = [];
  List<BookModel> favoriteBooks = [];

  FavoritesProvider() {
    loadFavorites();
    loadTheme();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    saveTheme();
    notifyListeners();
  }

  void toggleCityFavorite(int cityId) {
    final city = cities.firstWhere(
      (city) => city.id == cityId,
    );

    city.isFavorite = !city.isFavorite;

    setCityFavorites();
    saveFavorites();
    notifyListeners();
  }

  void toggleHobbyFavorite(int hobbyId) {
    final hobby = hobbies.firstWhere(
      (hobby) => hobby.id == hobbyId,
    );
    hobby.isFavorite = !hobby.isFavorite;

    setHobbyFavorites();
    saveFavorites();
    notifyListeners();
  }

  void toggleBookFavorite(int bookId) {
    final book = books.firstWhere(
      (book) => book.id == bookId,
    );

    book.isFavorite = !book.isFavorite;

    setBookFavorites();
    saveFavorites();
    notifyListeners();
  }

  void clearFavorites() {
    for (final city in cities) {
      city.isFavorite = false;
    }
    for (final hobby in hobbies) {
      hobby.isFavorite = false;
    }
    for (final book in books) {
      book.isFavorite = false;
    }

    setCityFavorites();
    setHobbyFavorites();
    setBookFavorites();

    saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIds = cities
        .where((city) => city.isFavorite)
        .map((city) => city.id.toString())
        .toList();

    final favoriteHobbyIds = hobbies
        .where((hobby) => hobby.isFavorite)
        .map((hobby) => hobby.id.toString())
        .toList();
    
    final favoriteBookIds = books
        .where((book) => book.isFavorite)
        .map((book) => book.id.toString())
        .toList();

    await prefs.setStringList('favoriteCities', favoriteIds);
    await prefs.setStringList('favoriteHobbies', favoriteHobbyIds);
    await prefs.setStringList('favoriteBooks', favoriteBookIds);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIds = prefs.getStringList('favoriteCities') ?? [];
    final favoriteHobbyIds = prefs.getStringList('favoriteHobbies') ?? [];
    final favoriteBookIds = prefs.getStringList('favoriteBooks') ?? [];


    for (final city in cities) {
      city.isFavorite = favoriteIds.contains(city.id.toString());
    }

    for (final hobby in hobbies) {
      hobby.isFavorite = favoriteHobbyIds.contains(hobby.id.toString());
    }

    for (final book in books) {
      book.isFavorite = favoriteBookIds.contains(book.id.toString());
    }

    setCityFavorites();
    setHobbyFavorites();
    setBookFavorites();

    notifyListeners();
  }

  void setCityFavorites() {
    favoriteCities = List.from(cities.where((city) => city.isFavorite));
  }
  void setHobbyFavorites() {
    favoriteHobbies = List.from(hobbies.where((hobby) => hobby.isFavorite));
  }
  void setBookFavorites() {
    favoriteBooks = List.from(books.where((book) => book.isFavorite));
  }


  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('theme', isDarkMode);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    isDarkMode = prefs.getBool('theme') ?? false;
    notifyListeners();
  }
 
}