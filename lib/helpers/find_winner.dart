import 'package:tictactoe/models/tile_state.dart';

TileState? findWinner(List<TileState> boardState) {
  winnerForMatch(int a, int b, int c) {
    if (boardState[a] == TileState.EMPTY) {
      return null;
    }

    if ((boardState[a] == boardState[b]) &&
        (boardState[a] == boardState[c])) {
      return boardState[a];
    }
  }

  final checks = [
    winnerForMatch(0, 1, 2),
    winnerForMatch(3, 4, 5),
    winnerForMatch(6, 7, 8),
    winnerForMatch(0, 3, 6),
    winnerForMatch(1, 4, 7),
    winnerForMatch(2, 5, 8),
    winnerForMatch(0, 4, 8),
    winnerForMatch(2, 4, 6),
  ].whereType<TileState>();
  
  return checks.isEmpty ? null : checks.first;
}
