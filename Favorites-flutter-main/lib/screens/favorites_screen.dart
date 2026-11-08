import 'package:flutter/material.dart';
import '/widgets/city_card.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/hobby_row.dart';
import '../widgets/book_row.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
  Widget build(BuildContext context) {
    return Center(
      child: Text("Favorites Screen"),
    );
  }
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [          
            SizedBox(height: 16),


// need to change this so instead of doing the if not, and shrinsk - need to maka  list of favs
            if (context.watch<FavoritesProvider>().cities.isNotEmpty)

              Text("Favorite Cities:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              
              Expanded(
              child: ListView.builder(
                  itemCount: context.watch<FavoritesProvider>().favoriteCities.length,
                  itemBuilder: (context, index) {
                    final city = context.watch<FavoritesProvider>().favoriteCities[index];
                    // if (!city.isFavorite) return SizedBox.shrink();
                    return CityCard(city: city);
                  },
                ),
              ),
            
            SizedBox(height: 16),

            Text("Favorite Hobbies:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<FavoritesProvider>().hobbies.length,
                itemBuilder: (context, index) {
                  final hobby = context.watch<FavoritesProvider>().hobbies[index];
                  if (!hobby.isFavorite) return SizedBox.shrink();  
                  return HobbyRow(hobby: hobby);
                  },
                ),
              ),

            SizedBox(height: 16),

            Text("Favorite Books:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<FavoritesProvider>().books.length,
                itemBuilder: (context, index) {
                  final book = context.watch<FavoritesProvider>().books[index];
                  if (!book.isFavorite) return SizedBox.shrink();  
                  return BookRow(book: book);
                },
              ),
            ),
            ],
          ),
        ),
      )
    );
  }
}