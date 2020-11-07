import 'package:url_launcher/url_launcher.dart';
class UrlHelper{

  void openWhatsApp(number){
    String url = 'https://wa.me/$number';
    _launchURL(url);
  }

   void callNumber(number){
     launch("tel:$number");
   }

   void routeGoogle (url){
     _launchURL(url);
   }

}
_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}