class Block_way{//方向からのブロック出力
  PVector blockplace;
  int dire;
  
  Block_way(){
    blockplace=new PVector(0,0);
    
  }

  void update(){
  if(block_kind==1 || block_kind==5 || block_kind==9){//上
    blockplace= new PVector(173,0);
    dire=1;
  }else if(block_kind==2 || block_kind==6 || block_kind==10){//右
    blockplace= new PVector(350,173);
    dire=2;
  }else if(block_kind==3 || block_kind==7 || block_kind==11){//左
    blockplace= new PVector(0,173);
    dire=3;
  }else if(block_kind==4 || block_kind==8 || block_kind==12){//下
    blockplace= new PVector(173,350);
    dire=4;
  }else {//なし
    blockplace= new PVector(50,0);
    dire=0;
  }
  if(block_kind==1 || block_kind==2 ||  block_kind==3 ||  block_kind==4 ){
    Blocksblue.add(new blockblue());
    //新青ブロック生成
  }
  if(block_kind==5 || block_kind==6 || block_kind==7 || block_kind==8 ){
    Blocksred.add(new blockred());
    //新赤ブロック生成
  }
  if(block_kind==9 || block_kind==10 || block_kind==11 || block_kind==12){
    Blocksyellow.add(new blockyellow());
  }
}
}

class blockblue {//青ブロック管理
  int block_dx=0, block_dy=0;
  int block_width=3, block_height=9;
  PVector blockplace;
  boolean blocklife;
  boolean blockside;

  blockblue() {
    //ブロックのベクトル
    blockplace= new PVector(block_way.blockplace.x, block_way.blockplace.y);
    if (block_kind==1) {//上
      block_dx=0;
      block_dy=3;
      blockside=false;
    } else if (block_kind==2) {//右
      block_dx=-3;
      block_dy=0;
      blockside=true;
    } else if (block_kind==3) {//左
      block_dx=3;
      block_dy=0;
      blockside=true;
    } else if (block_kind==4) {//下
      block_dx=0;
      block_dy=-3;
      blockside=false;
    }
  }

  void display() {
     fill(0, 0, 255);//ブロックの色
    if (blockside) {//ブロックの向き
      rect(blockplace.x, blockplace.y, block_height, block_width);
    } else {
      rect(blockplace.x, blockplace.y, block_width, block_height);
    }
  }
  
  void update() {
    blockplace.x += block_dx;//ブロックの移動
    blockplace.y += block_dy;
    colornum();
    if (blockplace.x<0 || blockplace.y<0 || blockplace.x>350 || blockplace.y>350) {
      blocklife=true;//ウィンドウの外縁判定
    }
    if (life>0) {
      if(blockjodge==1){
        switch(bar_pass) {//上青
        case 1:
          if (blockplace.y<152+3 && blockplace.y+9>152) {
            blocklife=true;
          }
          break;
        case 2://右青
          if (blockplace.x<195+3 && blockplace.x+9>195) {
            blocklife=true;
          }
          break;
        case 3://左青
          if (blockplace.x<150+3 && blockplace.x+9>150) {
            blocklife=true;
          }
          break;
        case 4://下青
          if (blockplace.y<192+3 && blockplace.y+9>192) {
            blocklife=true;
          }
          break;
        }
        if (blockplace.x+9>167 && blockplace.x<183 && blockplace.y+9>167 && blockplace.y<183) {
          blocklife=true;//ブロックの自機判定
          life--;
        } 
      }
    }
  }
}

class blockred {//赤ブロック管理
  int block_dx=0, block_dy=0;
  int block_width=3, block_height=9;
  PVector blockplace;
  boolean blocklife;
  boolean blockside;

  blockred() {
    //ブロックのベクトル
    blockplace= new PVector(block_way.blockplace.x, block_way.blockplace.y);
    if (block_kind==5) {//上
      block_dx=0;
      block_dy=3;
      blockside=false;
    } else if (block_kind==6) {//右
      block_dx=-3;
      block_dy=0;
      blockside=true;
    } else if (block_kind==7) {//左
      block_dx=3;
      block_dy=0;
      blockside=true;
    } else if (block_kind==8) {//下
      block_dx=0;
      block_dy=-3;
      blockside=false;
    }
  }

