import 'package:flutter/material.dart';
import '/widgets/city_card.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/hobby_row.dart';
import '../widgets/book_row.dart';


enum ContentCategory {
  cities,
  hobbies,
  books,
}

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  ContentCategory selectedCategory = ContentCategory.cities;
  String searchText = "";

  String get searchHint => "Search ${selectedCategory.name}";

  @override
  Widget build(BuildContext context) {

    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    
    final city = favoritesProvider.cities;
    final hobby = favoritesProvider.hobbies;
    final book = favoritesProvider.books;

    final filteredCities = city.where((city) => city.cityName.toLowerCase().startsWith(searchText.toLowerCase())).toList();
    final filteredHobbies = hobby.where((hobby) => hobby.hobbyName.toLowerCase().startsWith(searchText.toLowerCase())).toList();
    final filteredBooks = book.where((book) => book.bookTitle.toLowerCase().startsWith(searchText.toLowerCase())).toList();

    
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SegmentedButton(
              segments: [
                ButtonSegment(
                  value: ContentCategory.cities,
                  label: Text("Cities")),
                ButtonSegment(
                  value: ContentCategory.hobbies,
                  label: Text("Hobbies")),
                ButtonSegment(
                  value: ContentCategory.books,
                  label: Text("Books"))
              ], 
              selected: {selectedCategory},
              onSelectionChanged: (selection) {
                setState(() {
                  selectedCategory = selection.first;
                });
              },),

            SizedBox(height: 16,),

            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: searchHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            SizedBox(height: 16),

            Expanded(
              child: Builder(
                builder: (context) {
                  switch (selectedCategory) {
                    case ContentCategory.cities:
                      return ListView.builder(
                        itemCount: filteredCities.length,
                        itemBuilder: (context, index) {
                          final cityList = filteredCities[index];
                          return CityCard(city: cityList);
                        },
                      );
                    case ContentCategory.hobbies:
                      return ListView.builder(
                        itemCount: filteredHobbies.length,
                        itemBuilder: (context, index) {
                          // final hobby = favoritesProvider.hobbies[index];
                          final hobbyList = filteredHobbies[index];
                          return HobbyRow(hobby: hobbyList);
                        },
                      );
                    case ContentCategory.books:
                      return ListView.builder(
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          // final book = favoritesProvider.books[index];
                          final booksList = filteredBooks[index];
                          return BookRow(book: booksList);
                        },
                      );
                  }
                }
              ),
            ),
          ],
        ),
        )),
    );
  }
}