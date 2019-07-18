String OS_NAME;//OS名格納
boolean isWindows = false;
boolean isMac = false;
boolean isLinux = false;

int dismode=0;
//マスター制御値
String lecplan[][]=new String[5][5];//この五つは時間割格納
String lecplace[][]=new String[5][5];
int lecstart[][]=new int[5][2];
int lecend[][]=new int[5][2];
String lecday[]=new String[5];

PFont titlefont;//タイトルのフォント


void setup(){
  size(480,640);//画面サイズ //<>//
  titlefont=loadFont("Cambria-BoldItalic-48.vlw");//フォント読み込み
  smooth();
  frameRate(30);
  OS_NAME = System.getProperty("os.name");//OS名を文字列として取得
  if (OS_NAME.indexOf("Windows") != -1) {//文字列にWindowsが含まれているか部分判定
    isWindows = true;
    //println(isWindows);テストコード
  }
  if (OS_NAME.indexOf("Mac") != -1) {//文字列にMacが含まれているか部分判定
    isMac = true;
    //println(isMac);テストコード
  }
  if (OS_NAME.indexOf("Linux") != -1) {//文字列にLinuxが含まれているか部分判定
    isLinux = true;
    //println(isLinux);テストコード
  }
  loadpic();
  loadsleep();
  loadtask();
  loadplan();
  loadlink();
  loadsche_1();
  loadbus_fun();
  loadbus_sta();
  busnow_fun();
  busnow_sta();
  loadweath();//ロード一覧、大体はloaddataみればわかる
  mine=loadImage("EDGE2.png");//ゲーム用画像読み込み
}


void draw(){
  background(255);
  tint(255,80);//選択画面の画像薄すぎて濃くした
  image(backpic,0,0);
  switch(dismode){
    case 0://フォントのセット
    setdis();
    dismode=1;
    break;
    
    case 1:
    topdis();//トップ画面
    break;
    
    case 999:
    serectdis1();//選択画面その１
    break;
    
    case 998:
    serectdis2();//選択画面その２
    break;
    
    case 4:
    lecture();//時間割
    break;
    
    case 5:
    sleepmanage();//睡眠時間管理
    break;
    
    case 6:
    taskplan();//タスク管理
    break;
    
    case 7:
    timer();//時間管理
    break;
    
    case 8:
    bustime();//バス管理
    busnow_fun();
    busnow_sta();
    break;
    
    case 9:
    weather();//天気情報
    break;
    
    case 10:
    linkdis();//リンク
    break;
    
    case 11:
    gamedis();//ゲーム
    break;
  }
  loadtime();//時間読み込み
}
