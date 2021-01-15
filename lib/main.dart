import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // build se llama en cada renderizado

    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme(
              onPrimary: Colors.grey,
              brightness: Brightness.dark,
              surface: Colors.white,
              onSecondary: Colors.black,
              onSurface: Colors.blueGrey,
              error: Colors.red,
              primaryVariant: Colors.lightGreen,
              onBackground: Colors.white,
              onError: Colors.redAccent,
              secondaryVariant: Colors.blueAccent,
              primary: Colors.black,
              secondary: Colors.grey,
              background: Colors.black),
          primaryColor: Colors.grey,
          accentColor: Colors.black),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont =
      const TextStyle(fontStyle: FontStyle.italic, fontSize: 15.4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator < : v'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i % 2 != 0)
          return Divider(
            color: Colors.black,
            height: 10,
            thickness: 5,
          );
        if (i >= _suggestions.length)
          _suggestions.addAll(generateWordPairs().take(10));
        //final index = i % 2;
        return _buildRow(_suggestions[i]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      tileColor: Colors.grey,
      trailing: Icon(
        alreadySaved
            ? Icons.airplanemode_on
            : Icons.airplanemode_active_outlined,
        color: alreadySaved ? Colors.black : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);
        });
      },
    );
  }
}
//Stateless no persisten los datos Statefull persisten
//EN DART EL _<variable> significa privada
//las listas son <Tipo>[];
//Lista es una lista Set es lista de objetos unicos y diferentes no se pueden repetir
