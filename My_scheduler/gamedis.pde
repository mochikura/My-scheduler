boolean isgameover=false;

PImage mine, overpic, clearpic;//画像
int difficult;//モード内難易度

int gamemode=0;
Block_way block_way;
ArrayList<blockblue> Blocksblue;//青ブロック
ArrayList<blockred> Blocksred;//赤ブロック
ArrayList<blockyellow> Blocksyellow;//黄ブロック
int grodiffi;//全体難易度

int time=120;//時間
int life=1;//ライフ


void gamedis(){
  noTint();
  makeframe(60,155,360,360);
  mine.resize(16,16);
  image(mine, 232, 327);
  pushMatrix();//元ゲームのブロック崩しからの座標の軸ずらし
  translate(65,160);
  switch(gamemode) {//変数  
  case 0://元ゲームのsetup対応
    gameload();
    break;
    
  case 1://開始画面
    gamestart();
    break;

  case 2://難易度選択
    gameset();
    break;

  case 3://ゲーム本体
    gameplay();
    break;
    
  case 4://難易度選択（自由に）
    gameserect();
    break;
  }
  popMatrix();//座標軸戻る
  backplace(580,"メニューに戻る",998);
}

void gamestart(){
  textSize(15);
  fill(0);
  text("normal block", 150, 35);//ブロックの種類提示
  text("opposite block", 150, 70);
  text("bad block", 150, 105);

  rect(165, 153, 20, 3);//前操作
  text("W", 172, 147);

  rect(150, 165, 3, 20);//左操作
  text("A", 137, 180);

  rect(195, 165, 3, 20);//右操作
  text("D", 205, 180);

  rect(165, 192, 20, 3);//後操作
  text("S", 172, 215);

  fill(0, 0, 255);//青ブロック
  rect(100, 15, 37, 25);

  fill(255, 255, 0);//黄ブロック
  rect(100, 50, 37, 25);

  fill(255, 0, 0);//赤ブロック
  rect(100, 85, 37, 25);

  textSize(25);
  fill(0);
  text("Press to the 'R' key", 50, 250);
  if (keyPressed==true && key=='r') {
    gamemode++;
    //ゲーム開始
  }
}


void gameload(){
  time=120;//初期値
  life=1;
  mine=loadImage("EDGE2.png");//自機画像
  clearpic=loadImage("nc193208.png");
  overpic=loadImage("nc21429.png");
  block_way=new Block_way();//ブロック方向
  Blocksblue=new ArrayList<blockblue>();//ブロック動作
  Blocksred=new ArrayList<blockred>();
  Blocksyellow=new ArrayList<blockyellow>();
  gamemode++;
}


void gameset() {//難易度選択
  for (int i=0; i<3; i++) {//難易度表示時の簡略表示
    fill(255);
    rect(12+i*112, 65, 100, 150);//枠
    fill(0, 0, 255);
    rect(22+i*112, 105, 45, 20);//blue
    fill(255, 0, 0);
    rect(22+i*112, 130, 45, 20);//red
    fill(220, 220, 0);
    rect(22+i*112, 155, 45, 20);//yellow
    fill(0);
    textSize(15);
    text("Time:120", 32+i*112, 192);//時間
  }
  fill(255);
  rect(40, 230, 265, 70);//デモ枠
  fill(0);
  textSize(35);
  text("Demo Mode", 85, 265);
  textSize(15);
  text("difficult:normal Time:60 Press 'X'", 52, 290);

  fill(0);
  textSize(41);
  text("Serect difficult", 10, 50);

  textSize(40);//難易度表示
  text("easy", 22, 100);
  text("hard", 247, 100);
  textSize(32);
  text("normal", 130, 100);

  textSize(15);//キー表示
  text("press 'A'", 32, 210);
  text("press 'S'", 145, 210);
  text("press 'D'", 257, 210);

  text("52%", 80, 120);//青比率
  text("56%", 192, 120);
  text("64%", 305, 120);

  text("40%", 80, 145);//赤比率
  text("28%", 192, 145);
  text("12%", 305, 145);
  
  text("8%", 80, 170);//黄比率
  text("16%", 192, 170);
  text("24%", 305, 170);
  
  textSize(25);
  text("Custom Mode→Press'Q'", 50,330);

  if (keyPressed==true && key=='a') {//easy
    grodiffi=1;
    time=120;
    gamemode++;
    //ゲーム開始easy
  }
  if (keyPressed==true && key=='s') {//normal
    grodiffi=2;
    time=120;
    gamemode++;
    //ゲーム開始normal
  }
  if (keyPressed==true && key=='d') {//hard
    grodiffi=3;
    time=120;
    gamemode++;
    //ゲーム開始hard
  }
  if (keyPressed==true && key=='x') {//demo
    grodiffi=4;
    time=60;
    gamemode++;
    //ゲーム開始demo
  }
  if (keyPressed==true && key=='q') {//demo
    grodiffi=5;
    gamemode+=2;
    //ゲーム開始demo
  }
}

