enum directionScroll { 
  U, D, L, R, M, UL, UR, DL, DR
};

class gameType
{

  int[][] grid;

  int xoff=50;
  int yoff=11;
  
  int lives = 3;

  float xoffs = 0;
  float yoffs = 0;

  PImage[] allSprites;

  spriteRefType spriteRef;
  playerType player;
  boolean grabbed=false;
  cowType[] cows;
  int cowCount=0;
  int cowsAlive;

  sharkType[] sharks;

  int sharkCount=0;
  PImage welcome;
  boolean startFlag = true;
  
  boolean pauseFlag = false;
  
  directionScroll scroll = directionScroll.M;
  float xoffScroll=1;
  float yoffScroll=1;
  final int curiousity=9;
  final int fear=4;

  final int scrollArea = 150;
  final float scrollSpeed = 8.5;

  void initSprites() {
    int i;
    allSprites = new PImage[40];
    for (i = 1; i < 40; i++) 
      allSprites[i-1] = loadImage( "sprites/" + i + ".png" );

    spriteRef = new spriteRefType();
    
    welcome = new PImage();
    welcome = loadImage("sprites/welcome.png");
  }

  void initGrid() {

    int i;

    grid = new int[161][161];

    for ( i=0; i<161; i++)
      grid[i] = new int[161];

    String[] lines;
    lines = loadStrings("game.dat");

    int y= 0;
    for ( String s : lines ) {
      for ( i = 0; i < s.length(); i++ ) {
        if ( s.charAt(i) == '.' ) {
          grid[i][y] = spriteRef.water;
        }
        if ( s.charAt(i) == 'G' ) {
          grid[i][y] = spriteRef.grass;
        }
        if ( s.charAt(i) == '1' ) {
          grid[i][y] = spriteRef.tree1;
        }
        if ( s.charAt(i) == '2' ) {
          grid[i][y] = spriteRef.tree2;
        }
        if ( s.charAt(i) == '3' ) {
          grid[i][y] = spriteRef.tree3;
        }
        if ( s.charAt(i) == '4' ) {
          grid[i][y] = spriteRef.tree4;
        }
        if ( s.charAt(i) == '5' ) {
          grid[i][y] = spriteRef.tree5;
        }
        if ( s.charAt(i) == '6' ) {
          grid[i][y] = spriteRef.tree6;
        }
        if ( s.charAt(i) == '7' ) {
          grid[i][y] = spriteRef.tree7;
        }
        if ( s.charAt(i) == '8' ) {
          grid[i][y] = spriteRef.tree8;
        }
        if ( s.charAt(i) == 'C' ) {
          grid[i][y] = spriteRef.grass;
          cows[cowCount] = new cowType( i, y);
          cowCount++;
        }
        if ( s.charAt(i) == 'S' ) {
          grid[i][y] = spriteRef.water;
          sharks[sharkCount] = new sharkType(i, y );
          sharkCount++;
        }
        if ( s.charAt(i) == 'P' ) {
          player.x = i;
          player.y = y;
          grid[i][y] = spriteRef.grass;
        }
      }
      y++;
    }

    cowsAlive = cowCount - 1;
  }

  void showGrid() {
    int x, y;
    int i;

    if (xoff <0)xoff=0;
    if (yoff <0)yoff=0;
    if (xoff >142)xoff=142;
    if (yoff >142)yoff=142;

    for (x=0; x<19; x++) {
      for (y=0; y<19; y++) {
        if ( grid[x+xoff][y+yoff] == spriteRef.water || grid[x+xoff][y+yoff] == spriteRef.shark )
          image( allSprites[spriteRef.water], (x * 50) -xoffs, (y * 50) -yoffs );
        else 
        image( allSprites[spriteRef.grass], (x * 50) -xoffs, (y * 50) -yoffs );

        image( allSprites[grid[x+xoff][y+yoff]], (x*50) -xoffs, (y*50) -yoffs);
      }
    }

    image( allSprites[player.anim], ((player.x-xoff ) * 50 - xoffs) + player.xoff, ((player.y-yoff) * 50) - yoffs +player.yoff);

    for ( i=0; i<cowCount; i++)
      if ( cows[i].alive )
        image( allSprites[cows[i].anim], ((cows[i].x-xoff ) * 50 - xoffs) + cows[i].xoff, ((cows[i].y-yoff) * 50) - yoffs +cows[i].yoff);

    for ( i=0; i<sharkCount; i++)
       image( allSprites[spriteRef.shark], ((sharks[i].x-xoff ) * 50 - xoffs) + sharks[i].xoff, ((sharks[i].y-yoff) * 50) - yoffs +sharks[i].yoff);
  }

  void doMouse() {

    scroll = directionScroll.M;

    if ( mouseX < scrollArea )
      scroll = directionScroll.L;
    else if ( mouseY < scrollArea )
      scroll = directionScroll.U;
    else if ( mouseX > width - scrollArea )
      scroll = directionScroll.R;
    else if ( mouseY > height - scrollArea )
      scroll = directionScroll.D;

    if ( mouseX < scrollArea && mouseY < scrollArea)
      scroll = directionScroll.UL;
    else if ( mouseX > width - scrollArea  &&  mouseY < scrollArea)
      scroll = directionScroll.UR;
    else if ( mouseX < scrollArea && mouseY > height  - scrollArea)
      scroll = directionScroll.DL;
    else if ( mouseX > width - scrollArea  &&  mouseY > height - scrollArea)
      scroll = directionScroll.DR;
    //    println(scroll);
  }
  void doScroll() {

    player.stop();

    switch( scroll ) {
    case U:
      yoffs-=scrollSpeed;
      break;
    case D:
      yoffs+=scrollSpeed;
      break;
    case L:
      xoffs-=scrollSpeed;
      break;
    case R:
      xoffs+=scrollSpeed;
      break;
    case UL:
      yoffs-=scrollSpeed;
      xoffs-=scrollSpeed;
      break;
    case UR:
      yoffs-=scrollSpeed;
      xoffs+=scrollSpeed;
      break;
    case DL:
      yoffs+=scrollSpeed;
      xoffs-=scrollSpeed;
      break;
    case DR:
      xoffs+=scrollSpeed;
      yoffs+=scrollSpeed;
      break;

    default:
      break;
    }

    if (xoffs > 50 ) {
      xoff++;
      xoffs = 0;
    }
    if (yoffs > 50 ) {
      yoff++;
      yoffs = 0;
    }
    if (xoffs < 0 ) {
      xoff--;
      xoffs = 50;
    }
    if (yoffs < 0 ) {
      yoff--;
      yoffs = 50;
    }

    if (xoff < 0 )
      xoff = 0;
    if (yoff < 0 )
      yoff = 0;
    if (xoff > 140 )
      xoff = 140;
    if (yoff >140  )
      yoff = 140;
  }

