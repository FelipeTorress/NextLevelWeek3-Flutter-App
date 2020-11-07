import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Developed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlue),
            accountName: Text('Developer: Felipe da Rocha Torres',style: TextStyle(fontSize: 13.0),),
            accountEmail: Text('Email: felipetorress@ufpi.edu.br',style: TextStyle(fontSize: 13.0),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars1.githubusercontent.com/u/47922504?s=460&v=4',),
            ),
          ),
          GestureDetector(
            child:
            Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.link,color: Colors.blue,),
                    Text(
                      'GitHub',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                        fontFamily: 'GloriaHallelujah',
                      ),
                    ),
                  ],
                )
            ),
            onTap: (){
              _githubUrl();
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.link,color: Colors.blue,),
                  Text(
                    'Repositório',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      fontFamily: 'GloriaHallelujah'
                    ),
                  ),
                ],
              ),
            ),
            onTap: (){
              _repositoryUrl();
            },
          )
        ],
      ),
    );
  }
  _githubUrl() async {
    const url = 'https://github.com/FelipeTorress';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _repositoryUrl() async {
    const url = 'https://github.com/FelipeTorress/Happy_app_nlw';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
}