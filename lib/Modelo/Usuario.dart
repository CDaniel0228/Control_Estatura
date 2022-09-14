// ignore_for_file: file_names
class Usuario{
  String? nombre;
  String? genero;
  String? edad;
  double? peso;
  double? estatura;

  Usuario({this.nombre, this.genero, this.edad, this.peso, this.estatura});
  Usuario.fromMap(Map<String, dynamic> item): 
    nombre=item["nombre"], genero=item["genero"],edad=item["edad"],peso=item["peso"],estatura=item["estatura"]; 

  Map<String, dynamic> toMap() {
    return {
    'nombre': nombre, 
    'genero': genero,
    'edad': edad,
    'peso':peso,
    'estatura': estatura};
  }
}