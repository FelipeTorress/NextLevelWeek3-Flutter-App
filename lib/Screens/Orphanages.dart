import 'package:flutter/material.dart';

import 'package:happy_app/Screens/CreateOrphanage.dart';
import 'package:happy_app/widgets/DataBase_helper.dart';
import 'package:happy_app/widgets/Developed.dart';
import 'package:happy_app/widgets/UrlHelper.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:happy_app/widgets/Orphanage.dart';
import 'package:latlong/latlong.dart';
import 'package:meet_network_image/meet_network_image.dart';

class Orphanages extends StatefulWidget {
  @override
  _OrphanagesState createState() => _OrphanagesState();
}

class _OrphanagesState extends State<Orphanages> {
  DbHelper dbHelper = DbHelper();
  List<Orphanage> orphanages = List();
  Orphanage of;

  @override
  void initState() {
    super.initState();
    _salvar();
    _getAllOrphanages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orfanatos', style: TextStyle(fontFamily: 'GloriaHallelujah')),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: Developed(),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(-5.0885387,-42.8043192),
          zoom: 15.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            tileProvider: CachedNetworkTileProvider(),
          ),
          new MarkerLayerOptions(
            markers:_generateMarkers(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Orfanato',
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
        onPressed: (){
          Navigator.of(context).push(_createRoute());
        },
      ),
    );
  }

  _generateMarkers() {
    List<Marker> marker = List<Marker>();
    orphanages.forEach((element) {
      marker.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point:  LatLng(double.parse(element.lat), double.parse(element.lng)),
            builder: (ctx) => Container(
              child: new GestureDetector(
                child: Container(
                  child: Image.asset(
                    'assets/images/logo-icon.png',
                  ),
                ),
                onTap: (){
                  _infoOrphanage(element);
                },
              ),
            ),
          )
      );
    });
    return marker;
  }

  _infoOrphanage(Orphanage orphanage){
    return showModalBottomSheet(context: context,
        builder: (builder){
          return Scaffold(
            appBar: AppBar(
              title: Text(orphanage.name, style: TextStyle(fontFamily: 'GloriaHallelujah')),
              backgroundColor: Colors.lightBlue,
              elevation: 0.0,
              actions: [
                IconButton(icon: Icon(Icons.add_location_outlined),
                    onPressed: (){UrlHelper().routeGoogle("https://maps.google.com/mobile?q=${orphanage.lat},${orphanage.lng}&z=15");}
                ),
                IconButton(icon: Icon(Icons.call),
                    onPressed: (){UrlHelper().callNumber(orphanage.whatsapp);}
                ),
                IconButton(icon: Image.asset('assets/images/zap.png', fit: BoxFit.fill, width: 25,),
                    onPressed: (){
                      UrlHelper().openWhatsApp(orphanage.whatsapp);
                    }
                ),
              ],
            ),
            body: _listViewOrphanage(orphanage)
          );
        }
    );
  }

  _listViewOrphanage(Orphanage orphanage){
    return ListView(
        children: [
          MeetNetworkImage(
            imageUrl: orphanage.images,
            loadingBuilder: (context) => Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: CircularProgressIndicator(),
              ),
            ),
            errorBuilder: (context, e) => Center(
              child: Text('Error appear!'),
            ),
          ),
          _createCard('sobre', orphanage.about, Colors.black),

          _createCard('Número', orphanage.whatsapp, Colors.black),

          _createCard('Intruções', orphanage.instructions, Colors.black),

          _createCard('Horários', orphanage.opening_hour, Colors.black),

          orphanage.open_on_weekends == '1'?
              _createCard('Aberto fins de semana', 'Abre nos fins de semana', Colors.green)
              :
              _createCard('Aberto fins de semana', 'Não abre no fim de semana', Colors.redAccent)
        ],
      );
  }

  _createCard(label, data, color){
    return Card(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Text('$label: ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
          Padding(
            padding: EdgeInsets.only(left: 5.0,bottom: 10.0),
            child: Text(data,style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold, color: color),),
          )
        ],
      ),
    );
  }

  _getAllOrphanages(){
    dbHelper.getAllOrphanages().then((value){
      setState(() {
        orphanages=value;
      });
    });
  }

  void _salvar() async {
    String img = "https://aventurasnahistoria.uol.com.br/media/_versions/design_sem_nome_73_widelg.jpg";
    of.lat='-5.0772226';of.lng='-42.8035528';of.name='Shop';of.open_on_weekends='0';
    of.opening_hour='Todos os dias de 8h as 16h';of.instructions='Venha visitar o Felipe';of.whatsapp='86999021985';
    of.about='Casa do Felipe Torres';of.images=img;
    await dbHelper.saveOrphanage(of);
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CreateOrphanage(),

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
