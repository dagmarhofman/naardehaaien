enum directionShark { 
  U, D, L, R, M
};

class sharkType
{
  directionShark d = directionShark.U;
  boolean moving = false;
  int x;
  int y;
  // ten opzichte van grid point
  float xoff;
  float yoff;
  final float speed = 1.5;
  final float sharkSpeed = 2.5;
  spriteRefType spriteRef;
  int anim;

  boolean agressive;

  void move() {
    switch( d ) {
    case U:
      yoff-=sharkSpeed;
      break;
    case D:
      yoff +=sharkSpeed;
      break;
    case L:
      xoff-=sharkSpeed;
      break;
    case R:
      xoff +=sharkSpeed;
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
  sharkType( int x, int y ) {
    this.x =x;
    this.y =y;
   }
}