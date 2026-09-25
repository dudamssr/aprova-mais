class Usuario {
  final int id;
  final String nome;
  final String email;
  final String tipo;
  final String? dataCadastro;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.tipo,
    this.dataCadastro,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      tipo: json['tipo'] ?? 'ALUNO',
      dataCadastro: json['dataCadastro'],
    );
  }
}