void gameplay() {
  if (frameCount%30==0) {
    time -= 1;
    //時間判定
  }
  block_kind=0;
  randomway();
  if (life>0) {
    bar();
    //ラケット
  }
  textSize(20);
  fill(0);
  text("LEVEL", 5, 50);//レベル表示
  if (grodiffi<=3) {//demo以外
    viewdiffi(120);
  } else if (grodiffi==4) {//demo
    viewdiffi(60);
  } else if(grodiffi==5){
    viewdiffi(timeway);
  }

  if (time>0 && life>0) {
    textSize(15);
    fill(0);
    text("残り時間:", 5, 15);
    text(time, 75, 15);//残り時間表示
    image(mine, 7, 62);
    text("×1", 50, 75);//残機表示
  } else if (life==0) {
    if (isgameover==false) {
      isgameover=true;
    }
    image(overpic, 0, 100,350,87);
    //ライフ消費でのゲームオーバー
  } else {
    image(clearpic,-100,0,550,350);
    //ゲームクリア
  }
  if (keyPressed && key=='r' &&(life==0||time<=0)) {
    gameload();
    gamemode=2;
    isgameover=false;
    //リトライ
  }

  if (time>0) {
    for (blockblue blocksblue : Blocksblue) {
      blocksblue.display();
      //ライフ消費時の青ブロック
    }
    for (blockred blocksred : Blocksred) {
      blocksred.display();
    }//ライフ消費時の赤ブロック
    for (blockyellow blocksyellow : Blocksyellow) {
      blocksyellow.display();
    }

    block_way.update();
    ArrayList<blockblue> nextBlocksblue=new ArrayList<blockblue>();
    for (blockblue blocksblue : Blocksblue) {//青ブロック出現
      blocksblue.update();
      if (!blocksblue.blocklife) {
        nextBlocksblue.add(blocksblue);
        //新しいブロックの表示
      }
    }
    Blocksblue=nextBlocksblue;

    block_way.update();
    ArrayList<blockred> nextBlocksred=new ArrayList<blockred>();
    Blocksblue=nextBlocksblue;
    for (blockred blocksred : Blocksred) {//赤ブロック出現
      blocksred.update();
      if (!blocksred.blocklife) {
        nextBlocksred.add(blocksred);
        //新しいブロックの表示
      }
    }
    Blocksred=nextBlocksred;

    block_way.update();
    ArrayList<blockyellow> nextBlocksyellow=new ArrayList<blockyellow>();
    for (blockyellow blocksyellow : Blocksyellow) {//黄色ブロック出現
      blocksyellow.update();
      if (!blocksyellow.blocklife) {
        nextBlocksyellow.add(blocksyellow);
        //新しいブロックの表示
      }
    }
    Blocksyellow=nextBlocksyellow;
  }
}

