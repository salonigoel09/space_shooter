import 'dart:html';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter/Bullet.dart';
import 'package:space_shooter/Explosion.dart';
import 'package:space_shooter/main.dart';

class Enemy extends SpriteAnimationComponent with
HasGameReference<SpaceShooterGame>,CollisionCallbacks{
  //@override
  void onColiisionStart(
    Set<Vector2>intersectionPoints,
    PositionComponent other,
  ){
    super.onCollisionStart(intersectionPoints, other);
    if(other is Bullet){
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
    }
  }
  
  Enemy({
    super.position,
  }):super(
    size:Vector2.all(enemySize),
    anchor: Anchor.center,
  );


  static const enemySize=50.0;

  @override
  Future<void>onLoad()async {
    add(RectangleHitbox());
    await super.onLoad();
    animation=await game.loadSpriteAnimation('enemy.png',
    SpriteAnimationData.sequenced(amount: 4, stepTime: .2, textureSize: Vector2.all(16)));


  }

  @override
  void update(double dt){
    super.update(dt
    );
    position.y+=dt*250;
    if(position.y>game.size.y){
      removeFromParent();
    }
  }
}