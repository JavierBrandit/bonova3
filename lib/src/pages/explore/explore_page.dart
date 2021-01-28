import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/pages/explore/busqueda.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:bonova0002/src/widgets/reproductor_video.dart';
import 'package:bonova0002/theme.dart';
// import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Curso cursoSeleccionado;
  List<Curso> historial = [];
  final cursoService = CursoService();
  List<Curso> cursosMate = [];

  @override
  void initState() { 
    _cargarPrimero();
    // getPermissions();
    super.initState();
  }

  // List<Curso> contacts = [];
  // List<Curso> contactsFiltered = [];
  // Map<String, Color> contactsColorMap = new Map();
  // TextEditingController searchController = new TextEditingController();

  // getPermissions() async {
  //   if (await Permission.contacts.request().isGranted) {
  //     getAllContacts();
  //     searchController.addListener(() {
  //       filterContacts();
  //     });
  //   }
  // }

  // String flattenPhoneNumber(String phoneStr) {
  //   return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
  //     return m[0] == "+" ? "+" : "";
  //   });
  // }

  // getAllContacts() async {
  //   List colors = [
  //     Colors.green,
  //     Colors.indigo,
  //     Colors.yellow,
  //     Colors.orange
  //   ];
  //   int colorIndex = 0;
  //   List<Curso> _contacts = (await cursoService.getAllCursos()).toList();
  //   _contacts.forEach((contact) {
  //     Color baseColor = colors[colorIndex];
  //     contactsColorMap[contact.displayName] = baseColor;
  //     colorIndex++;
  //     if (colorIndex == colors.length) {
  //       colorIndex = 0;
  //     }
  //   });
  //   setState(() {
  //     contacts = _contacts;
  //   });
  // }

  // filterContacts() {
  //   List<Curso> _contacts = [];
  //   _contacts.addAll(contacts);
  //   if (searchController.text.isNotEmpty) {
  //     _contacts.retainWhere((contact) {
  //       String searchTerm = searchController.text.toLowerCase();
  //       String searchTermFlatten = flattenPhoneNumber(searchTerm);
  //       String contactName = contact.displayName.toLowerCase();
  //       bool nameMatches = contactName.contains(searchTerm);
  //       if (nameMatches == true) {
  //         return true;
  //       }

  //       if (searchTermFlatten.isEmpty) {
  //         return false;
  //       }

  //       var phone = contact.phones.firstWhere((phn) {
  //         String phnFlattened = flattenPhoneNumber(phn.value);
  //         return phnFlattened.contains(searchTermFlatten);
  //       }, orElse: () => null);

  //       return phone != null;
  //     });
  //   }
  //   setState(() {
  //     contactsFiltered = _contacts;
  //   });
  // }


  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final pantalla = MediaQuery.of(context).size; 
    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [

         _appBar(isDarkTheme, pantalla),
         SliverToBoxAdapter(
           child: Wrap(
             children: [
              Container(height: 15),

              cajaListaRamo(cursosMate, 'Matematica'),
              cajaListaRamo(cursosMate, 'Fisica'),

              Container(height: 100)
             ],
    ))]));

  }

  cajaListaRamo(List<Curso> cursos, String logo){
    return Stack( 
      alignment: AlignmentDirectional.topEnd,
      children: [
      cajaBorde([
        Container(
          padding: EdgeInsets.symmetric(horizontal: 0),
          // height: 150,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: cursosMate.length,
            itemBuilder: (_, i) => listTileInfo(cursos[i])
        )),


      ]),
      logoRamo(logo),
              ]);
  }

  SliverAppBar _appBar(bool dark, Size pantalla){
    return SliverAppBar(
          //  toolbarHeight: 90,
           pinned: true,
           flexibleSpace: FlexibleSpaceBar(
             centerTitle: true,
             title: Container(
                  padding: EdgeInsets.symmetric( horizontal: 20 ),
                  height: 40,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1.8, color: dark ? Colors.tealAccent[700] : Colors.tealAccent[400]),
                    // color: BonovaColors.azulNoche[800],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                    Icon( FluentIcons.search_24_filled, size: 17, ),
                    SizedBox(width: 15),
                    Expanded(child: 
                    Text('¿Qué aprendemos hoy?', 
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: dark ? Colors.teal.withOpacity(0.5) : Colors.grey[400] ))
                    )
                  ]),
                ),
             ),
          actions: [
            Container(
              width: pantalla.width,
              child: GestureDetector(
                onTap: () async {
                  final curso = await showSearch(
                    context: context, 
                    delegate: CursosSearchDelegate('', historial )
                  );
                  setState(() {
                    this.cursoSeleccionado = curso;
                    this.historial.insert(0, curso);
                  });
                }
              ),
            )
          ],
         );
  }

  _cargarPrimero() async {
    this.cursosMate = await cursoService.getCursos('matematica', '1');
    setState((){});
  }

  listTileInfo( Curso curso ){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [

            Padding(
              padding: EdgeInsets.only(right: 23),
              child:  Container(height: 40, width: 25, child: Image.network(curso.portada, fit: BoxFit.cover,)) //Icon(FluentIcons.play_20_regular , size: 17),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(curso.titulo, style: TextStyle(fontWeight: FontWeight.w500),),
                Text(curso.nivel+'º medio  ·  '+curso.videos.length.toString()+' videos', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
              ],
            )
        ]),
      ),
      onTap: (){
        final videoService = Provider.of<VideoService>(context, listen: false);
        videoService.setCurso(curso);
        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( clips: curso.videos ) ));
      }
    );
  }

  cajaBorde(List<Widget> children){
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: isDarkTheme? Colors.white24 : Colors.grey[300] )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
          ),
    );
  }

  logoRamo(String ramo){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(right: 40, top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/logo$ramo.png', height: 13  ),
          ],
        ),
      ),
      onTap: (){
        CursoService cursoService = Provider.of<CursoService>(context, listen: false );
        cursoService.ramo = ramo.toLowerCase();
        Navigator.pushNamed(context, 'ramo');
      }
    );
;
  }

}