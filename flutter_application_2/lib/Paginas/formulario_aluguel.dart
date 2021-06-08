import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:marido_de_aluguel/Database/connect.dart';

class FormularioAluguel extends StatefulWidget {
  @override
  _FormularioAluguelPageState createState() => _FormularioAluguelPageState();
}

class _FormularioAluguelPageState extends State<FormularioAluguel> {
  String _nome;
  String _cpf;
  int _idade;
  String _valor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedInputField(
                hintText: 'Nome',
                onChanged: (value) {
                  setState(() {
                    _nome = value;
                  });
                },
              ),
              RoundedInputField(
                hintText: 'CPF',
                onChanged: (value) {
                  setState(() {
                    _cpf = value;
                  });
                },
              ),
              RoundedInputField(
                hintText: 'Idade',
                onChanged: (value) {
                  setState(() {
                    _idade = int.parse(value);
                  });
                },
              ),

               RoundedInputField(
                hintText: 'Valor',
                onChanged: (value) {
                  setState(() {
                    _valor = value;
                  });
                },
              ),
              SizedBox(height: size.height * 0.10),
              RoundedButton(
                text: 'Criar novo cadastro para marido de aluguel',
                press: () {
                  Aluguel obj = new Aluguel(_nome, _cpf, _idade, _valor);
                  obj.save().then((value) => Navigator.pop(context));
                },
              ),
              RoundedButton(
                text: 'Cancelar',
                color: black,
                press: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
