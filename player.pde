enum directionPlayer { 
  U, D, L, R, M
};

class playerType
{
  directionPlayer d = directionPlayer.U;
  boolean moving = false;
  int x;
  int y;
  // ten opzichte van grid point
  float xoff;
  float yoff;
  final float speed = 0.5;
  final float playerSpeed = 1.5;
  spriteRefType spriteRef;

  int anim;
  int animOff = 0;
  float animSpeed = 5;

  void stop() {
    moving = false;
  }

  void doScroll()
  {
    switch( d ) {
    case U:
      yoff+=speed;
      break;
    case D:
      yoff-=speed;
      break;
    case L:
      xoff+=speed;
      break;
    case R:
      xoff-=speed;
      break;
    case M:
      break;
    default:
      break;
    }

    if ( xoff < 0) {
      xoff = 50; 
      x++;
    }
    if ( yoff < 0) {
      yoff = 50; 
      y++;
    }
    if ( xoff > 50) {
      xoff = 0; 
      x--;
    }
    if ( yoff > 50) {
      yoff = 0; 
      y--;
    }

    if ( x < 0 ) x =0 ;
    if ( y < 0 ) y =0 ;
    if ( x > 144) x = 144 ;
    if ( y > 144) y = 144 ;
  }

  void move() {
    
    switch( d ) {
    case U:
      yoff-=playerSpeed;
      animOff+= animSpeed;
      if ( animOff > 50 ) {
        if ( anim == spriteRef.playerUp1 )
          anim = spriteRef.playerUp2;
        else if (anim == spriteRef.playerUp2 )
          anim = spriteRef.playerUp3;
        else if (anim == spriteRef.playerUp3 )
          anim = spriteRef.playerUp1;
        else 
        anim = spriteRef.playerUp1;
        animOff = 0;
      }
      break;
    case D:
      yoff +=playerSpeed;
      animOff+= animSpeed;

      if ( animOff > 50 ) {
        if ( anim == spriteRef.playerDown1 )
          anim = spriteRef.playerDown2;
        else if (anim == spriteRef.playerDown2 )
          anim = spriteRef.playerDown3;
        else if (anim == spriteRef.playerDown3 )
          anim = spriteRef.playerDown1;
        else 
        anim =  spriteRef.playerDown1;
        animOff = 0;
      }
      break;
    case L:
      xoff-=playerSpeed;
      animOff+= animSpeed;
      if ( animOff > 50 ) {
        if ( anim == spriteRef.playerLeft1 )
          anim = spriteRef.playerLeft2;
        else if (anim == spriteRef.playerLeft2 )
          anim = spriteRef.playerLeft3;
        else if (anim == spriteRef.playerLeft3 )
          anim = spriteRef.playerLeft1;
        else
          anim = spriteRef.playerLeft1;
        animOff = 0;
      }
      break;
    case R:
      xoff +=playerSpeed;
      animOff+= animSpeed;
      if ( animOff > 50 ) {
        if ( anim == spriteRef.playerRight1 )
          anim = spriteRef.playerRight2;
        else if (anim == spriteRef.playerRight2 )
          anim = spriteRef.playerRight3;
        else if (anim == spriteRef.playerRight3 )
          anim = spriteRef.playerRight1;
        else
          anim = spriteRef.playerRight1;
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

  playerType() {
    spriteRef = new spriteRefType();
    anim = spriteRef.playerUp1;
  }
}