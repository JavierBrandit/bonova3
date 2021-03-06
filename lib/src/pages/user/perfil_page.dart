import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/chat_service.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
 
class PerfilPage extends StatefulWidget {

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Usuario usuario;
  ScrollController _scrollController;
  List<Curso> misCursos = [];
  final cursoService = CursoService();
  final auth = AuthService();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() { 
    super.initState();
    _cargarMisCursos();
  }

  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final authService = Provider.of<AuthService>(context);
    final chatService = Provider.of<ChatService>(context);
    usuario = ModalRoute.of(context).settings.arguments;
    final yo = authService.usuario;
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0.0,
        actions: [
          
          usuario != yo ?
          Padding(
            padding: const EdgeInsets.only(bottom:5, right: 10),
            child: IconButton(
              icon: SvgPicture.asset('assets/sendd.svg', height: 21, width: 21, color: isDarkTheme? Colors.tealAccent : Colors.teal[700],),
              onPressed: () {                
                chatService.usuarioPara = usuario;
                Navigator.pushNamed(context, 'chat');
        },
            ),
          ) : Container()
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarProfesor,
        header: WaterDropHeader(
          complete: Icon(FluentIcons.checkmark_circle_16_regular, color: Colors.tealAccent[700], ),
          waterDropColor: Colors.transparent,
        ),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Column(
            children: [
                
                Hero(
                  tag: 'foto',
                  child: Center(child: GestureDetector( child: 
                    CircleAvatar(backgroundImage: NetworkImage(usuario.foto), radius: 55 ),
                    onTap: () => Navigator.pushNamed(context, 'foto', arguments: usuario),
                  )),
                ),
                SizedBox( height: 5 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 40),
                    
                    Container(
                      child: Text( usuario.nombre,
                                   style: TextStyle( fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: -1 
                    ))),
                    
                    this.usuario == yo
                    ? IconButton(
                        icon: Icon( FluentIcons.edit_16_regular, size: 23),
                        onPressed: () => Navigator.pushNamed(context, 'formulario'),
                      )
                    : IconButton(
                        icon: Icon( FluentIcons.person_add_24_regular, size: 25, color: Colors.tealAccent[700],),
                        onPressed: (){},
                      )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child:
                       usuario.profesor
                        ? Container(height: 19, width: 19, child: SvgPicture.asset('assets/manzana.svg', color: Colors.redAccent.withOpacity(.8)))
                        : Icon(FluentIcons.hat_graduation_24_regular, size: 19, color: Colors.teal)),

                    Text(usuario.profesor? 'Profesor' :'Alumno' , 
                          style: TextStyle( fontSize: 19, letterSpacing: -.4, fontWeight: FontWeight.w500, 
                                          color: usuario.profesor? Colors.redAccent.withOpacity(.8): Colors.teal[500]
                    )),
                    SizedBox(width: 15)
                  ],
                ),
                SizedBox( height: 10 ),

                yo.profesor || usuario != yo
                ? Container()
                : FlatButton(
                    height: 34,
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: Text('Cambiate a Profesor', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: -.2)),
                    color: Colors.teal,
                    colorBrightness: Brightness.dark,
                    shape: StadiumBorder(),
                    onPressed: () async {
                      print('onTap');
                      await authService.editarProfesor(context, true);
                      Navigator.pushReplacementNamed(context, 'home');
                      // _cargarProfesor();
                      // val = usuario.profesor;
                      // await auth.profesor(context, yo.profesor);
                      // setState(() {});
                    },
                ),
                usuario.profesor
                    ? dashboard()
                    : Divider(color: Colors.grey, indent: 15, endIndent: 15,),

                SizedBox( height: 5 ),


                // cajaBorde(isDarkTheme, [
                  listTileInfo(usuario.colegio, FluentIcons.building_bank_16_regular, 'estudios'),
                  listTileInfo(usuario.comuna, FluentIcons.location_16_regular, 'comuna'),
                  listTileInfo('Matemática · Física', FluentIcons.book_number_16_regular, 'especialidad'),
                // ]),
                SizedBox( height: 15 ),
                
                usuario.profesor?
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox( width: 13 ),
                        Text('Mis Cursos', style: TextStyle(fontSize: 14, letterSpacing: -.3, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    _listaCursos(),
                  ],
                ) : Container()
    
    
    ])))])));
  }





  dashboard(){
    return Column(
      children: [
        SizedBox( height: 2 ),
        Text('Sobre mí', style: TextStyle(fontSize: 14, letterSpacing: -.3, fontWeight: FontWeight.w600),),
        Text('"'+usuario.descripcion+'"', style: TextStyle(fontSize: 13, letterSpacing: 0),),
        SizedBox( height: 20 ),
        Divider(color: Colors.grey, indent: 15, endIndent: 15,),
        Row( //DASHBOARD
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dashboardItem(FluentIcons.video_16_regular,'1', 'cursos en que enseña'),
            dashboardItem(FluentIcons.people_16_regular,'700', 'alumnos inscritos'),
            dashboardItem(FluentIcons.star_16_regular,'4.7/5', 'valoración promedio'),
          ],
        ),
        Divider(color: Colors.grey, indent: 15, endIndent: 15,),
      ],
    );
  }

  dashboardItem(IconData icon, String valor, String titulo) {
    return Container(
      padding: EdgeInsets.only(bottom: 15, top: 10),
      width: 80,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Icon(icon),
                Text(' '+valor+' ',
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: -.4
                )),
            ],
          ),
          Text(titulo, textAlign: TextAlign.center,
               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: -.4
          ))
        ],
      ),
    );
  }

  _cargarProfesor() async {
    // final yo = Provider.of<AuthService>(context, listen: false).usuario;
    // yo.profesor = await auth.profesor(context, yo.profesor);
    // auth.getUsuario();
    // setState(() {});
    _refreshController.refreshCompleted();
    Navigator.pushReplacementNamed(context, 'home');
  }

  cajaBorde(bool dark, List<Widget> children){
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: dark? Colors.white24 : Colors.grey[300] )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
          ),
      ),
    );
  }

  listTileInfo(String titulo, IconData icon, String descripcion){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        children: [

          Padding(
            padding: EdgeInsets.only(right: 23),
            child: Icon(icon, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: -.6),),
              Text(descripcion, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: -.2)),
            ],
          )

      ]),
    );
  }

  _cargarMisCursos() async {
    this.misCursos = await cursoService.getAllCursos();
    setState((){});
  }

  Widget _listaCursos() {
    return Container(
      height: 270,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, i) => carruselHorizontal(context, misCursos[i]),
        itemCount: misCursos.length,
        controller: _scrollController,
      ),
    );
  }


}
