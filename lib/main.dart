// https://flame-engine.org/docs/input.md

import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_base/componentes/carro.dart';
import 'package:game_base/componentes/button_left.dart';
import 'package:game_base/componentes/button_rigth.dart';
import 'componentes/buraco.dart';
import 'package:flame/gestures.dart';
import 'package:game_base/componentes/fundo.dart';

const DRAGON_SIZE = 40.0;

var game;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.images.loadAll([
    'rua.png',
    'buraco.png',
    'carro.png'
  ]);


  var dimensions = await Flame.util.initialDimensions();

  game = JogoBase(dimensions);

  runApp(game.widget);
}

Buraco buraco;
Carro carro;
ButtonLeft buttonLeft;
ButtonRigth buttonRigth;
Fundo fundo;

bool isaAddNave = false;
bool isAddButton = false;
List<Buraco> buracoList;
var points = 0;

class JogoBase extends BaseGame with TapDetector {
  Size dimensions;
  Random random = new Random();

  JogoBase(this.dimensions) {
    carro = new Carro();
    buttonLeft = new ButtonLeft(dimensions);
    buttonRigth = new ButtonRigth(dimensions);
    fundo = new Fundo(this.dimensions);
    buracoList = <Buraco>[];
    add(fundo);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  double creationTimer = 0.0;
  @override
  void update(double t) {
    if (!isaAddNave) {
      add(carro);
      isaAddNave = true;
    }

    creationTimer += t;
    if (creationTimer >= 1.5) {
      creationTimer = 0.0;
      buraco = new Buraco(dimensions, carro);
      buracoList.add(buraco);
      add(buraco);
    }
    points = carro.score;

    print('Placar: $points');

    super.update(t);
  }

  void stopMoving() {
    carro.position = 0;
  }

  void movingRight() {
    carro.position = 1;
  }

  void movingLeft() {
    carro.position = -1;
  }

  @override
  void onTapDown(TapDownDetails details) {
    print(
        "Player tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
    carro.position = details.globalPosition.dx;
  }

  @override
  void onTapUp(TapUpDetails details) {
    print(
        "Player tap up on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }
}
