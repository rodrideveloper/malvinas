import 'ambo.dart';

class RegistroVentas {
  String id;
  String id_registro;
  Ambo ambo;
  int precio;
  String image_url;
  bool pagado=false;

  RegistroVentas(
      {this.id,this.id_registro,this.ambo, this.precio, this.image_url, this.pagado});

  factory RegistroVentas.fromJson(Map<String, dynamic> json) => RegistroVentas(
        id: json['ambo_id'],
        id_registro:json['id_registro'],
        ambo: json['ambo'],
        image_url: json['image_url'],
        precio: json['precio'],
        pagado: json['pagado'],
      );

  Map<String, Object> toJson() => {
        'id': id,
        'id_registro':  id_registro,
        'ambo': ambo,
        'image_url': image_url,
        'precio': precio,
        'pagado': pagado
      };
}
