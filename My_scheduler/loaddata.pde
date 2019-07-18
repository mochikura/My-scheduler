PImage backpic, timepic, daypic, sleeppic, taskpic, gamepic, buspic, weathpic, linkpic, tweetpic;
void loadpic() {//ゲーム以外の画像を一括でロード
  backpic=loadImage("background.png");
  timepic=loadImage("timer.png");
  daypic=loadImage("chalender.png");
  sleeppic=loadImage("sleep.png");
  taskpic=loadImage("task.png");
  gamepic=loadImage("game.png");
  buspic=loadImage("bus.png");
  linkpic=loadImage("link.png");
  weathpic=loadImage("weather.png");
  tweetpic=loadImage("twitter.jpg");
}

String[] task_type;//あり得るタスク一覧
int[][] task_time;//これはタスクの日にち管理
String[] task_list;//これはタスクの内容管理
String[][] tasks;
String[] task;
void loadtask() {//タスクのロード
  task_type=loadStrings("taskkind.txt");
  task=loadStrings("tasklist.txt");
  tasks=new String [task.length][4];
  task_time=new int [tasks.length][3];
  task_list=new String [tasks.length];
  for(int n=0; n<tasks.length; n++){
    tasks[n]=task[n].split(",");
    task_time[n][0]=int(tasks[n][0]);
    task_time[n][1]=int(tasks[n][1]);
    task_time[n][2]=int(tasks[n][2]);
    task_list[n]=tasks[n][3];
  }
}

void loadsleep() {//睡眠時間のロード
  String times[]=loadStrings("sleeptime.txt");
  for (int i=0; i<times.length; i++) {
    sleeptime[i]=int(times[i]);
  }
}

int[][] bus_to_fun=new int[15][4];
int[][] bus_to_sta=new int[12][4];
boolean[] bustime_fun=new boolean [15];
boolean[] bustime_sta=new boolean [12];
void loadbus_fun() {//大学行きのバスのロード
  String[] busfun=loadStrings("bus_go_fun.csv");
  for (int n=0; n<busfun.length; n++) {
    bus_to_fun[n]=int(busfun[n].split(","));
  }
}

void busnow_fun() {//次の大学行きバスのロード
  for (int n=0; n<bus_to_fun.length; n++) {
    bustime_fun[n]=false;
    if (bus_to_fun[n][0]==hour()) {
      if (bus_to_fun[n][1]>minute()) {
        bustime_fun[n]=true;
      }
    }
    if (bus_to_fun[n][0]>hour()) {
      bustime_fun[n]=true;
    }
  }
  if (!bustime_fun[bus_to_fun.length-1]) {
    bustime_fun[0]=true;
  }
  for (int n=0; n<bustime_fun.length-2; n++) {
    if (bustime_fun[0]) {
      nowbus_fun[0]=bus_to_fun[0][0];
      nowbus_fun[1]=bus_to_fun[0][1];
    }
    if (!bustime_fun[n+1] && bustime_fun[n+2]) {
      nowbus_fun[0]=bus_to_fun[n+2][0];
      nowbus_fun[1]=bus_to_fun[n+2][1];
    }
  }
}

void loadbus_sta() {//駅前行きのバスのロード
  String[] bussta=loadStrings("bus_go_sta.csv");
  for (int n=0; n<bussta.length; n++) {
    bus_to_sta[n]=int(bussta[n].split(","));
  }
}

