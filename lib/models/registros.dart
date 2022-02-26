class Registro {
  String ambo_id;
  int precio;
  String colorPrimario;
  String colorSecundario;

  String tela;
  double metros;
  String cortador;

  Registro(
      {this.ambo_id,
      this.precio,
      this.colorPrimario,
      this.colorSecundario,
      this.tela,
      this.metros,
      this.cortador}) {}
  Registro.ob(this.ambo_id, this.precio, this.colorPrimario,
      this.colorSecundario, this.tela, this.metros, this.cortador) {}

  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
        ambo_id: json['ambo_id'],
        precio: json['precio'],
        colorPrimario: json['colorPrimario'],
        colorSecundario: json['colorSecundario'],
        tela: json['tela'],
        metros: json['metros'],
        cortador: json['cortador']);
  }
}