  void display() {
      fill(255, 0, 0);//ブロックの色
    if (blockside) {//ブロックの向き
      rect(blockplace.x, blockplace.y, block_height, block_width);
    } else {
      rect(blockplace.x, blockplace.y, block_width, block_height);
    }
  }
  void update() {
    blockplace.x += block_dx;//ブロックの移動
    blockplace.y += block_dy;
    colornum();
    if (blockplace.x<0 || blockplace.y<0 || blockplace.x>350 || blockplace.y>350) {
      blocklife=true;//ウィンドウの外縁判定
    }
    if (life>0) {
      if(blockjodge==2){
        switch(bar_pass) {
        case 1://上赤
          if (blockplace.y<152+3 && blockplace.y+9>152) {
            blocklife=true;
            life--;
          }
          break;
        case 2://右赤
          if (blockplace.x<195+3 && blockplace.x+9>195) {
            blocklife=true;
            life--;
          }
          break;
        case 3://左赤
          if (blockplace.x<150+3 && blockplace.x+9>150) {
            blocklife=true;
            life--;
          }
          break;
        case 4://下赤
          if (blockplace.y<192+3 && blockplace.y+9>192) {
            blocklife=true;
            life--;
          } 
          break;
        }
        if (blockplace.x+9>167 && blockplace.x<183 && blockplace.y+9>167 && blockplace.y<183) {
          blocklife=true;//ブロックの自機判定
        }
    }
    }
  }
}

class blockyellow {//黄色ブロック管理
  int block_dx=0, block_dy=0;
  int block_width=3, block_height=9;
  PVector blockplace;
  boolean blocklife;
  boolean blockside;

  blockyellow() {
    //ブロックのベクトル
    blockplace= new PVector(block_way.blockplace.x, block_way.blockplace.y);
    if (block_kind==9) {//上
      block_dx=0;
      block_dy=3;
      blockside=false;
    } else if (block_kind==10) {//右
      block_dx=-3;
      block_dy=0;
      blockside=true;
    } else if (block_kind==11) {//左
      block_dx=3;
      block_dy=0;
      blockside=true;
    } else if (block_kind==12) {//下
      block_dx=0;
      block_dy=-3;
      blockside=false;
    }
  }

  void display() {
    fill(220, 220, 0);//ブロックの色
    yellownum();
    if (blockplace.y>=75 && blockplace.y<=275 && blockplace.x>=75 && blockplace.x<=275) {
      if (yellowjodge[0] && block_dy==3) {//上を通ったらdyを逆に
        blockplace.y=350-blockplace.y;
        block_dy=-3;
      } else
        if (yellowjodge[1] && block_dx==-3) {//右を通ったらdxを逆に
          blockplace.x=350-blockplace.x;
          block_dx=3;
        } else
          if (yellowjodge[2] && block_dx==3) {//左を通ったらdxを逆に
            blockplace.x=350-blockplace.x;
            block_dx=-3;
          } else
            if (yellowjodge[3] && block_dy==-3) {//下を通ったらdyを逆に
              blockplace.y=350-blockplace.y;
              block_dy=3;
            }
    }
    if (blockside) {//ブロックの向き
      rect(blockplace.x, blockplace.y, block_height, block_width);//横長
    } else {
      rect(blockplace.x, blockplace.y, block_width, block_height);//縦長
    }
  }

  void update() {
    colornum();//ラケットの色判定
    yellownum();//黄色の通過判定
    if (blockplace.y>=75 && blockplace.y<=275 && blockplace.x>=75 && blockplace.x<=275) {
      if (yellowjodge[0] && block_dy==3) {
        blockplace.y=350-blockplace.y;//上を通った時座標を反対側に
        block_dy=-3;
        yellowjodge[0]=false;
      } else
        if (yellowjodge[1] && block_dx==-3) {//右を通った時座標を反対側に
          blockplace.x=350-blockplace.x;
          block_dx=3;
          yellowjodge[1]=false;
        } else
          if (yellowjodge[2] && block_dx==3) {//左を通った時座標を反対側に
            blockplace.x=350-blockplace.x;
            block_dx=-3;
            yellowjodge[2]=false;
          } else
            if (yellowjodge[3] && block_dy==-3) {//下を通った時座標を反対側に
              blockplace.y=350-blockplace.y;
              block_dy=3;
              yellowjodge[3]=false;
            }
    }
    blockplace.x += block_dx;//ブロックの移動
    blockplace.y += block_dy;
    if (blockplace.x<0 || blockplace.y<0 || blockplace.x>350 || blockplace.y>350) {
      blocklife=true;//ウィンドウの外縁判定
    }
    if (life>0) {
      if (blockjodge==3) {
        switch(bar_pass) {
        case 1://上黄
          if (blockplace.y<152+3 && blockplace.y+9>152) {
            blocklife=true;
            yellowjodge[0]=false;
          }
          break;
        case 2://右黄
          if (blockplace.x<195+3 && blockplace.x+9>195) {
            blocklife=true;
            yellowjodge[1]=false;
          }
          break;
        case 3://左黄
          if (blockplace.x<150+3 && blockplace.x+9>150) {
            blocklife=true;
            yellowjodge[2]=false;
          }
          break;
        case 4://下黄
          if (blockplace.y<192+3 && blockplace.y+9>192) {
            blocklife=true;
            yellowjodge[3]=false;
          } 
          break;
        }
        if (blockplace.x+9>167 && blockplace.x<183 && blockplace.y+9>167 && blockplace.y<183) {
          blocklife=true;//ブロックの自機判定
          life--;
        }
      }
    }
  }
}
