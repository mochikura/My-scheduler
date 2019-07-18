int taskmode=0, tasksum=1;//タスク遷移文字、タスク合計の遷移文字
int calayear=year(), calamon=month(), caladay=day();//日付保管
int planyear, planmon, planday;//タスク設定時保管用
int weekcount=0;//カレンダー描画に使用
boolean today_dici, task_dici;//カレンダー表示時のエフェクト判定
String[] weekday={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};//曜日格納
String[] task_era;//削除するタスク格納
int task_eranum;//削除するタスクの番号
void taskplan(){
  loadtask();
  wordframe(20,40,220,50,"タスク");//タスク表示ボタン
  if(mouseX>=20 && mouseX<=240 && mouseY>=40 && mouseY<=90 && mousecheck==1){
    mousecheck=2;
    taskmode=0;
  }
  wordframe(240,40,220,50,"スケジュール");//スケジュール表示ボタン
  if(mouseX>240 && mouseX<=480 && mouseY>=40 && mouseY<=90 && mousecheck==1){
    mousecheck=2;
    taskmode=5;
  }
  switch(taskmode){
    case 0://カレンダー画面
    textSize(40);
    text(calayear+"年"+calamon+"月",145,132);
    for(int n=0; n<7; n++){//カレンダー枠線表示
      fill(255);
      strokeWeight(2);
      rect(60+50*n,145,50,35);
      rect(60+50*n,180,50,65);
      strokeWeight(1);
      textSize(22);
      fill(weekcolor(n));
      text(weekday[n],70+50*n,175);//曜日表示
    }
    fill(0);
    weekcount=0;
    for(int n=0; n<date_num(calamon,calayear); n++){
      today_dici=false;
      if(n+1==day() && calayear==year() && calamon==month()){//今日の分の日付のみ黄色で薄く表示
        today_dici=true;
      }
      task_dici=false;
      for(int a=0; a<task_time.length; a++){
        if(n+1==task_time[a][2] && calayear==task_time[a][0] && calamon==task_time[a][1]){//予定があれば黒丸表示
          task_dici=true;
        }
      }
      calarect(dateplace(calayear,calamon,n+1)*50+60,180+weekcount*65,n+1,task_dici,today_dici,calayear, calamon);
      if(dateplace(calayear,calamon,n+1)==6){//日曜日になったら表示を一段下げる
      weekcount++;
      }
    }
    fill(0);//カレンダーの月＋＋
    beginShape();
    vertex(5,315);
    vertex(28,290);
    vertex(28,340);
    vertex(5,315);
    endShape(CLOSE);
    if(mouseX>=0 && mouseX<=30 && mouseY>=290 && mouseY<=340 && mousecheck==1){
      calamon--;
      mousecheck=2;
    }
    beginShape();//カレンダーの月ーー
    vertex(475,315);
    vertex(450,290);
    vertex(450,340);
    vertex(475,315);
    endShape(CLOSE);
    if(mouseX>=445 && mouseX<=480 && mouseY>=290 && mouseY<=340 && mousecheck==1){
      calamon++;
      mousecheck=2;
    }
    if(calamon==13){//年＋＋
      calamon=1;
      calayear++;
    }
    if(calamon==0){//年ーー
      calamon=12;
      calayear--;
    }
    backplace(580,"メニューに戻る",999);//戻る
    break;
    
    case 1://タスク一覧
    makeframe(70,105,355,460);
    for(int i=0; i<9; i++){//タスク一覧の罫線表示
      strokeWeight(3);
      line(72,160+50*i,423,160+50*i);
      strokeWeight(1);
    }
    textSize(27);
    text(planyear+"年"+planmon+"月"+planday+"日のタスク",95,150);
    int P=0;
    for(int n=0; n<task_time.length; n++){//テキストファイルの中から日付が同一のものを判別、表示
      if(planyear==task_time[n][0] && planmon==task_time[n][1] && planday==task_time[n][2]){
        textAlign(CENTER);
        text(task_list[n],width/2,195+P*50);
        textAlign(LEFT);
        strokeWeight(5);
        line(370,200+50*P,400,170+50*P);
        line(370,170+50*P,400,200+50*P);
        strokeWeight(1);
        P++;
        if(mouseX>=370 && mouseX<=400 && mouseY>=120+50*P && mouseY<=150+50*P && mousecheck==1){//タスク削除ボタン
          mousecheck=2;
          task_era=new String [4];
          task_era[0]=nf(task_time[n][0]);
          task_era[1]=nf(task_time[n][1]);
          task_era[2]=nf(task_time[n][2]);
          task_era[3]=task_list[n];
          task_eranum=n;
          taskmode=3;
        }
      }
    }
      strokeWeight(5);
      line(90,185+50*P,120,185+50*P);
      line(105,170+50*P,105,200+50*P);
      strokeWeight(1);//タスク追加
      if(mouseX>=90 && mouseX<=120 && mouseY>=170+50*P && mouseY<=200+50*P && mousecheck==1){
        mousecheck=2;
        taskmode=2;
        println(mousecheck);
      }
    
    fill(255, 200, 50);//前の画面に戻るボタン
    noStroke();
    beginShape();
    vertex(0, 580);
    vertex(200, 580);
    vertex(190, 580+40);
    vertex(0, 580+40);
    vertex(0, 580);
    endShape(CLOSE);
    fill(0);
    textSize(20);
    text("カレンダーに戻る", 10, 580+28);
    stroke(0);

    if (mouseX>=0 && mouseX<=200 && mouseY>=580 && mouseY<=580+40 && mousecheck==1) {
      taskmode=0;
      mousecheck=2;
    }
    break;
    
    case 2:
    text(planyear+"年"+planmon+"月"+planday+"日のタスク",95,150);
    switch(tasksum){
      case 1://タスク追加1ページ目
      if(task_type.length<=9){
        taskcho(0,task_type.length);
      }else{
        taskcho(0,9);
        taskup();
      }
      break;
      case 2://タスク追加2ページ目
      if(task_type.length<=18){
        taskcho(9,task_type.length);
        taskdown();
      }else{
        taskcho(9,18);
        taskup();
        taskdown();
      }
      break;
      case 3://タスク追加3ページ目
      if(task_type.length<=27){
        taskcho(18,task_type.length);
        taskdown();
      }else{
        taskcho(18,27);
        taskup();
        taskdown();
      }
      break;
      case 4://タスク追加4ページ目
      if(task_type.length<=36){
        taskcho(27,task_type.length);
        taskdown();
      }else{
        taskcho(27,36);
        taskup();
        taskdown();
      }
      break;
      case 5://タスク追加5ページ目
      taskcho(36,45);
      taskdown();
      break;
    }
    
    
    fill(255, 200, 50);//前の画面に戻る
    noStroke();
    beginShape();
    vertex(0, 580);
    vertex(200, 580);
    vertex(190, 580+40);
    vertex(0, 580+40);
    vertex(0, 580);
    endShape(CLOSE);
    fill(0);
    textSize(20);
    text("タスクに戻る", 30, 580+28);
    stroke(0);
    if (mouseX>=0 && mouseX<=200 && mouseY>=580 && mouseY<=580+40 && mousecheck==1) {
      taskmode=1;
      mousecheck=2;
    }
    break;
    
    case 3://タスク削除ページ
    String[] task_eraplan=new String [task_time.length-1];
    textSize(30);
    textAlign(CENTER);
    text(planyear+"年"+planmon+"月"+planday+"日のタスク",width/2,150);//削除情報表示
    text(task_era[3]+"を消去しますか？",width/2,190);
    makeframe(80,210,140,60);
    text("はい",150,250);
    if(mouseX>=80 && mouseX<=220 && mouseY>=210 && mouseY<=270 && mousecheck==1){//削除確認ボタン
      mousecheck=2;
      if(n<task_time.length-1){
        println(task_eranum);
        for(int x=task_eranum; x<task_time.length-1; x++){//もし、テキストファイルにおいて削除する要素が一番最後に位置していないなら
          for(int y=0; y<3; y++){//削除する要素を後の要素から上書きする
          task_time[x][y]=task_time[x+1][y];
          }
          task_list[x]=task_list[x+1];
        }
        for(int x=0; x<task_eraplan.length; x++){
          task_eraplan[x]=nf(task_time[x][0])+","+nf(task_time[x][1])+","+nf(task_time[x][2])+","+task_list[x];
        }
      }
      String[][] samecase=new String [task_time.length-1][4];
      if(n==task_time.length-1){//もし、テキストファイルにおいて削除する要素が一番最後に位置しているなら
        for(int x=0; x<samecase.length; x++){//削除する要素のみ排除して新しい配列に入れる
          for(int y=0; y<3 ;y++){
            samecase[x][y]=nf(task_time[x][y]);
          }
          samecase[x][3]=task_list[x];
        }
        for(int x=0; x<samecase.length; x++){
          task_eraplan[x]=samecase[x][0]+","+samecase[x][1]+","+samecase[x][2]+","+samecase[x][3];
        }
      }
      saveStrings("tasklist.txt",task_eraplan);//テキスト出力
      taskmode=1;
      loadtask();
    }
    makeframe(260,210,140,60);
    text("いいえ",330,250);//拒否したら画面が戻る
    if(mouseX>=260 && mouseX<=400 && mouseY>=210 && mouseY<=270 && mousecheck==1){
      mousecheck=2;
      taskmode=1;
    }
    textAlign(LEFT);//戻るボタン
    fill(255, 200, 50);
    noStroke();
    beginShape();
    vertex(0, 580);
    vertex(200, 580);
    vertex(190, 580+40);
    vertex(0, 580+40);
    vertex(0, 580);
    endShape(CLOSE);
    fill(0);
    textSize(20);
    text("タスクに戻る", 30, 580+28);
    stroke(0);
    if (mouseX>=0 && mouseX<=200 && mouseY>=580 && mouseY<=580+40 && mousecheck==1) {
      taskmode=1;
      mousecheck=2;
    }
    break;
    
    case 5://schedule参照
    showsche();
    backplace(580,"メニューに戻る",999);
    break;
  }
}

