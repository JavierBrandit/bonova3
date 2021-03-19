import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/pages/explore/busqueda.dart';
import 'package:bonova0002/src/pages/player/reproductor_video.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Curso cursoSeleccionado;
  List<Curso> historial = [];
  final cursoService = CursoService();
  List<Curso> cursosMate;
  TextEditingController query;
  final chipList = [
    'matematica', 'fisica', 'quimica', 
    'fracciones', 'potencias',
    'psu', 'pdt'
  ];

  @override
  void initState() { 
    // _cargarPrimero();
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
      body: SafeArea(
             child: Column(
               children: [
                input('¿Que vamos a aprender hoy?', FluentIcons.search_20_regular, TextInputType.text, query),
                // Container(
                //   height: 60,
                //   child: ListView.builder(
                //     padding: EdgeInsets.symmetric(horizontal: 25),
                //     itemCount: chipList.length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (_,i) => chips(chipList[i])
                //   ),
                // ),
                // query != null
                //   ? Container( child: Text('estas buscando'))
                //   : Container(
                //   height: pantalla.height,
                //   child: Scaffold(
                //     body: Column(
                //       children: [
                //         Text('HOLAAAAAAAAAA!!!!!!!'),

                //         cursosMate == null || cursosMate == []
                //           ? Center(child: CircularProgressIndicator(strokeWidth: .6,))
                //           : 

                //         cajaListaRamo(cursosMate, 'Matematica'),
                //         // cajaListaRamo(cursosMate, 'Fisica'),
                //       ],
                //     ),
                // )),
                
                // SearchBar(
                //   onSearch: (s) => cursoService.searchCursos( s ), 
                //   onItemFound: (curso, i) => Text('holaaa hola holamnxcz')
                // )
                // categorias()
                // Text('Más Buscados'),
                // Container(height: 15),
                

               ],
    ),
           ));

  }

  categorias(){
    return SearchBar<Curso>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: (s) => cursoService.searchCursos( s ),
          onItemFound: (curso, i) => Text('holaaa hola holamnxcz'),
          placeHolder: Text("placeholder"),
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          // indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          header: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("sort"),
                onPressed: () {
                  // _searchBarController.sortList((Curso a, Curso b) {
                  //   return a.body.compareTo(b.body);
                  // });
                },
              ),
              RaisedButton(
                child: Text("Desort"),
                onPressed: () {
                  // _searchBarController.removeSort();
                },
              ),
              RaisedButton(
                child: Text("Replay"),
                onPressed: () {
                  // isReplay = !isReplay;
                  // _searchBarController.replayLastSearch();
                },
              ),
            ],
          ),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          // onItemFound: (Curso curso, int index) {
          //   return Container(
          //     color: Colors.lightBlue,
          //     child: ListTile(
          //       title: Text(curso.titulo),
          //       isThreeLine: true,
          //       subtitle: Text(curso.descripcion),
          //       onTap: () {
          //         //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
          //       },
          //     ),
          //   );
          // },
    );
  }



  chips(String s){

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Chip(
          label: Text( s , style: TextStyle( fontSize: 11, letterSpacing: -.3, color: isDarkTheme? Colors.grey[400] : Colors.grey[800]),),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          backgroundColor: isDarkTheme? BonovaColors.azulNoche[800] : Colors.grey[50],
          side: BorderSide(width: .5, color: isDarkTheme? Colors.teal : Colors.tealAccent[400]),
          autofocus: true,
        ),
      ),
      onTap: () async{
        this.query.text = s;
        print(query.text);
        // cursosMate = await cursoService.searchCursos(s);
        setState(() {});
      },
    );
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

  // SliverAppBar _appBar(bool dark, Size pantalla){
  //   return SliverAppBar(
  //         //  toolbarHeight: 90,
  //         automaticallyImplyLeading: false,
  //          pinned: true,
  //          flexibleSpace: FlexibleSpaceBar(
  //            centerTitle: true,
  //            title: Container(
  //                 padding: EdgeInsets.symmetric( horizontal: 20 ),
  //                 height: 40,
  //                 width: 320,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(30),
  //                   border: Border.all(width: 1.8, color: dark ? Colors.tealAccent[700] : Colors.tealAccent[400]),
  //                   // color: BonovaColors.azulNoche[800],
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [

  //                   Icon( FluentIcons.search_24_filled, size: 17, ),
  //                   SizedBox(width: 15),
  //                   Expanded(child: 
  //                   Text('¿Qué aprendemos hoy?', 
  //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: dark ? Colors.teal.withOpacity(0.5) : Colors.grey[400] ))
  //                   )
  //                 ]),
  //               ),
  //            ),
  //         actions: [
  //           // input('¿Que vamos a aprender hoy', FluentIcons.search_20_regular, TextInputType.text, query)
  //           // Container(
  //           //   width: pantalla.width,
  //           //   child: GestureDetector(
  //           //     onTap: () async {
  //           //       final curso = await showSearch(
  //           //         context: context, 
  //           //         delegate: CursosSearchDelegate('', historial )
  //           //       );
  //           //       setState(() {
  //           //         this.cursoSeleccionado = curso;
  //           //         this.historial.insert(0, curso);
  //           //       });
  //           //     }
  //           //   ),
  //           // )
  //         ],
  //        );
  // }

  input( String hint, IconData icon, TextInputType keyboardType, TextEditingController ctrl, ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 45,
      decoration: BoxDecoration(
        //  color: Colors.white, 
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.tealAccent[700] )
      ),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (text) async {
          text = query.text;
          setState(() {
                      
                    });
          // this.cursosMate = await cursoService.searchCursos(text);
        },
        decoration: InputDecoration(
          prefixIcon: Icon( icon, size: 20 ),
          contentPadding: EdgeInsets.only(bottom: 6),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle( fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -.4,)
    )));
  }

  _cargarPrimero() async {
    this.cursosMate = await cursoService.getAllCursos();
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: curso ) ));
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

  }

}