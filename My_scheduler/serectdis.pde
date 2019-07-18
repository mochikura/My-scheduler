void serectdis1(){//選択画面その１
  makerect(35,70,200,230,daypic,"時間割表");
  makerect(245,70,200,230,sleeppic,"睡眠時間");
  makerect(35,320,200,230,taskpic,"タスク一覧");
  makerect(245,320,200,230,timepic,"時計");
  if(mouseX>=35 && mouseX<=235 && mouseY>=80 && mouseY<=310 && mousecheck==1){
    dismode=4;//押せば時間割
    mousecheck=2;
  }
  if(mouseX>=245 && mouseX<=445 && mouseY>=80 && mouseY<=310 && mousecheck==1){
    dismode=5;//睡眠時間
    mousecheck=2;
  }
  if(mouseX>=35 && mouseX<=235 && mouseY>=320 && mouseY<=550 && mousecheck==1){
    dismode=6;//タスク
    mousecheck=2;
  }
  if(mouseX>=245 && mouseX<=445 && mouseY>=320 && mouseY<=550 && mousecheck==1){
    dismode=7;//時計
    mousecheck=2;
  }
  beginShape();//選択画面その２に行くボタン
  vertex(475,315);
  vertex(450,290);
  vertex(450,340);
  vertex(475,315);
  endShape(CLOSE);
  if(mouseX>=445 && mouseX<=480 && mouseY>=290 && mouseY<=340 && mousecheck==1){
    dismode=998;
    mousecheck=2;
  }
  backplace(580,"トップに戻る",1);//トップに戻る
}

void serectdis2(){//選択画面その２
  makerect(35,70,200,230,buspic,"バス時刻");
  makerect(245,70,200,230,weathpic,"天気");
  makerect(35,320,200,230,linkpic,"リンク");
  makerect(245,320,200,230,gamepic,"ゲーム");
  if(mouseX>=35 && mouseX<=235 && mouseY>=80 && mouseY<=310 && mousecheck==1){
    dismode=8;//バス時刻
    mousecheck=2;
  }
  if(mouseX>=245 && mouseX<=445 && mouseY>=80 && mouseY<=310 && mousecheck==1){
    dismode=9;//天気予報
    mousecheck=2;
  }
  if(mouseX>=35 && mouseX<=235 && mouseY>=320 && mouseY<=550 && mousecheck==1){
    dismode=10;//リンク
    mousecheck=2;
  }
  if(mouseX>=245 && mouseX<=445 && mouseY>=320 && mouseY<=550 && mousecheck==1){
    dismode=11;//ゲーム
    mousecheck=2;
  }
  beginShape();//選択画面その１に行くボタン
  vertex(5,315);
  vertex(28,290);
  vertex(28,340);
  vertex(5,315);
  endShape(CLOSE);
  if(mouseX>=0 && mouseX<=30 && mouseY>=290 && mouseY<=340 && mousecheck==1){
    dismode=999;
    mousecheck=2;
  }
  backplace(580,"トップに戻る",1);//トップに戻る
}
