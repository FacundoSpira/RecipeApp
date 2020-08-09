import 'package:flutter/material.dart';
import 'package:recipe_app/pages/infoPage.dart';

class Receta {
  String nombre;
  String ingredientes;
  String procedimiento;
  bool isDeleted;

  Receta(
      {this.nombre,
      this.ingredientes,
      this.procedimiento,
      this.isDeleted = false});
}

class CardReceta extends StatelessWidget {
  final Receta receta;
  final Function eliminar;
  final Function modificar;
  CardReceta({this.receta, this.eliminar, this.modificar});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String oldName = receta.nombre;
        Receta salida = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => InfoPage(receta: receta)));
        if (salida != null) {
          (salida.isDeleted)
              ? eliminar(salida.nombre)
              : modificar(salida, oldName);
        }
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                receta.nombre,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 22),
              ),
              Icon(
                Icons.arrow_forward_ios,
              )
            ],
          ),
        ),
      ),
    );
  }
}
