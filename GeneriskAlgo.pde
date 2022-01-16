ArrayList<Genstand>AlleTing = new ArrayList<Genstand>();
ArrayList<Taske>tasker = new ArrayList<Taske>();

Taske bedst = new Taske(new ArrayList<Genstand>());
Taske Temp;

int AntalIStreg = 0;
boolean redo = true;
float nummer = 1;
float pX, pY, nX, nY;

void setup() {
  size(1000, 500);
  lavAlt();

  fill(0);
  push();
  translate(10, height/2);
  rotate(-PI/2);
  text("Samlet Pris", 0, 0);
  pop();
  text("Tid", width/2, height-10);

  line(15, 0, 15, height-25);
  line(15, height-25, width, height-25);

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
      if (random(0, 4)<1) { // for hver genstand i den bedste taske, der er der en chance for at der bliver valgt en ny tilfældig genstand, ellers så bliver genstaden fra den bedste taske lagt ind i den nye. Dvs. at halvdelen af genstandene er fra den bedste løsning og halvdelen er tilfældige.
        tempPlads = int(random(0, AlleTing.size()));
        tempList.add(AlleTing.get(tempPlads));
        AlleTing.remove(tempPlads);
      } else {
        for (Genstand o : AlleTing) {
          if (G.navn.equals(o.navn)) {
            tempList.add(o);
            AlleTing.remove(o);
            break;
          }
        }
      }
    }
    if (random(0, 5)<random(0, 5)) { // der er også en chance for at der bliver tilføjet eksta genstande.
      tempPlads = int(random(0, AlleTing.size()));
      tempList.add(AlleTing.get(tempPlads));
      AlleTing.remove(tempPlads);
    }
    Temp = new Taske(tempList);
    if (Temp.beregnVegt()<=5000) {
      tasker.add(Temp); // tasken bliver kun lavet som en rigtig løsning, hvis vægten er under 5 kg.
      fill(255);
      noStroke();
      circle(nummer+20, (height+100)-((tasker.get(tasker.size()-1).beregnPris())/2), 1); // der bliver lavet en lille hvid prik for hver løsning
      nummer+= 0.3;
    }
  }

  for (Taske t : tasker) {
    if (t.beregnVegt()<5000) {
      println(t.beregnPris());
      if (t.beregnPris() > bedst.beregnPris()) {
        bedst = t;
        nX = nummer+20;
        nY = (height+100)-(bedst.beregnPris())/2;
        fill(255, 100, 100);
        stroke(0);
        circle(nX, nY, 7);
        line(pX, pY, nX, nY); // der bliver lavet en prik for den bedste løsning, og en linje fra den gamle bedste løsning til den nye.
        pX = nummer+20;
        pY = (height+100)-(bedst.beregnPris())/2;
      }
    }
  }

  if (tempBedstePris == bedst.beregnPris()) {
    AntalIStreg++;
  } else 
  AntalIStreg = 0;

  if (AntalIStreg > 150) { // hvis den laver 150 løsninger i streg der ikke er bedre end den bedste løsning, så stopper den
    println("bedste løsning: " + bedst.beregnPris() + "kr. " + bedst.beregnVegt() + "g");
    for (int i = 0; i < bedst.liste.size(); i++) {
      println(bedst.liste.get(i).navn);
      fill(0);
      text(bedst.liste.get(i).navn, 900, i*20+30);
    }
    fill(0);
    text(bedst.beregnPris() + "kr.", 20, 20);
    text(bedst.beregnVegt() + "g", 20, 35);
    noLoop();
  }
}

void initiate() { // her bliver der genereret nogle helt tilfældige tasker til at starte med.
  int tempVegt = 0;
  int tempPlads;
  for (int i = 0; i < 5; i++) {
    tempVegt = 0;
    ArrayList<Genstand> tempList = new ArrayList<Genstand>();
    while (tempVegt < 5000) {
      tempPlads = int(random(-1, 24));

      boolean redo = true;
      while (redo) {
        redo = false;
        for (Genstand g : tempList) {
          if (AlleTing.get(tempPlads).navn.equals(g.navn)) {
            tempPlads = int(random(-1, 24));
            redo = true;
          }
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
  pX = 20;
  pY = (height+100)-(bedst.beregnPris())/2;
  fill(255, 100, 100);
  stroke(0);
  circle(pX, pY, 7);
}
