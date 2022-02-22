class Precios {
  int chaqueta;
  int chaquetaLeontina;
  int chaquetaMurphy;
  int pantalon;
  int talleEspecial;

  Precios(
      {this.chaqueta,
      this.chaquetaLeontina,
      this.chaquetaMurphy,
      this.pantalon,
      this.talleEspecial});

  Precios.fromJson(Map<String, dynamic> json) {
    chaqueta = json['chaqueta'];
    chaquetaLeontina = json['chaqueta_leontina'];
    chaquetaMurphy = json['chaqueta_murphy'];
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
    return data;
  }
}
