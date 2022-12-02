import 'package:flutter/material.dart';
import 'package:tictactoe/models/tile_state.dart';

class BoardTile extends StatelessWidget {
  final double dimension;
  final TileState tileState;
  final VoidCallback onPressed;

  const BoardTile({
    Key? key,
    required this.dimension,
    required this.onPressed,
    this.tileState = TileState.EMPTY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: TextButton(
        onPressed: onPressed,
        child: _widgetForTileState(),
      )
    );
  }

  Widget _widgetForTileState() {
    switch (tileState) {
      case TileState.X:
        return Image.asset('assets/images/x.png');
      case TileState.O:
        return Image.asset('assets/images/o.png');
      case TileState.EMPTY:
      default:
        return Container();
    }
  }
}