  void cowCycle() {
    int i;
    for (i=0; i<cowCount; i++) {

      if (cows[i].alive ) {
        cows[i].curious = false;
        cows[i].afraid = false;
        cows[i].d = directionCow.M;

        if ( player.x > cows[i].x - curiousity  && player.x < cows[i].x - fear  && player.x < cows[i].x && cows[i].y > player.y - fear && cows[i].y < player.y + fear) {
          cows[i].curious = true;
          cows[i].afraid = false;
          cows[i].d = directionCow.L;
        } 
        if ( player.x > cows[i].x - fear   &&  player.x < cows[i].x && cows[i].y > player.y - fear && cows[i].y < player.y + fear ) {
          cows[i].curious = false;
          cows[i].afraid = true;
          cows[i].d = directionCow.R;
        }
        if ( player.x < cows[i].x + curiousity  && player.x > cows[i].x && cows[i].y > player.y - fear && cows[i].y < player.y + fear) {
          cows[i].curious = true;
          cows[i].afraid = false;
          cows[i].d = directionCow.L;
        } 
        if ( player.x > cows[i].x + fear   &&  player.x > cows[i].x && cows[i].y > player.y - fear && cows[i].y < player.y + fear ) {
          cows[i].curious = false;
          cows[i].afraid = true;
          cows[i].d = directionCow.R;
        }
        if ( player.y > cows[i].y - curiousity  && player.y < cows[i].y - fear  && player.y < cows[i].y && cows[i].x > player.x - fear && cows[i].x < player.x + fear) {
          cows[i].curious = true;
          cows[i].afraid = false;
          cows[i].d = directionCow.U;
        } 
        if ( player.y > cows[i].y - fear   &&  player.y < cows[i].y && cows[i].x > player.x - fear && cows[i].x < player.x + fear ) {
          cows[i].curious = false;
          cows[i].afraid = true;
          cows[i].d = directionCow.D;
        }
        if ( player.y < cows[i].y + curiousity  && player.y > cows[i].y && cows[i].x > player.x - fear && cows[i].x < player.x + fear) {
          cows[i].curious = true;
          cows[i].afraid = false;
          cows[i].d = directionCow.U;
        } 
        if ( player.y > cows[i].y + fear   &&  player.y > cows[i].y && cows[i].x > player.x - fear && cows[i].x < player.x + fear ) {
          cows[i].curious = false;
          cows[i].afraid = true;
          cows[i].d = directionCow.D;
        }

        if ( grid[cows[i].x][cows[i].y] == spriteRef.water || grid[cows[i].x][cows[i].y] == spriteRef.shark ) {
          cows[i].alive = false;
          cowsAlive--;
          println( " " + cowsAlive );
        }
      }
      cows[i].move();
    }
  }
  void sharkCycle() {
    int i;
    for (i=0; i<sharkCount; i++) {
      if( grid[player.x][player.y] == spriteRef.water ) {
        if( player.x < sharks[i].x)
          sharks[i].d = directionShark.L;
        if( player.x > sharks[i].x)
          sharks[i].d = directionShark.R;
        if( player.y < sharks[i].y)
          sharks[i].d = directionShark.U;
        if( player.y > sharks[i].y)
          sharks[i].d = directionShark.D;
      }
      sharks[i].move();
    }
  }
  void cycle() {
    player.move();
    if ( scroll == directionScroll.M && !grabbed) {      
      if ( player.x - xoff < 2) {
       if( player.x - xoff < 1 )
         xoffs-=scrollSpeed;
       else
         xoffs-=player.playerSpeed;
      }
      if ( player.y - yoff < 2 ) {
       if( player.y - yoff < 1 )
         yoffs-=scrollSpeed;
       else
         yoffs-=player.playerSpeed;
      }
      if ( player.x - xoff > 12 ) {
        xoffs+=player.playerSpeed;
      }
      if ( player.y - yoff > 12 ) {
        yoffs+=player.playerSpeed;
      }
    }
    
    if (xoffs > 50 ) {
      xoff++;
      xoffs = 0;
    }
    if (yoffs > 50 ) {
      yoff++;
      yoffs = 0;
    }
    if (xoffs < 0 ) {
      xoff--;
      xoffs = 50;
    }
    if (yoffs < 0 ) {
      yoff--;
      yoffs = 50;
    }

    if (xoff < 0 )
      xoff = 0;
    if (yoff < 0 )
      yoff = 0;
    if (xoff > 140 )
      xoff = 140;
    if (yoff >140  )
      yoff = 140;
    
    cowCycle();
    sharkCycle();
  }


  gameType() {
    player = new playerType();
    cows = new cowType[500];
    sharks = new sharkType[500];
  }
}