void taskcho(int a, int b){//タスク追加
  String[][] tasks_plan=new String [task_list.length+1][4];
  String[] task_plan=new String [tasks_plan.length];
    makeframe(70,105,355,460);
      for(int n=a; n<b; n++){
        line(72,105+(n-a)*50,423,105+(n-a)*50);
        textAlign(CENTER);
          text(task_type[n],width/2,145+(n-a)*50);//押したタスクをtasksplanに代入
          if(mouseX>=70 && mouseX<=425 && mouseY>105+(n-a)*50 && mouseY<145+(n-a)*50 && mousecheck==1){
            tasks_plan[tasks_plan.length-1][0]=nf(planyear);
            tasks_plan[tasks_plan.length-1][1]=nf(planmon);
            tasks_plan[tasks_plan.length-1][2]=nf(planday);
            tasks_plan[tasks_plan.length-1][3]=task_type[n];
            task_plan=new String [tasks_plan.length];
            for(int x=0; x<tasks_plan.length-1; x++){
              for(int y=0; y<4; y++){
                tasks_plan[x][y]=tasks[x][y];//
              }
              task_plan[x]=tasks_plan[x][0]+","+tasks_plan[x][1]+","+tasks_plan[x][2]+","+tasks_plan[x][3];
            }
            task_plan[task_plan.length-1]=tasks_plan[tasks_plan.length-1][0]+","+tasks_plan[tasks_plan.length-1][1]+","+tasks_plan[tasks_plan.length-1][2]+","+tasks_plan[tasks_plan.length-1][3];
            taskmode=0;//tasksplanの要素を,区切りで別出力
            saveStrings("tasklist.txt",task_plan);
            mousecheck=2;
          }
        textAlign(LEFT);
      }
}
void taskup(){//タスク追加一覧遷移＋＋
  beginShape();
  vertex(475,315);
  vertex(450,290);
  vertex(450,340);
  vertex(475,315);
  endShape(CLOSE);
  if(mouseX>=445 && mouseX<=480 && mouseY>=290 && mouseY<=340 && mousecheck==1){
    tasksum++;
    mousecheck=2;
  }
}

