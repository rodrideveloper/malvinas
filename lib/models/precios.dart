class Precios {
  int chaqueta;
  int chaquetaLeontina;
  int chaquetaMurphy;
  int pantalon;
  int chaqueta_abierta;
  int talleEspecial;

  Precios(
      {this.chaqueta,
      this.chaquetaLeontina,
      this.chaqueta_abierta,
      this.chaquetaMurphy,
      this.pantalon,
      this.talleEspecial});

  Precios.fromJson(Map<String, dynamic> json) {
    chaqueta = json['chaqueta'];
    chaquetaLeontina = json['chaqueta_leontina'];
    chaquetaMurphy = json['chaqueta_murphy'];
    chaqueta_abierta = json['chaqueta_abierta'];
    pantalon = json['pantalon'];
    talleEspecial = json['talle_especial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chaqueta'] = this.chaqueta;
    data['chaqueta_leontina'] = this.chaquetaLeontina;
    data['chaqueta_murphy'] = this.chaquetaMurphy;
    data['pantalon'] = this.pantalon;
    data['talle_especial'] = this.talleEspecial;
    data['chaqueta_abierta'] = this.chaqueta_abierta;
    return data;
  }
}
