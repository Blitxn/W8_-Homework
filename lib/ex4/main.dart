import 'package:flutter/material.dart';
import 'package:w8_practice/ex4/data/jokes.dart';
import 'package:w8_practice/ex4/model/joke.dart';
import 'ex4/data/jokes.dart';

Color appColor = Colors.green[300] as Color;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JokeApp(),
    ),
  );
}

// Parent widget: manages the favorite joke
class JokeApp extends StatefulWidget {
  const JokeApp({super.key});

  @override
  State<JokeApp> createState() => _JokeAppState();
}

class _JokeAppState extends State<JokeApp> {
  Joke? favoriteJoke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: ListView(
        children: [
          ...jokes.map((joke) {
            return FavoriteCard(
              joke: joke,
              isFavorite: favoriteJoke == joke,
              onFavoriteClick: () {
                setState(() {
                  favoriteJoke =
                      favoriteJoke == joke ? null : joke;
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Child widget: displays one joke
class FavoriteCard extends StatelessWidget {
  final Joke joke;
  final bool isFavorite;
  final VoidCallback onFavoriteClick;

  const FavoriteCard({
    super.key,
    required this.joke,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.title,
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(joke.description),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoriteClick,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
