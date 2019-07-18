void lecture(){//時間割表示
  noStroke();
  fill(255);
  rect(10,60,465,455);//時間割の枠
  stroke(0);
  fill(0);
  for(int n=0; n<5; n++){//時間の遷移の表示
    text(lecday[n],77+80*n,80);
    text(numzero(lecstart[n][0])+":"+numzero(lecstart[n][1]),13,125+85*n);
    text(numzero(lecend[n][0])+":"+numzero(lecend[n][1]),13,155+85*n);
    textSize(15);
    text("↓",31,137+85*n);
    textSize(20);
  }
  for(int n=0; n<5; n++){//講義内容、場所
    for(int i=0; i<5; i++){
      text(lecplan[n][i],70+80*n,100+85*i,85,60);
      text(lecplace[n][i],70+80*n,150+85*i,85,60);
    }
  }
  line(10,60,10,515);
  line(10,60,470,60);
  for(int n=0; n<6; n++){//表の縦横線
      line(67+81*n,60,67+81*n,515);
      line(10,90+85*n,470,90+85*n);
  }
  backplace(580,"メニューに戻る",999);//戻る
}

int busmode=1;
void bustime(){//バス時刻表表示
  wordframe(20,40,220,50,"函館駅前行き");
  if(mouseX>=20 && mouseX<=240 && mouseY>=40 && mouseY<=90 && mousecheck==1){//駅前行きを表示するマウス
    mousecheck=2;
    busmode=1;
    busnow_fun();
    busnow_sta();
  }
  wordframe(240,40,220,50,"未来大学行き");
  if(mouseX>240 && mouseX<=480 && mouseY>=40 && mouseY<=90 && mousecheck==1){//大学行きを表示するマウス
    mousecheck=2;
    busmode=2;
    busnow_fun();
    busnow_sta();
  }
  switch(busmode){
    case 1://駅前行き
    makeframe(40,120,395,400);//外枠
    strokeWeight(5);
    line(140,123,140,517);//中の縦罫線
    line(284,123,284,517);
    strokeWeight(0);
    textSize(25);
    text("未来大学発",150,150);//発着表示
    text("函館駅前着",292,150);
    textSize(20);
    strokeWeight(2);
    for(int i=0; i<bus_to_sta.length; i++){
      line(42,154+i*30,433,154+i*30);//中の横罫線
    }
    strokeWeight(0);
    for(int i=0; i<bus_to_sta.length; i++){
      text(numzero(bus_to_sta[i][0])+":"+numzero(bus_to_sta[i][1]),187,177+30*i);//時刻表示
      text(numzero(bus_to_sta[i][2])+":"+numzero(bus_to_sta[i][3]),330,177+30*i);
    }
    for(int i=0; i<bustime_sta.length-1; i++){//次のバス表示
      if(bustime_sta[0]){//もし最初のバスが次のバスなら
        pointright(135,170,42);
        text("NEXT",50,177);
      }
      if(i>0){//最初のバス以外が次のバスなら
        if(!bustime_sta[i] && bustime_sta[i+1]){
          pointright(135,170+30*(i+1),42);
          text("NEXT",50,177+30*(i+1));
        }
      }
    }
    break;
    
    case 2://未来大行き
    makeframe(40,95,395,485);//外枠
    strokeWeight(5);
    line(140,100,140,573);//縦罫線
    line(284,100,284,573);
    strokeWeight(0);
    textSize(25);
    text("函館駅前発",150,125);//発着表示
    text("未来大学着",292,125);
    textSize(20);
    strokeWeight(2);
    for(int i=0; i<bus_to_fun.length; i++){
      line(42,130+i*30,433,130+i*30);//横罫線
    }
    strokeWeight(0);
    for(int i=0; i<bus_to_fun.length; i++){
      text(numzero(bus_to_fun[i][0])+":"+numzero(bus_to_fun[i][1]),187,151+30*i);//時刻表示
      text(numzero(bus_to_fun[i][2])+":"+numzero(bus_to_fun[i][3]),330,151+30*i);
    }
    for(int i=0; i<bustime_fun.length-1; i++){//次のバス表示
      if(bustime_fun[0]){//もし最初のバスが次のバスなら
        pointright(135,145,42);
        text("NEXT",50,152);
      }
      if(i>0){
        if(!bustime_fun[i] && bustime_fun[i+1]){//最初のバス以外が次のバスなら
          pointright(135,145+30*(i+1),42);
          text("NEXT",50,152+30*(i+1));
        }
      }
    }
    break;
  }
  backplace(580,"メニューに戻る",998);//戻る
}
