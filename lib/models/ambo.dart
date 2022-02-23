class Ambo {
  String id;
  String tipo;
  String modelo;
  List<dynamic> telas_disponibles;
  String url;

  Ambo({this.id, this.tipo, this.modelo, this.telas_disponibles, this.url});
  Ambo.for2(this.id, this.tipo, this.modelo, this.telas_disponibles, this.url);

  factory Ambo.fromJson(Map<String, dynamic> json) => Ambo(
        id: json['id'],
        tipo: json['tipo'],
        modelo: json['modelo'],
        telas_disponibles: json['telas_disponibles'],
        url: json['url'],
      );

  Map<String, Object> toJson() => {
        'id': id,
        'tipo': tipo,
        'modelo': modelo,
        'telas_disponibles': telas_disponibles,
        'image': url
      };
}
