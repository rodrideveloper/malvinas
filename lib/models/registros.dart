class Registro {
  String ambo_id;
  int precio;
  String colorPrimario;
  String colorSecundario;

  String tela;
  double metros;
  String cortador;
  DateTime fecha;

  Registro(
      {this.ambo_id,
      this.precio,
      this.colorPrimario,
      this.colorSecundario,
      this.tela,
      this.metros,
      this.cortador, this.fecha}) {}
  Registro.ob(this.ambo_id, this.precio, this.colorPrimario,
      this.colorSecundario, this.tela, this.metros, this.cortador,this.fecha) {}

  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
        ambo_id: json['ambo_id'],
        precio: json['precio'],
        colorPrimario: json['colorPrimario'],
        colorSecundario: json['colorSecundario'],
        tela: json['tela'],
        metros: json['metros'],
        cortador: json['cortador'],
        fecha:json['fecha']);
  }
}
