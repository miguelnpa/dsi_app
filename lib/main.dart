import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  bool seletorVisualizacao = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
          IconButton(
            onPressed: () => setState(() {
              if (seletorVisualizacao) {
                seletorVisualizacao = false;
              } else {
                seletorVisualizacao = true;
              }
            }),
            icon: Icon(Icons.grid_goldenratio),
          )
        ],
      ),
      body: _visualizao(),
    );
  }

  Widget _visualizao() {
    switch (seletorVisualizacao) {
      case false:
        return _buildSuggestionsListView();
      case true:
        return _buildSuggestionsGridView();
    }
    return const Text("");
  }

  Widget _buildSuggestionsListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return const Divider();
        }
        final int index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildSuggestionsGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext _context, int i) {
        final int index = i;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildCard(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(
          () {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          },
        );
      },
    );
  }

  Widget _buildCard(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return Card(
      child: InkWell(
        onTap: () {
          setState(
            () {
              if (alreadySaved) {
                _saved.remove(pair);
              } else {
                _saved.add(pair);
              }
            },
          );
        },
        child: SizedBox(
          child: Center(
            child: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          ),
        ),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
