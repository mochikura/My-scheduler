int[] sleeptime=new int [8];
boolean sleepstart=false, sleepend=false;
int timesum;

void sleepmanage(){//睡眠時間管理
  makeframe(60,60,220,200);//各枠の表示
  makeframe(285,60,135,200);
  makeframe(60,280,160,80);
  makeframe(260,280,160,80);
  makeframe(60,380,160,80);
  makeframe(260,380,160,80);
  noTint();
  tweetpic.resize(90,90);//ツイート画像の調整
  image(tweetpic,295,490);
  textSize(30);
  text("就寝時間",80,100);//各表示の設定
  text("起床時間",80,190);
  textSize(25);
  line(280,62,280,260);
  text("睡眠時間",305,100);
  textSize(35);
  text("寝る！",90,330);//ボタン表示
  text("起きた！",280,330);
  text("リセット",72,430);
  text("セーブ",288,430);
  if(mouseX>=60 && mouseX<=220 && mouseY>=280 && mouseY<=360 && mousecheck==1 && !sleepstart){//寝るボタンを押すと寝た時間が記録
    mousecheck=2;
    sleeptime[0]=month();
    sleeptime[1]=day();
    sleeptime[2]=hour();
    sleeptime[3]=minute();
    sleepstart=true;
  }
  if(mouseX>=260 && mouseX<=420 && mouseY>=280 && mouseY<=360 && mousecheck==1 && !sleepend){//起きたボタンをおすと起きた時間が記録
    mousecheck=2;
    sleeptime[4]=month();
    sleeptime[5]=day();
    sleeptime[6]=hour();
    sleeptime[7]=minute();
  }
  textSize(60); 
  if(sleeptime[1]==sleeptime[5] && sleeptime[2]<=sleeptime[6]){//もし寝た日付と起きた日付が一緒なら
    timesum=(sleeptime[6]*60+sleeptime[7])-(sleeptime[2]*60+sleeptime[3]);//分換算して計算
    text(numzero(timesum/60),320,165);
    text(numzero(timesum%60),320,235);
  }
  if(sleeptime[1]<sleeptime[5]){//もし寝た日付と起きた日付が違うなら
    timesum=(sleeptime[5]*24*60+sleeptime[6]*60+sleeptime[7])-(sleeptime[1]*24*60+sleeptime[2]*60+sleeptime[3]);//日から分換算して計算
    text(numzero(timesum/60),320,165);
    text(numzero(timesum%60),320,235);
  }
  textSize(15);
  text("時間",380,170);
  text("分",390,240);
  if(mouseX>=60 && mouseX<=220 && mouseY>=380 && mouseY<=460 && mousecheck==1){//リセットボタン
    mousecheck=2;
    sleeptime=new int [8];
    sleepstart=false;
    sleepend=false;
    timesum=0;
    saveStrings("sleeptime.txt",nf(sleeptime,0));
  }
  if(mouseX>=260 && mouseX<=420 && mouseY>=380 && mouseY<=460 && mousecheck==1){//セーブボタン
    mousecheck=2;
    saveStrings("sleeptime.txt",nf(sleeptime,0));
  }
  if(mouseX>=295 && mouseX<=385 && mouseY>=490 && mouseY<=580 && mousecheck==1){//ツイートボタン
    mousecheck=2;
    link("http://twitter.com/?status="+"就寝時間は"+nf(sleeptime[0])+"%2f"+nf(sleeptime[1])
    +"%20"+nf(sleeptime[2])+"%3a"+nf(sleeptime[3])+"%0a起床時間は"+nf(sleeptime[4])
    +"%2f"+nf(sleeptime[5])+"%20"+nf(sleeptime[6])+"%3a"+nf(sleeptime[7])+"%0a睡眠時間は"
    +nf(timesum/60)+"時間"+nf(timesum%60)+"分です");
  }
  textSize(35);
  text(numzero(sleeptime[0])+"/"+numzero(sleeptime[1])+" "+numzero(sleeptime[2])+":"+numzero(sleeptime[3]),74,140);//就寝時間、起床時間の表示
  text(numzero(sleeptime[4])+"/"+numzero(sleeptime[5])+" "+numzero(sleeptime[6])+":"+numzero(sleeptime[7]),74,230);
  backplace(580,"メニューに戻る",999);//戻る
}

