
  class Country {
    final String id;
    final String name;
    final String flag;
    final String capital;
    final String region;
    final List<String> languages;

    Country({
      required this.id,
    required this.name,
    required this.flag,
    required this.capital,
    required this.region,
    required this.languages,

  });

    factory Country.fromJson(Map<String, dynamic> json){

      var languagesJson = json['languages'] as Map<String , dynamic>? ?? {};
      var languagesList = languagesJson.values.cast<String>().toList();

      return Country(
        id: json['cca3'],
        name: json['name']['common'],
        flag: json['flags']['png'],
        capital: json['capital'] != null ? json['capital'] [0] : 'No capital' ,
        region: json['region'],
        languages: languagesList,
      );
    }


  }