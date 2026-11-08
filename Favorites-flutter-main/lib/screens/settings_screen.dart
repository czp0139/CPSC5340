import 'package:favorites/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClearFav extends StatelessWidget {
  const ClearFav({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
        favoritesProvider.clearFavorites();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Confirmed!'),
              content: Text('Your Favorites have been cleared'),
            );
          }
        );
      },
      child: Text("Clear Favorites")
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context); 
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 24),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  Switch(
                    value: favoritesProvider.isDarkMode,
                    onChanged: (value) {
                      favoritesProvider.toggleDarkMode(value);

                    },
                  ),


                ],

              ),
              SizedBox(height: 16),

              ClearFav(), 
              // ElevatedButton(
              //   onPressed: () {
              //     favoritesProvider.clearFavorites();
              //   },
              //   child: Text("Clear Favorites"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}