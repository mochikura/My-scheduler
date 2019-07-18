int[] nowbus_fun=new int [2];
int[] nowbus_sta=new int [2];

void topdis(){//トップ画面
  textFont(titlefont);//タイトルのフォント設定からのタイトル表示
  textSize(70);
  text("My Scheduler",30,100);
  textSize(40);
  text("Mouseclick...MENU",65,600);
  setdis();
  if(mousecheck==1){
    dismode=999;//マウスクリックしたら選択画面に
    mousecheck=2;
  }
  makeframe(60,120,360,410);
  fill(0);//次のバスの時間を表示
  textSize(30);
  text("次のバス",90,180);
  textSize(20);
  text("函館駅前発、未来大学行　"+numzero(nowbus_fun[0])+":"+numzero(nowbus_fun[1]),90,210);
  text("未来大学発、函館駅前行　"+numzero(nowbus_sta[0])+":"+numzero(nowbus_sta[1]),90,240);
  
  textSize(30);
  text("今日の天気",90,295);//今日の天気を表示
  try{
  String nowweath=HA[1].getChild("description").getContent();
  textSize(20);
  text(nowweath,90,310,280,100);
  }catch(Exception e){//null対策
    String nowweath="データなし";
    textSize(20);
    text(nowweath,90,310,280,100);
  }
  
  textSize(30);//次の授業を表示
  text("次の授業",90,420);
  textSize(20);
  nextlecture();
  text(nextlec,90,450);
  text(nextlecplace,90,480);
  text(numzero(nextlectime[0])+":"+numzero(nextlectime[1])+"～"+numzero(nextlectime[2])+":"+numzero(nextlectime[3]),90,510);
}

String nextlec, nextlecplace;
int[] nextlectime=new int [4];
int daycount, startcount; 
void nextlecture(){//次の授業を出力
  for(int n=0; n<5; n++){
    if(8>=hour()){//今の時間に応じてどの時限に位置するのか出力
      startcount=0;
    }
    if((lecstart[n][0]==hour() && lecstart[n][1]<=minute()) || lecstart[n][0]<hour()){
      startcount=n+1;
    }
    if(18<=hour()){
      startcount=5;
    }
  }
  daycount=we1-1;
  if(startcount>=5){//もし今の時間が今日の授業終わった後なら次の日に移る
    startcount=0;
    daycount++;
  }
  if(daycount==-1 || daycount>=5){//もし今の時間が土日なら月曜日に移る
    daycount=0;
    startcount=0;
  }
  nextlec=lecplan[daycount][startcount];//いったんここで今の授業を出力
  while(nextlec==" "){//もし出力したのが" "なら次の授業を見る、これを繰り返す
    startcount++;
    if(startcount>=5){
      daycount++;
      startcount=0;
    }
    if(daycount>=5 || daycount==-1){
      daycount=0;
      startcount=0;
    }
    nextlec=lecplan[daycount][startcount];
  }

  nextlecplace=lecplace[daycount][startcount];//それぞれ次の授業、場所、時間を格納してtopに移す
  nextlectime[0]=lecstart[startcount][0];
  nextlectime[1]=lecstart[startcount][1];
  nextlectime[2]=lecend[startcount][0];
  nextlectime[3]=lecend[startcount][1];
}
