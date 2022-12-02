import 'dart:math';

import 'package:tictactoe/models/tile_state.dart';

///
/// Takes a list of TileStates, and generates a 2-dimensional array based of the given size.
///
List<List<TileState>> chunk(List<TileState> list, int size) {
  return List.generate(
    (list.length / size).ceil(),
    (index) =>
      list.sublist(index * size, min(index * size + size, list.length))
  );
}