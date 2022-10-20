class Cupom {
  String? id;
  String? nome;
  String? telefone;
  String? cpf;
  String? compra;
  String? desconto;
  bool? validade;

  Cupom({this.id, this.nome, this.telefone, this.cpf, this.compra, this.desconto, this.validade});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "telefone": telefone,
      "cpf": cpf,
      "compra": compra,
      "desconto" : desconto,
      "validade" : validade,
    };
  }

  factory Cupom.fromJson(Map<String, dynamic> json) {
    return Cupom(
      id: json["id"],
      nome: json["nome"],
      telefone: json["telefone"],
      cpf: json["cpf"],
      compra: json["compra"],
      desconto: json["desconto"],
      validade: json["validade"],
    );
  }
}