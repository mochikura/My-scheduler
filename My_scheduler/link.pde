int linkplace=1;
int linkmax, linkmin=1;
void linkdis(){//リンク飛び
  linkmax=link_type.length/5;
  textAlign(CENTER);
  textSize(45);
    if(linkplace*5<=link_type.length){//もし、表示してる画面でロードしたリンクが終わるなら
      for(int n=(linkplace-1)*5; n<linkplace*5; n++){
        makeframe(50,60+100*n-100*(linkplace-1)*5,380,90);//外枠
        text(link_type[n][0],width/2,130+100*n-100*(linkplace-1)*5);//途中で外枠も文字も終わりにする
        if(mouseX>=50 && mouseX<=430 
        && mouseY>=60+100*n-100*(linkplace-1)*5 
        && mouseY<=150+100*n-100*(linkplace-1)*5 && mousecheck==1){//その各枠を押すとリンクに飛ぶ
          link(link_type[n][1]);
          mousecheck=2;
        }
      }
    }
    if(5*linkplace>link_type.length){//もし、表示している画面でロードしたリンクが終わるなら
      for(int n=(linkplace-1)*5; n<link_type.length; n++){
        makeframe(50,60+100*n-100*(linkplace-1)*5,380,90);//外枠
        text(link_type[n][0],width/2,130+100*n-100*(linkplace-1)*5);//一画面最大の5個のリンクを表示する
        if(mouseX>=50 && mouseX<=430 
        && mouseY>=60+100*n-100*(linkplace-1)*5 
        && mouseY<=150+100*n-100*(linkplace-1)*5 && mousecheck==1){//該当する枠を押すとリンクに飛ぶ
          link(link_type[n][1]);
          mousecheck=2;
        }
      }
    }
    if(linkplace<=linkmax){//もし枠数がおわりでないなら1ページ先に進める
       beginShape();
       vertex(475,315);
       vertex(450,290);
       vertex(450,340);
       vertex(475,315);
       endShape(CLOSE);
       if(mouseX>=445 && mouseX<=480 && mouseY>=290 && mouseY<=340 && mousecheck==1){
         linkplace++;;
         mousecheck=2;
       }
     }
    if(linkplace>1){//もし枠が最初以外であれば1ページ前に戻せる
      beginShape();
      vertex(5,315);
      vertex(28,290);
      vertex(28,340);
      vertex(5,315);
      endShape(CLOSE);
      if(mouseX>=0 && mouseX<=30 && mouseY>=290 && mouseY<=340 && mousecheck==1){
        linkplace--;
        mousecheck=2;
      }
    }
  textAlign(LEFT);
  backplace(580,"メニューに戻る",998);//戻る
}

String[][] link_type;
void loadlink(){//リンクのロード、実際いくらでも登録可能
  String[] link=loadStrings("linklist.txt");
  link_type=new String [link.length][2];
  for(int n=0; n<link.length; n++){
    link_type[n]=link[n].split(",");//０はリンクの名前、１はURL
  }
}
