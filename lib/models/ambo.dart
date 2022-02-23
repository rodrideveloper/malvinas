class Ambo {
  String id;
  String tipo;
  String modelo;
  String tela_principal;
  String color_primario;
  String color_secundario;
  List<dynamic> telas_disponibles;
  String url;

  Ambo(
      {this.id,
      this.tipo,
      this.modelo,
      this.tela_principal,
      this.color_primario,
      this.color_secundario,
      this.telas_disponibles,
      this.url});
  Ambo.for2(
      this.id,
      this.tipo,
      this.modelo,
      this.tela_principal,
      this.color_primario,
      this.color_secundario,
      this.telas_disponibles,
      this.url);

  factory Ambo.fromJson(Map<String, dynamic> json) => Ambo(
        id: json['id'],
        tipo: json['tipo'],
        modelo: json['modelo'],
        tela_principal: json['tela_principal'],
        color_primario: json['color_primario'],
        color_secundario: json['color_secundario'],
        telas_disponibles: json['telas_disponibles'],
        url: json['url'],
      );

  Map<String, Object> toJson() => {
        'id': id,
        'tipo': tipo,
        'modelo': modelo,
        'tela_principal': tela_principal,
        'color_primario': color_primario,
        'color_secundario': color_secundario,
        'telas_disponibles': telas_disponibles,
        'image': url
      };
}
