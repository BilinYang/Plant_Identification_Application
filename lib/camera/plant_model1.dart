class PlantModel1{
  String? species;
  String? genus;
  String? family;
  String? commonNames;

  PlantModel1(
      {
        this.species,
        this.genus,
        this.family,
        this.commonNames});

  factory PlantModel1.forMap(Map map){
    return PlantModel1(
        species: (map['species'])['scientificNameWithoutAuthor'],
        genus: (map['genus'])['scientificNameWithoutAuthor'],
        family: (map['family'])['scientificNameWithoutAuthor'],
        commonNames: (map['commonNames'])['scientificNameWithoutAuthor']
    );
  }
}