void busnow_sta() {//次の駅前行きのバスのロード
  for (int n=0; n<bus_to_sta.length; n++) {
    bustime_sta[n]=false;
    if (bus_to_sta[n][0]==hour()) {
      if (bus_to_sta[n][1]>=minute()) {
        bustime_sta[n]=true;
      }
    }
    if (bus_to_sta[n][0]>hour()) {
      bustime_sta[n]=true;
    }
  }
  if (!bustime_sta[bus_to_sta.length-1]) {
    bustime_sta[0]=true;
  }
  for (int n=0; n<bustime_sta.length-2; n++) {
    if (bustime_sta[0]) {
      nowbus_sta[0]=bus_to_sta[0][0];
      nowbus_sta[1]=bus_to_sta[0][1];
    }
    if (!bustime_sta[n+1] && bustime_sta[n+2]) {
      nowbus_sta[0]=bus_to_sta[n+2][0];
      nowbus_sta[1]=bus_to_sta[n+2][1];
    }
  }
}
//天気予報のロード、XMLから読み取っている
String wornHAURL="http://weather.livedoor.com/forecast/rss/warn/01d.xml";
String HAURL="http://weather.livedoor.com/forecast/rss/area/017010.xml";
String wornSAURL="http://weather.livedoor.com/forecast/rss/warn/01b.xml";
String SAURL="http://weather.livedoor.com/forecast/rss/area/016010.xml";
String wornTOURL="http://weather.livedoor.com/forecast/rss/warn/13.xml";
String TOURL="http://weather.livedoor.com/forecast/rss/area/130010.xml";
String wornOSURL="http://weather.livedoor.com/forecast/rss/warn/27.xml";
String OSURL="http://weather.livedoor.com/forecast/rss/area/270000.xml";
XML[] wornHA, wornSA, wornTO, wornOS, HA, SA, TO, OS, desHA, desSA, desTO, desOS;
void loadweath() {//SA=SAPPORO、HA＝HAKODATE、TO=TOKYO、OS＝OSAKA、worn＝注意報警報、des＝各天気予報の説明
  try {//インターネットつながっていないとき用
    XML wornxmlHA=loadXML(wornHAURL);
    wornHA=wornxmlHA.getChild("channel").getChildren("item");
    XML xmlHA=loadXML(HAURL);
    HA=xmlHA.getChild("channel").getChildren("item");
    desHA=xmlHA.getChild("channel").getChildren("description");

    XML wornxmlSA=loadXML(wornSAURL);
    wornSA=wornxmlSA.getChild("channel").getChildren("item");
    XML xmlSA=loadXML(SAURL);
    SA=xmlSA.getChild("channel").getChildren("item");
    desSA=xmlSA.getChild("channel").getChildren("description");

    XML wornxmlTO=loadXML(wornTOURL);
    wornTO=wornxmlTO.getChild("channel").getChildren("item");
    XML xmlTO=loadXML(TOURL);
    TO=xmlTO.getChild("channel").getChildren("item");
    desTO=xmlTO.getChild("channel").getChildren("description");

    XML wornxmlOS=loadXML(wornOSURL);
    wornOS=wornxmlOS.getChild("channel").getChildren("item");
    XML xmlOS=loadXML(OSURL);
    OS=xmlOS.getChild("channel").getChildren("item");
    desOS=xmlOS.getChild("channel").getChildren("description");
  }
  catch(Exception e) {
  }
}

void loadplan() {//授業読み込み
  String[][] plan=new String[11][7];
  String plans[]=loadStrings("lectureplan.csv");
  for (int n=0; n<plans.length; n++) {
    plan[n]=plans[n].split(",");
  }
  for (int n=0; n<5; n++) {
    lecday[n]=plan[0][n+2];//曜日
    lecstart[n][0]=int(plan[n*2+1][0]);//開始時間の時
    lecstart[n][1]=int(plan[n*2+1][1]);//開始時間の分
    lecend[n][0]=int(plan[(n+1)*2][0]);//終了時間の時
    lecend[n][1]=int(plan[(n+1)*2][1]);//終了時間の分
  }
  for (int n=0; n<5; n++) {
    for (int i=0; i<5; i++) {
      lecplan[n][i]=plan[i*2+1][n+2];//講義内容
      lecplace[n][i]=plan[(i+1)*2][n+2];//講義場所
    }
  }
}

int ye, mon, da, we1, ho, min, sec;
String we;
void loadtime() {//時刻表示
  ye=year();//年

  mon=month();//月

  da=day();//日

  ho=hour();//時

  min=minute();//分

  sec=second();//秒

  we1=(ye + ye/4 - ye/100 + ye/400 + (13*mon+8)/5 + da)%7;//曜日計算
  switch(we1) {
  case 0://各曜日の字の呼び出し
    we="Sun";
    break;

  case 1:
    we="Mon";
    break;

  case 2:
    we="Tues";
    break;

  case 3:
    we="Wednes";
    break;

  case 4:
    we="Thurs";
    break;

  case 5:
    we="Fri";
    break;

  case 6:
    we="Satur";
    break;
  }
  fill(0);//画面上部の時間の表示
  beginShape();
  vertex(0, 0);
  vertex(0, 12);
  vertex(92, 12);
  vertex(102, 25);
  vertex(378, 25);
  vertex(388, 12);
  vertex(480, 12);
  vertex(480, 0);
  vertex(0, 0);
  endShape(CLOSE);
  textSize(18);
  fill(255);
  textAlign(CENTER);
  text(ye+":"+numzero(mon)+"/"+numzero(da)+"("+we+") "+numzero(ho)+":"+numzero(min)+":"+numzero(sec), width/2, 21);
  fill(0);
  textAlign(LEFT);
}

int mousecheck=0;
void mousePressed() {//マウスボタンの反応
  if (mouseButton ==LEFT) {
    mousecheck=1;
  }
}

void mouseReleased() {//マウスボタン離したときの反応
  if (mouseButton ==LEFT) {
    mousecheck=0;
  }
}

void backplace(int a, String text, int x) {//画面をもどるときのぼたん
  fill(255, 200, 50);
  noStroke();
  beginShape();
  vertex(0, a);
  vertex(200, a);
  vertex(190, a+40);
  vertex(0, a+40);
  vertex(0, a);
  endShape(CLOSE);
  fill(0);
  textSize(20);
  text(text, 20, a+28);
  stroke(0);

  if (mouseX>=0 && mouseX<=200 && mouseY>=a && mouseY<=a+40 && mousecheck==1) {
    dismode=x;
    mousecheck=2;
  }
}

String numzero(int n) {//時刻などの時間表示をすべて2桁にする
  return nf(n/10)+nf(n%10);
}
