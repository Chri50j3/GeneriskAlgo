ArrayList<Genstand>AlleTing = new ArrayList<Genstand>();
ArrayList<Taske>tasker = new ArrayList<Taske>();

Taske bedst = new Taske(new ArrayList<Genstand>());

int AntalIStreg = 0;

void setup() {
  AlleTing.add(new Genstand("Kort", 90, 150));
  AlleTing.add(new Genstand("Kompas", 130, 35));
  AlleTing.add(new Genstand("Vand", 1530, 200));
  AlleTing.add(new Genstand("Sandwich", 500, 160));
  AlleTing.add(new Genstand("Sukker", 150, 60));
  AlleTing.add(new Genstand("Dåsemad", 680, 45));
  AlleTing.add(new Genstand("Banan", 270, 60));
  AlleTing.add(new Genstand("Æbler", 390, 40));
  AlleTing.add(new Genstand("Ost", 230, 30));
  AlleTing.add(new Genstand("Øl", 520, 10));
  AlleTing.add(new Genstand("Solcreme", 110, 70));

  AlleTing.add(new Genstand("Kamera", 320, 30));
  AlleTing.add(new Genstand("T-shirt", 240, 15));
  AlleTing.add(new Genstand("Bukser", 480, 10));
  AlleTing.add(new Genstand("Paraply", 730, 40));
  AlleTing.add(new Genstand("Vandtætte bukser", 420, 70));
  AlleTing.add(new Genstand("Vandtæt overtøj", 430, 75));
  AlleTing.add(new Genstand("Pung", 220, 80));
  AlleTing.add(new Genstand("Solbriller", 70, 20));
  AlleTing.add(new Genstand("Håndklæde", 180, 12));
  AlleTing.add(new Genstand("Sokker", 180, 12));
  AlleTing.add(new Genstand("Bog", 300, 10));
  AlleTing.add(new Genstand("Notesbog", 900, 1));
  AlleTing.add(new Genstand("Telt", 2000, 150));

  initiate();
}

void draw() {
  int tempBedstePris = bedst.beregnPris();
  tasker.clear();

  int tempVegt = 0;
  int tempPlads;
  for (int i = 0; i < 50; i++) {
    tempVegt = 0;
    ArrayList<Genstand> tempList = new ArrayList<Genstand>();
    while (tempVegt < 5000) {
      if (int(random(0, 2))<=1) {
        tempPlads = int(random(-1, 24));

        for (Genstand g : tempList) {
          while (AlleTing.get(tempPlads).navn.equals(g.navn)) {
            tempPlads = int(random(-1, 24));
          }
        }

        tempVegt += AlleTing.get(tempPlads).vegt;
        if (tempVegt < 5000)
          tempList.add(AlleTing.get(tempPlads));
      } else {
        tempPlads = tempList.size();
        tempVegt += bedst.liste.get(tempPlads).vegt;

        for (Genstand g : tempList) {
          while (bedst.liste.get(tempPlads).navn.equals(g.navn)) {
            tempPlads++;
          }
        }

        if (tempVegt < 5000)
          tempList.add(bedst.liste.get(tempPlads));
      }
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

  if (tempBedstePris == bedst.beregnPris()) {
    AntalIStreg++;
  }

  if (AntalIStreg > 100) {
    println("bedste løsning: " + bedst.beregnPris() + "kr. " + bedst.beregnVegt() + "g");
    for(int i = 0 ; i < bedst.liste.size(); i++){
      println(bedst.liste.get(i).navn);
    }
    noLoop();
    exit();
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
