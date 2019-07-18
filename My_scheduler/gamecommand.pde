color blockcolor[]={0,0,0,0,0,0,0,0};
int blockjodge;

//色識別で判定管理
void colornum (){
 blockcolor[0] = get(240, 311);//flont上
 blockcolor[1] = get(240, 316);//flont下
 blockcolor[2] = get(264, 335);//right右
 blockcolor[3] = get(259, 335);//right左
 blockcolor[4] = get(214, 335);//left左
 blockcolor[5] = get(219, 335);//left右
 blockcolor[6] = get(240, 359);//back下
 blockcolor[7] = get(240, 354);//back上
 for(int i=0 ; i<8 ; i++){
      if(red(blockcolor[i])==0 && blue(blockcolor[i])==255){
      blockjodge=1;//青判定
    } if(red(blockcolor[i])==255 && blue(blockcolor[i])==0){
      blockjodge=2;//赤判定
    } if(red(blockcolor[i])==220 && green(blockcolor[i])==220){
      blockjodge=3;//黄判定
    }
  }
}

color yellowcolor[]={0,0,0,0};
boolean yellowjodge[]={false,false,false,false};
//黄色識別で方向転換管理
void yellownum(){//黄色の通過判定
  yellowcolor[0] = get(240, 210);//上
  yellowcolor[1] = get(365, 335);//右
  yellowcolor[2] = get(115, 335);//左
  yellowcolor[3] = get(240, 460);//下
  for(int j=0; j<4; j++){
    if(red(yellowcolor[j])==220 && green(yellowcolor[j])==220){
      yellowjodge[j]=true;//黄色を通過したらtrueに
    }
  }
}

void viewdiffi(int x){
if (time<x && time>=x*5/6) {//level1
      textSize(30);
      fill(0, 0, 0);
      text("1", 55, 50);
    } else if (time<=x*5/6 && time>x*4/6) {//level2
      textSize(30);
      fill(0, 0, 250);
      text("2", 55, 50);
    } else if (time<=x*4/6 && time>x*3/6) {//level3
      textSize(30);
      fill(0, 250, 0);
      text("3", 55, 50);
    } else if (time<=x*3/6 && time>x*2/6) {//level4
      textSize(30);
      fill(250, 0, 250);
      text("4", 55, 50);
    } else if (time<=x*2/6 && time>x/6) {//level5
      textSize(30);
      fill(100, 250, 250);
      text("5", 55, 50);
    } else if (time<=x/6 && time>0) {//level6
      textSize(30);
      fill(250, 0, 0);
      text("6", 55, 50);
    }
}

boolean keyflont=false;
boolean keyright=false;
boolean keyleft=false;
boolean keyback=false;

boolean blueup=false;
boolean bluedown=false;
boolean redup=false;
boolean reddown=false;
boolean yellowup=false;
boolean yellowdown=false;
boolean timeup=false;
boolean timedown=false;
boolean diffiup=false;
boolean diffidown=false;

void keyPressed(){//キーの押し判定
  if(key=='w'){//上
    keyflont=true;
  }if(key=='d'){//右
    keyright=true;
  }if(key=='a'){//左
    keyleft=true;
  }if(key=='s'){//下
    keyback=true;
  }
  
  if(key=='q'){//青＋
    blueup=true;
  }if(key=='a'){//青ー
    bluedown=true;
  }if(key=='w'){//赤＋
    redup=true;
  }if(key=='s'){//赤－
    reddown=true;
  }if(key=='e'){//黄色＋
    yellowup=true;
  }if(key=='d'){//黄色－
    yellowdown=true;
  }if(key=='r'){//時間＋
    timeup=true;
  }if(key=='f'){//時間ー
    timedown=true;
  }if(key=='t'){//難易度＋
    diffiup=true;
  }if(key=='g'){//難易度－
    diffidown=true;
  }
}

void keyReleased(){//キーの離し判定
  if(key=='w'){//上
    keyflont=false;
  }if(key=='d'){//右
    keyright=false;
  }if(key=='a'){//左
    keyleft=false;
  }if(key=='s'){//下
    keyback=false;
  }
}

int bar_x, bar_y, bar_width, bar_height;
int bar_pass;

