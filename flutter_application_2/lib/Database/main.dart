import 'package:flutter/material.dart';
import 'package:marido_de_aluguel/Database/connect.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Aluguel {
  String nome;
  String cpf;
  int idade;
  double valorDiaria;
  Database _connect;

  Aluguel(this.nome, this.cpf, this.idade, this.valorDiaria);

  Future<int> count() async {
    var query = await _connect.rawQuery('SELECT COUNT(*) FROM aluguel');
    return Sqflite.firstIntValue(query);
  }

  Future<void> save() async {
    this._connect = await Conecta.dataBaseManager();
    int diaria = await this.count();

    if (diaria >= 3) {
      AlertDialog(
        title: Text('Numero máximo de trabalho por dia'),
      );
      return;
    }

    if (this.idade >= 18) {
      int calculo = (10 * 0.10).ceil();
      this.valorDiaria = diaria <= calculo ? 13 : 36;
    } else {
      this.valorDiaria = 0;
    }

    Map<String, dynamic> dadosTask = {
      "nome": this.nome,
      "cpf": this.cpf,
      "idade": this.idade,
      "valor": this.valorDiaria
    };

    await _connect.insert("aluguel", dadosTask);
    print('aluguel ${this.nome} salvo');
  }

  static List<Diarias> convertList(query) {
    List<Diarias> list = [];
    for (var item in query) {
      var diaria = new Aluguel(
          item['nome'], item['cpf'], item['idade'], item['valor']);
      diaria.valorDiaria = double.parse(item['valor'].toString());
      list.add(diaria);
    }
    return list;
  }

  static Future<List<Diarias>> list() async {
    Database connect = await Conecta.dataBaseManager();

    var query = await connect.query('aluguel');
    return Diarias.convertList(query.toList());
  }
}
