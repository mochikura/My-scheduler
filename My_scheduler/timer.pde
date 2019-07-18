int timermode=1;//タイマーのモード
int timercount=0, stopcount=0;//タイマーストップウォッチの秒数判定
int timerhour=0, timermin=3, timersec=0;//タイマー初期値
int stophour=0, stopmin=0, stopsec=0, lapnum=0;//ストップウォッチ初期値
int[][] laptime=new int[3][3];//ラップタイム格納
void timer(){//タイマー
  fill(0);
  wordframe(20,40,180,50,"タイマー");
  wordframe(200,40,260,50,"ストップウォッチ");
  if(mouseX>=20 && mouseX<=200 && mouseY>=40 && mouseY<=90 && mousecheck==1){//このメソッド内の遷移ボタン
    timermode=1;
    mousecheck=2;
  }
  if(mouseX>200 && mouseY<=460 && mouseY>=40 && mouseY<=90 && mousecheck==1){//その２
    timermode=3;
    mousecheck=2;
  }
  switch(timermode){
    case 1://タイマー開始
    makeframe(35,150,415,250);
    if(mouseX>=79 && mouseX<=129 && mouseY>=180 && mouseY<=220 && mousecheck==1){//時間＋＋
      timerhour++;
      mousecheck=2;
    }
    if(mouseX>=79 && mouseX<=129 && mouseY>=310 && mouseY<=350 && mousecheck==1 && timerhour>=1){//時間ーー
      timerhour--;
      mousecheck=2;
    }
    if(mouseX>=215 && mouseX<=255 && mouseY>=180 && mouseY<=220 && mousecheck==1){//分＋＋
      timermin++;
      mousecheck=2;
    }
    if(mouseX>=215 && mouseX<=255 && mouseY>=310 && mouseY<=350 && mousecheck==1 && timermin>=1){//分ーー
      timermin--;
      mousecheck=2;
    }
    if(mouseX>=348 && mouseX<=398 && mouseY>=180 && mouseY<=220 && mousecheck==1){//秒＋＋
      timersec++;
      mousecheck=2;
    }
    if(mouseX>=348 && mouseX<=398 && mouseY>=310 && mouseY<=350 && mousecheck==1 && timersec>=1){//秒ーー
      timersec--;
      mousecheck=2;
    }
    if(timerhour==60){//それぞれ60以上にならないようにしてる
      timerhour=0;
    }
    if(timermin==60){
      timermin=0;
    }
    if(timersec==60){
      timersec=0;
    }
    makeframe(120,430,250,100);
    textSize(70);
    text("START",160,512);//もし全部０でないならタイマースタート
    if(mouseX>=120 && mouseX<=370 && mouseY>=430 && mouseY<=530 && mousecheck==1 && !(timerhour==0 && timermin==0 && timersec==0)){
      timermode=2;
      mousecheck=2;
      stopcount=0;
    }
    timeupside(104,220);//ここで表示される矢印の場所を押せば時間が上下する
    timedownside(104,310);//upなら上がる、downなら下がる、上から時間、分、秒の順で設定してる
    timeupside(240,220);
    timedownside(240,310);
    timeupside(373,220);
    timedownside(373,310);
    textSize(90);
    text(numzero(timerhour)+":"+numzero(timermin)+":"+numzero(timersec),60,300);//時間表示
    break;
    
    case 2:
    makeframe(35,150,415,250);//タイマー動いてる
    if(timerhour!=0 || timermin!=0 || timersec!=0){
      timercount++;
      if(timercount%30==0){
        timersec--;
      }
      if(timersec==-1){//ちゃんと時間の表示になるように設定
        timermin--;
        timersec=59;
      }
      if(timermin==-1){
        timerhour--;
        timermin=59;
      }
    }
    if(timerhour==0 && timermin==0 && timersec==-1){//すべてが終了したらタイマー設定画面に戻る
      timermode=1;
    }
    textSize(90);
    text(numzero(timerhour)+":"+numzero(timermin)+":"+numzero(timersec),60,300);
    makeframe(120,430,250,100);
    textSize(70);
    text("STOP",175,512);
    if(mouseX>=120 && mouseX<=370 && mouseY>=430 && mouseY<=530 && mousecheck==1){//途中停止も可能
      timermode=1;
      mousecheck=2;
    }
    break;
    
    case 3://ストップウォッチ設定
    makeframe(35,120,415,135);//それ用の枠
    makeframe(35,280,200,270);
    makeframe(240,280,210,80);
    makeframe(240,375,210,80);
    makeframe(240,470,210,80);
    textSize(50);
    text("START",280,345);//ストップウォッチ開始ボタン
    if(mouseX>=240 && mouseX<=450 && mouseY>=280 && mouseY<=360 && mousecheck==1){
      timermode=4;
      mousecheck=2;
      stopcount=0;
      lapnum=0;
      laptime=new int[3][3];
      stophour=0;
      stopmin=0;//値の初期化
      stopsec=0;
    }
    text("LAP",300,435);
    if(mouseX>=240 && mouseX<=450 && mouseY>=375 && mouseY<=455 && mousecheck==1){//ラップタイムボタンを押したらそれぞれに値を格納、最大三つ可能
      mousecheck=2;
      if(lapnum==2){
        laptime[2][0]=stophour;
        laptime[2][1]=stopmin;
        laptime[2][2]=stopsec;
        lapnum=3;
      }
      if(lapnum==1){
        laptime[1][0]=stophour;
        laptime[1][1]=stopmin;
        laptime[1][2]=stopsec;
        lapnum=2;
      }
      if(lapnum==0){
        laptime[0][0]=stophour;
        laptime[0][1]=stopmin;
        laptime[0][2]=stopsec;
        lapnum=1;
      }
    }
    text("RESET",280,535);//ラップタイムのリセット
    if(mouseX>=240 && mouseX<=450 && mouseY>=470 && mouseY<=560 && mousecheck==1){
      laptime=new int[5][5];
      lapnum=0;
    }
    text("laptime",50,330);
    for(int n=0; n<laptime.length; n++){//ラップタイムの表示
      textSize(22);
      text("lap"+(n+1),50,355+63*n);
      textSize(35);
      text(numzero(laptime[n][0])+":"+numzero(laptime[n][1])+":"+numzero(laptime[n][2]),60,390+63*n);
    }
    textSize(90);
    text(numzero(stophour)+":"+numzero(stopmin)+":"+numzero(stopsec),60,220);//値の表示
    break;
    
    case 4://ストップウォッチ動作時
    makeframe(35,120,415,135);//枠表示
    makeframe(35,280,200,270);
    makeframe(240,280,210,80);
    makeframe(240,375,210,80);
    makeframe(240,470,210,80);
    
    stopcount++;
    if(stopcount%30==0){
      stopsec++;
    }
    if(stopsec==60){//表示されるのがしっかり時間の値になるように設定
      stopsec=0;
      stopmin++;
    }
    if(stopmin==60){
      stopmin=0;
      stophour++;
    }
     textSize(50);
    text("STOP",290,345);
    if(mouseX>=240 && mouseX<=450 && mouseY>=280 && mouseY<=360 && mousecheck==1){//ストップ可能
      timermode=3;
      mousecheck=2;
      stopcount=0;
    }
    text("LAP",300,435);
    if(mouseX>=240 && mouseX<=450 && mouseY>=375 && mouseY<=455 && mousecheck==1){//ラップタイム押したらその時に値が格納される
      mousecheck=2;
      if(lapnum==2){
        laptime[2][0]=stophour;
        laptime[2][1]=stopmin;
        laptime[2][2]=stopsec;
        lapnum=3;
      }
      if(lapnum==1){
        laptime[1][0]=stophour;
        laptime[1][1]=stopmin;
        laptime[1][2]=stopsec;
        lapnum=2;
      }
      if(lapnum==0){
        laptime[0][0]=stophour;
        laptime[0][1]=stopmin;
        laptime[0][2]=stopsec;
        lapnum=1;
      }
    }
    text("RESET",280,535);//ラップタイムのリセット
    if(mouseX>=240 && mouseX<=450 && mouseY>=470 && mouseY<=560 && mousecheck==1){
      laptime=new int[3][3];
      lapnum=0;
    }
    textSize(50);
    text("laptime",50,330);
    for(int n=0; n<laptime.length; n++){//ラップタイムの表示
      textSize(22);
      text("lap"+(n+1),50,355+63*n);
      textSize(35);
      text(numzero(laptime[n][0])+":"+numzero(laptime[n][1])+":"+numzero(laptime[n][2]),60,390+63*n);
    }
    textSize(90);
    text(numzero(stophour)+":"+numzero(stopmin)+":"+numzero(stopsec),60,220);//時間表示
    break;
  }
  backplace(580,"メニューに戻る",999);//戻る
}