void bar(){//ラケット判定
  if(keyflont){//上
    bar_x=165;
    bar_y=152;
    bar_width=20;
    bar_height=3;

    bar_pass=1;
  }
  if(keyright){//右
    bar_x=195;
    bar_y=165;
    bar_width=3;
    bar_height=20;

    bar_pass=2;  
  }
  if(keyleft){//左
    bar_x=150;
    bar_y=165;
    bar_width=3;
    bar_height=20;

    bar_pass=3;  
  }
  if(keyback){//下
    bar_x=165;
    bar_y=195;
    bar_width=20;
    bar_height=3;

    bar_pass=4;  
  }
    fill(0);
    rect(bar_x,bar_y,bar_width,bar_height);
}
//難易度管理
int block_kind;
int n;
int[][] diffibox={{60,50,40,30,25,20,60},{50,40,30,25,20,15,60},{50,40,30,20,15,10,60}};
void randomway(){
  if(grodiffi==1){//easy
    if(time>120 && time<=100){
    difficult=diffibox[0][0];//level1
   }else if(time<=100 && time>80){
    difficult=diffibox[0][1];//level2
   }else if(time<=80 && time>60){
    difficult=diffibox[0][2];//level3
   }else if(time<=60 && time>40){
    difficult=diffibox[0][3];//level4
   }else if(time<=40 && time>20){
    difficult=diffibox[0][4];//level5
   }else if(time<=20 && time>0){
    difficult=diffibox[0][5];//level6
   }else{
    difficult=diffibox[0][6];
    //難易度設定
   }
  if(frameCount%difficult==0){
   n=int(random(1,101));
   if(n>=1 && n<=13){//青上
     block_kind=1;
   }else if(n>13 && n<=26){//青右
     block_kind=2;
   }else if(n>26 && n<=39){//青左
     block_kind=3;
   }else if(n>39 && n<=52){//青下
     block_kind=4;
   }else if(n>52 && n<=62){//赤上
     block_kind=5;
   }else if(n>62 && n<=72){//赤右
     block_kind=6;
   }else if(n>72 && n<=82){//赤左
     block_kind=7;
   }else if(n>82 && n<=92){//赤下
     block_kind=8;
   }else if(n>92 && n<=94){//黄上
     block_kind=9;
   }else if(n>94 && n<=96){//黄右
     block_kind=10;
   }else if(n>96 && n<=98){//黄左
     block_kind=11;
   }else if(n>98 && n<=100){//黄下
     block_kind=12;
   }//ブロック方向、色のランダム
  }
  }else if(grodiffi==2){//normal
    if(time>120 && time<=100){
    difficult=diffibox[1][0];//level1
   }else if(time<=100 && time>80){
    difficult=diffibox[1][1];//level2
   }else if(time<=80 && time>60){
    difficult=diffibox[1][2];//level3
   }else if(time<=60 && time>40){
    difficult=diffibox[1][3];//level4
   }else if(time<=40 && time>20){
    difficult=diffibox[1][4];//level5
   }else if(time<=20 && time>0){
    difficult=diffibox[1][5];//level6
   }else{
    difficult=diffibox[1][6];
    //難易度設定
   }
  if(frameCount%difficult==0){
   n=int(random(1,101));
   if(n>=1 && n<=14){//青上
     block_kind=1;
   }else if(n>14 && n<=28){//青右
     block_kind=2;
   }else if(n>28 && n<=42){//青左
     block_kind=3;
   }else if(n>42 && n<=56){//青下
     block_kind=4;
   }else if(n>56 && n<=63){//赤上
     block_kind=5;
   }else if(n>63 && n<=70){//赤右
     block_kind=6;
   }else if(n>70 && n<=77){//赤左
     block_kind=7;
   }else if(n>77 && n<=84){//赤下
     block_kind=8;
   }else if(n>84 && n<=88){//黄上
     block_kind=9;
   }else if(n>88 && n<=92){//黄右
     block_kind=10;
   }else if(n>92 && n<=96){//黄左
     block_kind=11;
   }else if(n>96 && n<=100){//黄下
     block_kind=12;
   }//ブロック方向、色のランダム
  }
  }else if(grodiffi==3){//hard
    if(time>120 && time<=100){
    difficult=diffibox[2][0];//level1
   }else if(time<=100 && time>80){
    difficult=diffibox[2][1];//level2
   }else if(time<=80 && time>60){
    difficult=diffibox[2][2];//level3
   }else if(time<=60 && time>40){
    difficult=diffibox[2][3];//level4
   }else if(time<=40 && time>20){
    difficult=diffibox[2][4];//level5
   }else if(time<=20 && time>0){
    difficult=diffibox[2][5];//level6
   }else{
    difficult=diffibox[2][6];
    //難易度設定
   }
  if(frameCount%difficult==0){
   n=int(random(1,101));
   if(n>=1 && n<=16){//青上
     block_kind=1;
   }else if(n>16 && n<=32){//青右
     block_kind=2;
   }else if(n>32 && n<=48){//青左
     block_kind=3;
   }else if(n>48 && n<=64){//青下
     block_kind=4;
   }else if(n>64 && n<=67){//赤上
     block_kind=5;
   }else if(n>67 && n<=70){//赤右
     block_kind=6;
   }else if(n>70 && n<=73){//赤左
     block_kind=7;
   }else if(n>73 && n<=76){//赤下
     block_kind=8;
   }else if(n>76 && n<=82){//黄上
     block_kind=9;
   }else if(n>82 && n<=88){//黄右
     block_kind=10;
   }else if(n>88 && n<=94){//黄左
     block_kind=11;
   }else if(n>94 && n<=100){//黄下
     block_kind=12;
   }//ブロック方向、色のランダム
  }
  }
  else if(grodiffi==4){//demo
    if(time>=30 && time<25){
    difficult=diffibox[1][0];//level1
   }else if(time<=25 && time>20){
    difficult=diffibox[1][1];//level2
   }else if(time<=20 && time>15){
    difficult=diffibox[1][2];//level3
   }else if(time<=15 && time>10){
    difficult=diffibox[1][3];//level4
   }else if(time<=10 && time>5){
    difficult=diffibox[1][4];//level5
   }else if(time<=5 && time>0){
    difficult=diffibox[1][5];//level6
   }else{
    difficult=diffibox[1][6];
    //難易度設定
   }
  if(frameCount%difficult==0){
   n=int(random(1,101));
   if(n>=1 && n<=14){//青上
     block_kind=1;
   }else if(n>14 && n<=28){//青右
     block_kind=2;
   }else if(n>28 && n<=42){//青左
     block_kind=3;
   }else if(n>42 && n<=56){//青下
     block_kind=4;
   }else if(n>56 && n<=63){//赤上
     block_kind=5;
   }else if(n>63 && n<=70){//赤右
     block_kind=6;
   }else if(n>70 && n<=77){//赤左
     block_kind=7;
   }else if(n>77 && n<=84){//赤下
     block_kind=8;
   }else if(n>84 && n<=88){//黄上
     block_kind=9;
   }else if(n>88 && n<=92){//黄右
     block_kind=10;
   }else if(n>92 && n<=96){//黄左
     block_kind=11;
   }else if(n>96 && n<=100){//黄下
     block_kind=12;
   }//ブロック方向、色のランダム
  }
  }
  else if(grodiffi==5){
    if(time>=timeway && time<timeway*5/6){
    difficult=diffibox[diffiway][0];//level1
   }else if(time<=timeway*5/6 && time>timeway*4/6){
    difficult=diffibox[diffiway][1];//level2
   }else if(time<=timeway*4/6 && time>timeway*3/6){
    difficult=diffibox[diffiway][2];//level3
   }else if(time<=timeway*3/6 && time>timeway*2/6){
    difficult=diffibox[diffiway][3];//level4
   }else if(time<=timeway*2/6 && time>timeway/6){
    difficult=diffibox[diffiway][4];//level5
   }else if(time<=timeway/6 && time>0){
    difficult=diffibox[diffiway][5];//level6
   }else{
    difficult=diffibox[diffiway][6];
    //難易度設定
   }
    if(frameCount%difficult==0){
   n=int(random(1,101));
   if(n>=1 && n<=blueway/4){//青上
     block_kind=1;
   }else if(n>blueway/4 && n<=blueway*2/4){//青右
     block_kind=2;
   }else if(n>blueway*2/4 && n<=blueway*3/4){//青左
     block_kind=3;
   }else if(n>blueway*3/4 && n<=blueway){//青下
     block_kind=4;
   }else if(n>blueway && n<=blueway+redway/4){//赤上
     block_kind=5;
   }else if(n>blueway+redway/4 && n<=blueway+redway*2/4){//赤右
     block_kind=6;
   }else if(n>blueway+redway*2/4 && n<=blueway+redway*3/4){//赤左
     block_kind=7;
   }else if(n>blueway+redway*3/4 && n<=blueway+redway){//赤下
     block_kind=8;
   }else if(n>blueway+redway && n<=blueway+redway+yellowway/4){//黄上
     block_kind=9;
   }else if(n>blueway+redway+yellowway/4 && n<=blueway+redway+yellowway*2/4){//黄右
     block_kind=10;
   }else if(n>blueway+redway+yellowway*2/4 && n<=blueway+redway+yellowway*3/4){//黄左
     block_kind=11;
   }else if(n>blueway+redway+yellowway*3/4 && n<=blueway+redway+yellowway){//黄下
     block_kind=12;
   }//ブロック方向、色のランダム
  }
  }
}
