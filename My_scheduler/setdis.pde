void setdis(){
  if (isWindows) {//windows用フォント設定
    PFont font=createFont("MS Gothic", 45, true);
    textFont(font);//文字出力
  }
  if (isMac) {//Mac用フォント設定
    PFont font=createFont("Osaka", 45, true);
    textFont(font);//文字出力
  }
}

void makerect(int a, int b, int c, int d, PImage pic, String text){//選択画面用の枠と、画像、タイトル
  fill(0);
  rect(a,b,c,d,10);
  fill(250);
  rect(a+5,b+5,c-10,d-10,10);
  tint(120);
  pic.resize(c-40,c-40);
  image(pic,a+20,b+55);
  fill(0);
  textSize(38);
  textAlign(CENTER);
  text(text,a+c/2, b+42);
  textAlign(LEFT);
  stroke(0);
  noTint();
}

void makeframe(int a, int b, int c, int d){//汎用的に使ってる枠
  fill(0);
  rect(a,b,c,d,10);
  fill(250);
  rect(a+5,b+5,c-10,d-10,10);
  fill(0);
}

void wordframe(int a, int b, int c, int d, String word){//それぞれの機能内でのmode遷移用の枠
  fill(0);
  rect(a,b,c,d,10);
  fill(250);
  rect(a+3,b+3,c-6,d-6,10);
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text(word,a+c/2, b+37);
  textAlign(LEFT);
}

void moveleft(int a){//天気予報にて同地域内の画面遷移に使用、この場合は左に移動
  beginShape();
  vertex(5,315);
  vertex(28,290);
  vertex(28,340);
  vertex(5,315);
  endShape(CLOSE);
  if(mouseX>=0 && mouseX<=30 && mouseY>=290 && mouseY<=340 && mousecheck==1){
  weathmode=a;
  mousecheck=2;
  }
}

void moveright(int a){//天気予報にて同地域内の画面遷移に使用、この場合は右に移動
  beginShape();
  vertex(475,315);
  vertex(450,290);
  vertex(450,340);
  vertex(475,315);
  endShape(CLOSE);
  if(mouseX>=445 && mouseX<=480 && mouseY>=290 && mouseY<=340 && mousecheck==1){
    weathmode=a;
    mousecheck=2;
  }
}

void timeupside(int a, int b){//タイマーでの時間設定＋
  fill(0);
  beginShape();
  vertex(a,b-40);
  vertex(a+25,b);
  vertex(a-25,b);
  vertex(a,b-40);
  endShape(CLOSE);
}

void timedownside(int a, int b){//タイマーでの時間設定ー
  fill(0);
  beginShape();
  vertex(a,b+40);
  vertex(a+25,b);
  vertex(a-25,b);
  vertex(a,b+40);
  endShape(CLOSE);
}

void pointright(int a, int b, int c){//矢印の描画
  fill(0);
  beginShape();
  vertex(a,b);
  vertex(a-16,b-12);
  vertex(a-16,b-5);
  vertex(a-c,b-5);
  vertex(a-c,b+5);
  vertex(a-16,b+5);
  vertex(a-16,b+12);
  vertex(a,b);
  endShape(CLOSE);
}
