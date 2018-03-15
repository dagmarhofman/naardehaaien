
class spriteRefType {
  final int water = 0;
  final int grass = 1;
  final int shark = 2;
  final int tree1 = 3;
  final int tree2 = 4;
  final int tree3 = 5;
  final int tree4 = 6;
  final int tree5 = 7;
  final int tree6 = 8;
  final int tree7 = 9;
  final int tree8 = 10;
  final int playerUp1 = 11;
  final int playerUp2 = 12;
  final int playerUp3 = 13;
  final int playerRight1 = 14;
  final int playerRight2 = 15;
  final int playerRight3 = 16;
  final int playerLeft1 = 17;
  final int playerLeft2 = 18;
  final int playerLeft3 = 19;
  final int playerDown1 = 20;
  final int playerDown2 = 21;
  final int playerDown3 = 22;
  final int cowUp1 = 23;
  final int cowUp2 = 24;
  final int cowUp3 = 25;
  final int cowUp4 = 26;
  final int cowDown1 = 27;
  final int cowDown2 = 28;
  final int cowDown3 = 29;
  final int cowDown4 = 30;
  final int cowLeft1 = 31;
  final int cowLeft2 = 32;
  final int cowLeft3 = 33;
  final int cowLeft4 = 34;
  final int cowRight1 = 35;
  final int cowRight2 = 36;
  final int cowRight3 = 37;
  final int cowRight4 = 38;
}

gameType drown;



void setup()
{
  size(800, 800);
  drown = new gameType();
  drown.initSprites();
  drown.initGrid();
}

void draw() 
{ 

  if ( drown.startFlag ) {
    image( drown.welcome, 0, 0 );
    textSize(50);
    fill(0, 255, 0);
    text(" Naar de haaien ", 75, 75 );
    return;
  }

  if ( drown.pauseFlag ) {
    background(0, 0, 0);
    image( drown.allSprites[drown.spriteRef.playerDown1], 100, 100);
    image( drown.allSprites[drown.spriteRef.cowLeft1], 100, 200);
    fill(255, 255, 255);
    textSize(35);
    text(" " + drown.cowsAlive, 190, 240);
    text(" " + drown.lives, 190, 135);
    return;
  }

  if ( mousePressed )
    drown.doScroll();

  drown.cycle();

  drown.showGrid();
}

void keyPressed()
{
  drown.startFlag = false;
  drown.scroll = directionScroll.M;

  if ( key == 'p' )
    drown.pauseFlag = true;
  else
    drown.pauseFlag = false;

  if ( key == ' ') {
    drown.player.stop();
    drown.player.d = directionPlayer.M;
  }
  if ( key == 'i' ) {
    if ( drown.player.d == directionPlayer.U ) 
      drown.player.moving = true;
    else
      drown.player.moving = false;
    drown.player.d = directionPlayer.U;
  }
  if ( key == 'j' ) {
    if ( drown.player.d == directionPlayer.L ) 
      drown.player.moving = true;
    else
      drown.player.moving = false;
    drown.player.d = directionPlayer.L;
  }
  if ( key == 'k' ) {
    if ( drown.player.d == directionPlayer.D ) 
      drown.player.moving = true;
    else
      drown.player.moving = false;
    drown.player.d = directionPlayer.D;
  }
  if ( key == 'l' ) {
    if ( drown.player.d == directionPlayer.R ) 
      drown.player.moving = true;
    else
      drown.player.moving = false;
    drown.player.d = directionPlayer.R;
  }
}

void mouseMoved()
{
  drown.doMouse();
}
void mousePressed()
{
  if ( drown.scroll == directionScroll.M )
    cursor(MOVE);
  else
    cursor(HAND);

  drown.doScroll();
}
void mouseReleased()
{

  cursor(ARROW);
  drown.grabbed = false;
}

int xoffm;
int yoffm;

void mouseDragged()
{
  cursor(MOVE);

  if ( !drown.grabbed ) {
    xoffm = (int) (mouseX / 50);
    yoffm = (int) (mouseY / 50);
    drown.grabbed = true;
  }

  println( xoffm + "  "+ yoffm );

  if ( mouseX > xoffm ) {
    
    drown.xoffs = (mouseX % 50)  -1;
    drown.xoffs = 50 - drown.xoffs;
    
    if( drown.xoffs > 50 ){
       drown.xoffs = 0;
       drown.xoff++;
       
    } else if( drown.xoffs < 0 ){
       drown.xoffs = 50;
       drown.xoff--;
       
    }
/*    
    drown.xoff = drown.xoff - (int) (mouseX / 50) + xoffm;
    xoffm = (int) (mouseX / 50) ;
    
    drown.xoffs = (mouseX / 50) - xoffm;
*/
    
  }
}