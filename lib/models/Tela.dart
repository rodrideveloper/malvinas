class Telas {
  String id;
  String tipo_tela;
  Map<String, dynamic> metros_colores;


  Telas({this.tipo_tela, this.metros_colores});
  Telas.conId(this.id, this.tipo_tela, this.metros_colores);




  factory Telas.fromJson(Map<String, dynamic> json) => Telas(
      
        tipo_tela: json['nombre'],
        metros_colores: json['Colores']
        );
       
      

  Map<String, Object> toJson() => {
        
        'nombre': tipo_tela,
        'Colores': metros_colores,
       
      };
















}



