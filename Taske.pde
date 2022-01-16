// Klassen Taske indeholder en ArrayListe med de genstande der er i tasken, og har to metoder, der kan beregne taksens samlede pris og vægt.

class Taske{
  ArrayList<Genstand>liste;
  int samletPris;
  int samletVegt;
  
  Taske(ArrayList<Genstand>liste_){
    liste = liste_;
    
    for(Genstand r: liste){
      samletPris += r.pris;
      samletVegt += r.vegt;
    }
  }
  
  int beregnVegt(){
    samletVegt = 0;
      for(Genstand r: liste){
      samletVegt += r.vegt;
    }
    return samletVegt;
  }
  int beregnPris(){
    samletPris = 0;
      for(Genstand r: liste){
      samletPris += r.pris;
    }
    return samletPris;
  }
  
}
