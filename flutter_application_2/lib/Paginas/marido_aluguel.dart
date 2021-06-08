import 'package:flutter/material.dart';
import 'package:flutter_application_1/Database/main.dart';
import 'package:marido_de_aluguel/Database/connect.dart';
import 'package:marido_de_aluguel/Paginas/formulario_aluguel';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Aluguel> _aluguel = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: Aluguel.list(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.data != null) {
                        _aluguel = snapshot.data;

                        if (_aluguel.length == 0) return Text('Sem cadastro.');

                        return ListView.builder(
                          itemCount: _aluguel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: AluguelItem(
                                aluguel: _aluguel[index],
                              ),
                              Navigator: () {
                                _aluguel[index]
                                    .remove()
                                    .then((value) => {setState(() {})});
                              },
                            );
                          },
                        );
                      } else {
                        return Text('Processando..');
                      }
                    }
                  },
                ),
              ),
            ),
            RoundedButton(
              text: 'ADICIONAR MARIDO DE ALUGUEL',
              press: this.navigateToFormularioAluguel,
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  void navigateToFormularioAluguel() {
    Route route =
        MaterialPageRoute(builder: (context) => FormularioAluguelPage());
    Navigator.push(context, route).then((value) => {setState(() {})});
  }
}
