import 'package:flutter/material.dart';

import 'package:happy_app/Screens/Orphanages.dart';
import 'package:happy_app/widgets/InternetCheck.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo-icon.png',
                      width: 30,
                    ),
                    SizedBox(width: 3,),
                    Text('Happy', style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'GloriaHallelujah',
                        fontWeight: FontWeight.bold)
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Text(
                    'Leve felicidade para o mundo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GloriaHallelujah',
                    ),
                  ),
                ),

                Image.asset(
                  'assets/images/kids.png',
                ),

                Padding(
                  padding: EdgeInsets.only(left: 14.0,right: 14.0),
                  child: Text(
                    'Visite orfanatos e mude o dia de várias crianças',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GloriaHallelujah',
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Orfanatos',
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.amber,

        onPressed: (){
          InternetCheck().internetCheck().then((value){
            value?
            Navigator.push(context, MaterialPageRoute(builder: (context) => Orphanages()),)
                :
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return _alert(context);
              },
            );
          });
        },

      ),
    );
  }

  _alert(context){
    return AlertDialog(
      title: Text('Sem conexão a internet!'),
      content: Text('Verifique sua conexão com a intenet e tente novamente'),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
          }, child: Text('OK'))
      ],
    );
  }
}