int blueway=40, redway=40, yellowway=20, timeway=120, diffiway=0;

void gameserect(){
  stroke(0);
  fill(0);
  textSize(20);
  text("Note:red+blue+yellow=100",50,25);//注意書き
  text("GAMESTART→SPACE KEY",60,50);//ゲームスタート表記
  
  fill(255);//難易度選択の枠一覧
  rect(25,60,90,125); 
  rect(125,60,90,125);
  rect(225,60,90,125);
  rect(70,200,90,125);
  rect(175,200,90,125);
  
  fill(0,0,255);//難易度選択においての何の設定なのかの表示
  rect(40,75,60,35);
  fill(255,0,0);
  rect(140,75,60,35);
  fill(220,220,0);
  rect(240,75,60,35);
  fill(0);
  
  textSize(25);
  text("TIME",90,240);
  textSize(17);
  text("difficult",180,240);
  if(blueway>=4 && blueway<=92){//青＋
    if(blueup){
      blueway+=4;
      blueup=false;
    }
  }
  if(blueway>=8 && blueway<=96){//青ー
    if(bluedown){
      blueway-=4;
      bluedown=false;
    }
  }
  text(blueway+"%",57,155);
  if(redway>=4 && redway<=92){//赤＋
    if(redup){
      redway+=4;
      redup=false;
    }
  }
  if(redway>=8 && redway<=96){//赤ー
    if(reddown){
      redway-=4;
      reddown=false;
    }
  }
  text(redway+"%",157,155);
  if(yellowway>=4 && yellowway<=92){//黄色＋
    if(yellowup){
      yellowway+=4;
      yellowup=false;
    }
  }
  if(yellowway>=8 && yellowway<=96){//黄色ー
    if(yellowdown){
      yellowway-=4;
      yellowdown=false;
    }
  }
  text(yellowway+"%",257,155);
  if(timeway>=30){//時間＋
    if(timeup){
      timeway+=6;
      timeup=false;
    }
  }
  if(timeway>=36){//時間－
    if(timedown){
      timeway-=6;
      timedown=false;
    }
  }
  text(timeway,105,295);
  if(diffiway==0 || diffiway==1){//難易度＋
    if(diffiup){
      diffiway++;
      diffiup=false;
    }
  }
  if(diffiway==1 || diffiway==2){//難易度ー
    if(diffidown){
      diffiway--;
      diffidown=false;
    }
  }
  if(diffiway==0){//難易度表示
    text("easy",205,292);
  }else if(diffiway==1){
    text("normal",200,292);
  }else if(diffiway==2){
    text("hard",200,292);
  }
  if(keyPressed==true && key==' '){//ゲームスタート
    if(blueway+redway+yellowway==100){
      time=timeway;
      gamemode=3;
    }else {//もし青＋黄色＋赤=100じゃなかったら
      fill(255,0,0);
      text("Please to follow'Note'",75,355);
    }
  }
  sankakuup(70,140,"Q");//難易度選択時に反応するキーを示す
  sankakudown(70,160,"A");
  sankakuup(170,140,"W");
  sankakudown(170,160,"S");
  sankakuup(270,140,"E");
  sankakudown(270,160,"D");
  sankakuup(117,277,"R");
  sankakudown(117,297,"F");
  sankakuup(222,277,"T");
  sankakudown(222,297,"G");
}

void sankakuup(int x, int y, String n){//＋設定用の三角描画
  fill(255);
  beginShape();
  vertex(x-15,y);
  vertex(x+15,y);
  vertex(x,y-20);
  endShape(CLOSE);
  fill(0);
  textSize(12);
  text(n,x-2,y);
}

void sankakudown(int x, int y, String n){//－設定用の三角描画
  fill(255);
  beginShape();
  vertex(x-15,y);
  vertex(x+15,y);
  vertex(x,y+20);
  endShape(CLOSE);
  fill(0);
  textSize(12);
  text(n,x-2,y+11);
}
