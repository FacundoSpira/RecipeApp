import 'package:recipe_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/services/receta.dart';
import 'package:recipe_app/services/database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

void getData(BuildContext context) async {
  List<Receta> data = await getDataFromDatabase();
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Home(recetasD: data)));
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    //Obtener los datos.
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }
}
