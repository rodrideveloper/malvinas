import 'dart:ui';
import 'ambo.dart';

class RegistroVentas {
  String id;
  Ambo ambo;
  double precio;
  String image_url;
  bool pagado;

  RegistroVentas(
      {this.id, this.ambo, this.precio, this.image_url, this.pagado});

  factory RegistroVentas.fromJson(Map<String, dynamic> json) => RegistroVentas(
        id: json['id'],
        ambo: json['ambo'],
        image_url: json['image_url'],
        precio: json['precio'],
        pagado: json['pagado'],
      );

  Map<String, Object> toJson() => {
        'id': id,
        'ambo': ambo,
        'image_url': image_url,
        'precio': precio,
        'pagado': pagado
      };
}
