import 'package:flutter/material.dart';
import 'package:recipe_app/pages/edit_add.dart';
import 'package:recipe_app/services/receta.dart';
import 'package:share/share.dart';

//Estilos
TextStyle textoBase = TextStyle(fontSize: 15);
TextStyle titulos = TextStyle(fontSize: 30, fontWeight: FontWeight.w800);

class InfoPage extends StatefulWidget {
  final Receta receta;
  InfoPage({this.receta});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receta.nombre),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, widget.receta);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "Ingredientes",
              style: titulos,
            ),
            SizedBox(
              height: 15,
            ),
            Text(widget.receta.ingredientes, style: textoBase),
            SizedBox(
              height: 25,
            ),
            Text(
              "Procedimiento",
              style: titulos,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.receta.procedimiento,
              style: textoBase,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton.icon(
              onPressed: () {
                String compartir =
                    "${widget.receta.nombre}\n\nINGREDIENTES:\n${widget.receta.ingredientes}\n\nPROCEDIMIENTO:\n${widget.receta.procedimiento}";
                Share.share(compartir);
              },
              label: Text(
                "",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue[900],
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            RaisedButton.icon(
              onPressed: () async {
                widget.receta.isDeleted = true;
                Navigator.pop(context, widget.receta);
              },
              label: Text("Borrar", style: TextStyle(color: Colors.white)),
              color: Colors.red[700],
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            RaisedButton.icon(
              onPressed: () async {
                Receta nueva = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAdd(receta: widget.receta)));
                if (nueva != null) {
                  setState(() {
                    widget.receta.nombre = nueva.nombre;
                    widget.receta.ingredientes = nueva.ingredientes;
                    widget.receta.procedimiento = nueva.procedimiento;
                  });
                }
              },
              label: Text("Editar", style: TextStyle(color: Colors.white)),
              color: Colors.green[700],
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
