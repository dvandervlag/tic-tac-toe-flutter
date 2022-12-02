import 'package:flutter/material.dart';

import 'package:tictactoe/helpers/tile_state.dart';
import 'package:tictactoe/models/tile_state.dart';
import 'package:tictactoe/widgets/board_tile.dart';

import 'helpers/find_winner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final _boardState = List.filled(9, TileState.EMPTY);
  var _currentTurn = TileState.X;

  void _resetGame () {
    setState(() {
      _boardState.fillRange(0, 9, TileState.EMPTY);
      _currentTurn = TileState.X;
    });
  }

  void _showWinnerDialog(TileState tileState) {
    final context = navigatorKey.currentState!.overlay!.context;

    showDialog(
      context: context,
      builder: (_) {
        return (
          AlertDialog(
            title: const Text('WINNER'),
            content: Image.asset(
              tileState == TileState.X ? 'assets/images/x.png' : 'assets/images/o.png',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _resetGame();
                  Navigator.of(context).pop();
                },
                child: const Text('New game'),
              )
            ]
          )
        );
      }
    );
  }

  void _updateTileStateForIndex(int selectedIndex) {
    if (_boardState[selectedIndex] != TileState.EMPTY) {
      return;
    }

    // Update our board state.
    setState(() {
      _boardState[selectedIndex] = _currentTurn;
      _currentTurn = _currentTurn == TileState.X
        ? TileState.O
        : TileState.X;
    });

    // Check if we got a winner, and if so
    // Display winner dialog as overlay.
    final winner = findWinner(_boardState);
    if (winner != null) {
      _showWinnerDialog(winner);
    }
  }

  Widget _boardTiles() {
    return Builder(builder: (context) {
      final boardDimension = MediaQuery.of(context).size.width;
      final tileDimension = boardDimension / 3;

      return SizedBox(
        width: boardDimension,
        height: boardDimension,
        child: Column(
          children: chunk(_boardState, 3)
            .asMap()
            .entries
            .map((entry) {
              final chunkIndex = entry.key;
              final tileStateChunk = entry.value;

              return Row(
                children: tileStateChunk.asMap().entries.map((tileStateEntry) {
                  final tileIndex = (chunkIndex * 3) + tileStateEntry.key;
                  final tileState = tileStateEntry.value;

                  return BoardTile(
                    tileState: tileState,
                    dimension: tileDimension,
                    onPressed: () => _updateTileStateForIndex(tileIndex)
                  );
                }).toList(),
              );
            }).toList()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 48,
                ),
                child: Stack(
                  children: [
                    // This is on the bottom, as it's last in the stack (0 = bottom)
                    Image.asset('assets/images/board.png'),

                    // This is on top of the board asset.
                    _boardTiles(),
                  ]
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
