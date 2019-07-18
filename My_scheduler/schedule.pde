String[][] week1, week2;
void loadsche_1() {//スケジュールのロードその１
  String[] loadweek1=loadStrings("week1_1019230.txt");
  String[] loadweek2=loadStrings("week2_1019230.txt");
  week1=new String[loadweek1.length][3];//,区切りで配列を生成×２
  for (int n=0; n<loadweek1.length; n++) {
    week1[n]=loadweek1[n].split(",");
  }
  week2=new String[loadweek2.length][3];
  for (int n=0; n<loadweek2.length; n++) {
    week2[n]=loadweek2[n].split(",");
  }
  loadsche_2(week1, datasum1);
  loadsche_2(week2, datasum2);
}

int [][] datasum1=new int [7][2], datasum2=new int [7][2];
void loadsche_2(String[][] data, int[][] sum) {//スケジュールのロードその２
  for (int i=1; i<7; i++) {//要素情報の代入
    sum[i][0]=i;
  }
  for (int i=0; i<data.length; i++) {//各生活要素量を計算
    sum[int(data[i][1])][1]+=int(data[i][2]);
  }
}

int rectsum=0;
void showsche() {//スケジュールグラフの表示
  makeframe(50, 100, 400, 175);
  makeframe(50, 280, 400, 175);
  makeframe(50, 465, 400, 110);
  textSize(40);
  text("week1", 70, 140);//一週目の表示
  if (datasum1[0][1]+datasum1[1][1]+datasum1[2][1]+datasum1[3][1]
    +datasum1[4][1]+datasum1[5][1]+datasum1[6][1]!=96*7) {//データ量の総計が間違ってたらグラフが表示されない
    textSize(30);
    text("データに誤りがあります", 50, 200);
    textSize(20);
    text("（データ数："+nf(datasum1[0][1]+datasum1[1][1]+datasum1[2][1]+datasum1[3][1]
      +datasum1[4][1]+datasum1[5][1]+datasum1[6][1])+"）", 100, 250);//データの改善要求
  } else {
    fill(255);
    rectsum=0;
    for (int i=0; i<datasum1.length; i++) {
      fill(callcolor(i));//色呼び出し
      rect(65+rectsum, 160, datasum1[i][1]*0.55, 100);//グラフの四角形の表示
      rectsum+=datasum1[i][1]*0.55;//座標をずらす
    }
  }
  textSize(40);
  fill(0);
  text("week2", 70, 325);//一週目と同様な処理をしてるため説明省略
  if (datasum2[0][1]+datasum2[1][1]+datasum2[2][1]+datasum2[3][1]
    +datasum2[4][1]+datasum2[5][1]+datasum2[6][1]!=96*7) {
    textSize(30);
    text("データに誤りがあります", 50, 370);
    textSize(20);
    text("（データ数："+nf(datasum2[0][1]+datasum2[1][1]+datasum2[2][1]+datasum2[3][1]
      +datasum2[4][1]+datasum2[5][1]+datasum2[6][1])+"）", 100, 420);
  } else {
    fill(255);
    rectsum=0;
    for (int i=0; i<datasum2.length; i++) {
      fill(callcolor(i));
      rect(65+rectsum, 340, datasum2[i][1]*0.55, 100);
      rectsum+=datasum2[i][1]*0.55;
    }
  }
  fill(0);
  textSize(20);//各要素の表示設定
  fill(0);
  text("sleep", 155, 500);//睡眠
  fill(callcolor(0));
  rect(90, 480, 50, 18);

  fill(0);
  text("eat", 270, 500);//食事
  fill(callcolor(1));
  rect(215, 480, 50, 18);

  fill(0);
  text("move", 375, 500);//移動
  fill(callcolor(2));
  rect(315, 480, 50, 18);

  fill(0);
  text("free", 185, 530);//自由時間or自学
  fill(callcolor(3));
  rect(110, 510, 50, 18);

  fill(0);
  text("lecture", 308, 530);//講義中
  fill(callcolor(4));
  rect(250, 510, 50, 18);

  fill(0);
  text("college", 170, 560);//大学内にいる
  fill(callcolor(5));
  rect(110, 540, 50, 18);

  fill(0);
  text("other", 318, 560);//そのた
  fill(callcolor(6));
  rect(250, 540, 50, 18);
}

color callcolor(int n) {//色設定、ここは説明するより実行してみた方が色に関してはわかりやすい
  if (n==0) {
    return #ffcabf;
  } else if (n==1) {
    return #ffff80;
  } else if (n==2) {
    return #d8f255;
  } else if (n==3) {
    return #bfe4ff;
  } else if (n==4) {
    return #ffca80;
  } else if (n==5) {
    return #77d9a8;
  } else {
    return #c9ace6;
  }
}
