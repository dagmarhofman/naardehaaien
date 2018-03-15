enum directionCow { 
  U, D, L, R, M
};

class cowType
{
  directionCow d = directionCow.U;
  boolean moving = false;
  int x;
  int y;
  // ten opzichte van grid point
  float xoff;
  float yoff;
  final float speed = 1.5;
  final float cowSpeed = 1;
  spriteRefType spriteRef;

  boolean curious;
  boolean afraid;

  boolean alive;

  int anim;
  int animOff = 0;
  float animSpeed = 5;


  void move() {
    if ( curious || afraid ) {
      switch( d ) {
      case U:
        yoff-=cowSpeed;
        animOff+= animSpeed;
        if ( animOff > 50 ) {
          if ( anim == spriteRef.cowUp1 )
            anim = spriteRef.cowUp2;
          else if (anim == spriteRef.cowUp2 )
            anim = spriteRef.cowUp3;
          else if (anim == spriteRef.cowUp3 )
            anim = spriteRef.cowUp4;
          else if (anim == spriteRef.cowUp4 )
            anim = spriteRef.cowUp1;
          else 
          anim = spriteRef.cowUp1;
          animOff = 0;
        }
        break;
      case D:
        yoff +=cowSpeed;
        animOff+= animSpeed;

        if ( animOff > 50 ) {
          if ( anim == spriteRef.cowDown1 )
            anim = spriteRef.cowDown2;
          else if (anim == spriteRef.cowDown2 )
            anim = spriteRef.cowDown3;
          else if (anim == spriteRef.cowDown3 )
            anim = spriteRef.cowDown4;
          else if (anim == spriteRef.cowDown4 )
            anim = spriteRef.cowDown1;
          else 
          anim =  spriteRef.cowDown1;
          animOff = 0;
        }
        break;
      case L:
        xoff-=cowSpeed;
        animOff+= animSpeed;
        if ( animOff > 50 ) {
          if ( anim == spriteRef.cowLeft1 )
            anim = spriteRef.cowLeft2;
          else if (anim == spriteRef.cowLeft2 )
            anim = spriteRef.cowLeft3;
          else if (anim == spriteRef.cowLeft4 )
            anim = spriteRef.cowLeft3;
          else if (anim == spriteRef.cowLeft4 )
            anim = spriteRef.cowLeft1;
          else
            anim = spriteRef.cowLeft1;
          animOff = 0;
        }
        break;
      case R:
        xoff +=cowSpeed;
        animOff+= animSpeed;
        if ( animOff > 50 ) {
          if ( anim == spriteRef.cowRight1 )
            anim = spriteRef.cowRight2;
          else if (anim == spriteRef.cowRight2 )
            anim = spriteRef.cowRight3;
          else if (anim == spriteRef.cowRight3 )
            anim = spriteRef.cowRight4;
          else if (anim == spriteRef.cowRight4 )
            anim = spriteRef.cowRight1;
          else
            anim = spriteRef.cowRight1;
          animOff = 0;
        }
        break;
      case M:
        break;
      }

      if ( xoff < 0 ) {
        x--;
        xoff = 50;
      }
      if ( yoff < 0 ) {
        y--;
        yoff = 50;
      }
      if ( xoff > 50 ) {
        x++;
        xoff = 0;
      }
      if ( yoff > 50 ) {
        y++;
        yoff = 0;
      }
    }
  }

  cowType( int x, int y )
  {

    this.x = x;
    this.y = y;
    spriteRef = new spriteRefType();
    anim = spriteRef.cowUp1;
    curious = false;
    afraid = false;
    alive = true;
  }
}