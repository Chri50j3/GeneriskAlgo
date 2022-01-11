ArrayList<Genstand>AlleTing = new ArrayList<Genstand>();
ArrayList<Taske>tasker = new ArrayList<Taske>();

Taske bedst = new Taske(new ArrayList<Genstand>());

int AntalIStreg = 0;
boolean redo = true;
int nummer = 1;

void setup() {
  size(1000,500);
  lavAlt();
  initiate();
}

void draw() {
  int tempBedstePris = bedst.beregnPris();
  tasker.clear();

  int tempPlads;
  for (int i = 0; i < 50; i++) {
    ArrayList<Genstand> tempList = new ArrayList<Genstand>();
    AlleTing.clear();
    lavAlt();
    for (Genstand G : bedst.liste) {
      if (random(0, 5)<1) {
        tempPlads = int(random(0, AlleTing.size()));
        tempList.add(AlleTing.get(tempPlads));
        AlleTing.remove(tempPlads);
      }
      else{
        for(Genstand o : AlleTing){
          if(G.navn.equals(o.navn)){
            tempList.add(o);
            AlleTing.remove(o);
            break;
          }
        }
      }
    }
    tasker.add(new Taske(tempList));
    circle(nummer/10,height-((tasker.get(tasker.size()-1).beregnPris())/3),2);
    nummer++;
  }

  for (Taske t : tasker) {
    if (t.beregnVegt()<5000) {
      println(t.beregnPris());
      if (t.beregnPris() > bedst.beregnPris())
        bedst = t;
    }
  }

  if (tempBedstePris == bedst.beregnPris()) {
    AntalIStreg++;
  }
  else 
    AntalIStreg = 0;

  if (AntalIStreg > 100) {
    println("bedste løsning: " + bedst.beregnPris() + "kr. " + bedst.beregnVegt() + "g");
    for (int i = 0; i < bedst.liste.size(); i++) {
      println(bedst.liste.get(i).navn);
    }
    noLoop();
  }
}

void initiate() {
  int tempVegt = 0;
  int tempPlads;
  for (int i = 0; i < 50; i++) {
    tempVegt = 0;
    ArrayList<Genstand> tempList = new ArrayList<Genstand>();
    while (tempVegt < 5000) {
      tempPlads = int(random(-1, 24));

      for (Genstand g : tempList) {
        while (AlleTing.get(tempPlads).navn.equals(g.navn)) {
          tempPlads = int(random(-1, 24));
        }
      }

      tempVegt += AlleTing.get(tempPlads).vegt;
      if (tempVegt < 5000)
        tempList.add(AlleTing.get(tempPlads));
    }
    tasker.add(new Taske(tempList));
  }
  for (Taske t : tasker) {
    if (t.beregnVegt()<5000) {
      println(t.beregnPris());
      if (t.beregnPris() > bedst.beregnPris())
        bedst = t;
    }
  }
  println("done ");
}