void taskdown(){//タスク追加一覧遷移ーー
  beginShape();
  vertex(5,315);
  vertex(28,290);
  vertex(28,340);
  vertex(5,315);
  endShape(CLOSE);
  if(mouseX>=0 && mouseX<=30 && mouseY>=290 && mouseY<=340 && mousecheck==1){
    tasksum--;
    mousecheck=2;
  }
}

int date_num(int x, int y){//月に応じて日数を出力
  if(x==1 || x==3 || x==5 || x==7 || x==8 || x==10 || x==12){
    return 31;
  }
  if(x==4 || x==6 || x==9 || x==11){
    return 30;
  }
  else{
    if((y%4==0 && y%100!=0) || (y%4==0 && y%100==0 && y%400==0)){
      return 29;
    }
    if((y%4!=0) || (y%4==0 && y%100==0 && y%400!=0)){
      return 28;
    }
    return 28;
  }
}

int dateplace(int year, int month, int day){//曜日出力
  return (year + year/4 - year/100 + year/400 + (13*month+8)/5 + day)%7;
}

void calarect(int x, int y, int a, boolean task, boolean today, int year, int month){
  fill(255);//月日曜日、タスクの有無、今日であるか否か、年でカレンダーを一日一日出力
  if(today){
   fill(255,252,204); 
  }
  strokeWeight(2);
  rect(x,y,50,65);
  strokeWeight(1);
  textSize(24);

  fill(weekcolor(dateplace(year,month,a)));
  textAlign(CENTER);
  text(nf(a),x+25,y+28);
  textAlign(LEFT);
  if(task){
    fill(100);
    noStroke();
    ellipse(x+25,y+45,10,10);
    stroke(0);
  }
  if(mouseX>x && mouseX<x+50 && mouseY>y && mouseY<y+70 && mousecheck==1 ){
    mousecheck=2;//そのカレンダーに相応する場所を押すとタスク追加画面出力
    planyear=year;
    planmon=month;
    planday=a;
    taskmode=1;
  }
}

color weekcolor(int n){
  if(n==0){//曜日に応じて色出力
    return #ff0000;
  }
  if(n==6){
    return #0000ff;
  }else{
    return #000000;
  }
}
