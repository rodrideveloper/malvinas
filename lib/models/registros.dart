class Registro {
  String nombre;
  int talleChaqueta;
  int tallePantalon;
  String colorPrimario;
  String colorSecundario;
  String tela;
  double metros;
  String cortador;

  Registro(
      {this.nombre,
      this.talleChaqueta,
      this.tallePantalon,
      this.colorPrimario,
      this.colorSecundario,
      this.tela,
      this.metros,
      this.cortador}) {}
  Registro.ob(
      this.nombre,
      this.talleChaqueta,
      this.tallePantalon,
      this.colorPrimario,
      this.colorSecundario,
      this.tela,
      this.metros,
      this.cortador) {}

  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
        nombre: json['nombreAmbo'],
        talleChaqueta: json['talleChaqueta'],
        tallePantalon: json['tallePantalon'],
        colorPrimario: json['colorPrimario'],
        colorSecundario: json['colorSecundario'],
        tela: json['tela'],
        metros: json['metros'],
        cortador: json['cortador']);
  }
}
