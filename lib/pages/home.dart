import 'package:flutter/material.dart';
import 'package:recipe_app/services/database.dart';
import 'package:recipe_app/services/receta.dart';
import 'package:recipe_app/pages/edit_add.dart';

class Home extends StatefulWidget {
  final List<Receta> recetasD;
  Home({this.recetasD});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Receta> recetas = List<Receta>();
  var searchController = TextEditingController();

  void filterData(String query) {
    query = query.toLowerCase();
    if (query.isNotEmpty) {
      List<Receta> aux = List<Receta>();
      //Recorremos todos los elementos y vamos chequeando si
      //coinciden con el query.
      widget.recetasD.forEach((element) {
        if (element.nombre.toLowerCase().contains(query)) {
          aux.add(element); //si coinciden lo agregamos a aux
        }
      });
      //Luego de recorrer todos cambiamos recetas por aux.
      setState(() {
        recetas.clear();
        recetas.addAll(aux);
      });
    } else {
      //Si esta vacio ponemos todos los elementos
      setState(() {
        recetas.clear();
        recetas.addAll(widget.recetasD);
      });
    }
  }

  @override
  void initState() {
    recetas.addAll(widget.recetasD);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //data = ModalRoute.of(context).settings.arguments;
    //recetas = data['data'];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title: Text("Recipe Book")),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: TextField(
                controller: searchController,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                decoration: InputDecoration(
                  hintText: "Buscar ",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue, width: 3)),
                ),
                onChanged: (value) {
                  filterData(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 56),
                itemCount: recetas.length,
                itemBuilder: (context, index) {
                  return CardReceta(
                    receta: recetas[index],
                    eliminar: (String nombreReceta) async {
                      setState(() {
                        //Eliminar de la lista
                        recetas.remove(recetas[index]);
                      });
                      //Eliminamos la receta de la base de datos
                      await deleteElement(nombreReceta);
                    },
                    modificar: (Receta nuevaReceta, String oldName) async {
                      //Modificamos la base de datos
                      await updateElement(nuevaReceta, oldName);
                      setState(() {
                        //Modificar de la lista
                        if (nuevaReceta != null) {
                          recetas[index].nombre = nuevaReceta.nombre;
                          recetas[index].ingredientes =
                              nuevaReceta.ingredientes;
                          recetas[index].procedimiento =
                              nuevaReceta.procedimiento;
                          recetas[index].isDeleted = nuevaReceta.isDeleted;
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Receta nueva = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditAdd(receta: null)));
            if (nueva != null) {
              if (nueva.nombre.isNotEmpty &&
                  nueva.ingredientes.isNotEmpty &&
                  nueva.procedimiento.isNotEmpty) {
                //Agregamos a la base de datos
                insertElement(nueva);
                //Agregamos a la lista
                setState(() {
                  recetas.add(nueva);
                  widget.recetasD.add(nueva);
                });
              }
            }
          },
          label: Text("Agregar"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
