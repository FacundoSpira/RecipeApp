import 'package:flutter/material.dart';
import 'package:recipe_app/pages/infoPage.dart';
import 'package:recipe_app/services/receta.dart';

class EditAdd extends StatefulWidget {
  final Receta receta;
  EditAdd({this.receta});

  @override
  _EditAddState createState() => _EditAddState();
}

class _EditAddState extends State<EditAdd> {
  var _controladorNombre = TextEditingController();
  var _controladorIngredientes = TextEditingController();
  var _controladorProcedimiento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.receta != null) {
      _controladorNombre.text = widget.receta.nombre;
      _controladorIngredientes.text = widget.receta.ingredientes;
      _controladorProcedimiento.text = widget.receta.procedimiento;
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Text("Nombre", style: titulos),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controladorNombre,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 3)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Ingredientes", style: titulos),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controladorIngredientes,
                  maxLines: null,
                  minLines: 12,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 3)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Procedimiento", style: titulos),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _controladorProcedimiento,
                  maxLines: null,
                  minLines: 12,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue, width: 3)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(
              context,
              Receta(
                  nombre: _controladorNombre.text,
                  ingredientes: _controladorIngredientes.text,
                  procedimiento: _controladorProcedimiento.text,
                  isDeleted: false));
        },
        label: Text("GUARDAR"),
        icon: Icon(Icons.save),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}