int weathmode=1;
void weather(){//天気予報
  wordframe(20,40,110,50,"道南");//天気予報の地区表示
  wordframe(130,40,110,50,"札幌");
  wordframe(240,40,110,50,"東京");
  wordframe(350,40,110,50,"大阪");
  if(mouseX>=20 && mouseX<=130 && mouseY>=40 && mouseY<=90 && mousecheck==1){//道南
    weathmode=1;
    mousecheck=2;
  }
  if(mouseX>130 && mouseX<=240 && mouseY>=40 && mouseY<=90 && mousecheck==1){//札幌
    weathmode=4;
    mousecheck=2;
  }
  if(mouseX>240 && mouseX<=350 && mouseY>=40 && mouseY<=90 && mousecheck==1){//東京
    weathmode=7;
    mousecheck=2;
  }
  if(mouseX>350 && mouseX<=460 && mouseY>=40 && mouseY<=90 && mousecheck==1){//大阪
    weathmode=10;
    mousecheck=2;
  }
  textSize(35);
  switch(weathmode){
    case 1://函館
    text("道南、函館の天気予報",65,130);
    makeframe(25,145,415,425);
    textSize(18);
    for(int i=1; i<HA.length;i++){
      try{
      String des=HA[i].getChild("description").getContent();//loadweathから呼び出し
      text(des,35,110+50*i,400,100);
      }catch(Exception e){//null対策、以後省略
        String des="データなし";
        text(des,35,110+50*i,400,100);
      }
    }
    moveright(2);//右移動で警報注意報へ
    break;
    
    case 2://函館
    text("道南の警報、注意報(1)",65,130);
    textSize(18);
    makeframe(55,150,385,390);
    for(int i=1; i<7; i++){
      try{
      String des=wornHA[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,110+60*i,400,100);
      }catch(Exception e){
        String des="データなし";
        text(des,70,110+60*i,400,100);
      }
    }
    moveleft(1);
    moveright(3);
    break;
    
    case 3://函館
    text("道南の警報、注意報(2)",65,130);
    makeframe(55,150,400,390);
    textSize(18);
    for(int i=7; i<wornHA.length; i++){
      try{
      String des=wornHA[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,110+60*(i-6),400,100);
      }catch(Exception e){
        String des="データなし";
        text(des,70,110+60*(i-6),400,100);
      }
    }
    moveleft(2);
    break;
    
    case 4://札幌
    text("道央、札幌の天気予報",65,130);
    makeframe(25,145,415,425);
    textSize(18);
    for(int i=1; i<SA.length;i++){
      try{
      String des=SA[i].getChild("description").getContent();//loadweathから呼び出し
      text(des,35,110+50*i,400,100);
      }catch(Exception e){
        String des="データなし";
        text(des,35,110+50*i,400,100);
      }
    }
    moveright(5);
    break;
    
    case 5://札幌
    text("道央の警報、注意報(1)",65,130);
    textSize(18);
    makeframe(55,150,385,390);
    for(int i=1; i<6; i++){
      try{
      String des=wornSA[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,110+60*i,380,100);
      }catch(Exception e){
        String des="データなし";
        text(des,70,110+60*i,380,100);
      }
    }
    moveleft(4);
    moveright(6);
    break;
    
    case 6://札幌
    text("道央の警報、注意報(2)",65,130);
    makeframe(55,150,400,390);
    textSize(18);
    for(int i=6; i<wornSA.length; i++){
      String des=wornSA[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,110+60*(i-5),400,100);
    }
    moveleft(5);
    break;
    
    case 7://東京
    text("東京の天気予報",110,130);
    makeframe(25,145,415,425);
    textSize(18);
    for(int i=1; i<TO.length;i++){
      String des=TO[i].getChild("description").getContent();//loadweathから呼び出し
      text(des,35,110+50*i,400,100);
    }
    moveright(8);
    break;
    
    case 8://東京
    text("東京の警報、注意報(1)",80,130);
    textSize(18);
    makeframe(55,150,385,390);
    for(int i=1; i<6; i++){
      try{
      String des=wornTO[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,110+60*i,380,100);
      }catch(Exception e){
        String des="データなし";
        text(des,70,110+60*i,380,100);
      }
    }
    moveleft(7);
    moveright(9);
    break;
    
    case 9://東京
    text("東京の警報、注意報(2)",80,130);
    textSize(18);
    makeframe(55,150,385,420);
    for(int i=6; i<wornTO.length; i++){
      try{
      String des=wornTO[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,75+90*(i-5),370,100);
      }catch(Exception e){
        e.printStackTrace();
        String des="データなし";
        text(des,70,75+90*(i-5),370,100);
      }
    }
    moveleft(8);
    break;
    
    case 10://大阪
    text("大阪の天気予報",110,130);
    makeframe(25,145,415,425);
    textSize(18);
    for(int i=1; i<OS.length;i++){
      try{
      String des=OS[i].getChild("description").getContent();//loadweathから呼び出し
      text(des,35,110+50*i,400,100);
      }catch(Exception e){
        String des="データなし";
        text(des,35,110+50*i,400,100);
      }
    }
    moveright(11);
    break;
    
    case 11://大阪
    text("大阪の警報、注意報",90,130);
    textSize(18);
    makeframe(55,150,385,390);
    for(int i=1; i<6; i++){
      try{
      String des=wornOS[i].getChild("title").getContent();//loadweathから呼び出し
      text(des,70,110+60*i,380,100);
      }catch(Exception e){
        String des="データなし";
        text(des,70,110+60*i,380,100);
      }
    }
    moveleft(10);
    break;
  }
  backplace(580,"メニューに戻る",998);//戻る
}
