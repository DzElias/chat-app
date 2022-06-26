import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController refreshController = RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'tes1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Fernando', email: 'tes2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Elias', email: 'tes3@test.com', online: true),
    
  ];
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(usuario.nombre, style: const TextStyle(color: Colors.black54)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black54,),
            onPressed: (){
              //TODO: Desconectar del socket server
              Navigator.pushReplacementNamed(context, 'token');
              AuthService.deleteToken();
              
            },
          ),

          actions: [
            Container(
              margin: const EdgeInsets.only( right: 18),
              child: Icon(Icons.check_circle, color: Colors.blue[400])
            )
          ],

        ),

        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
          ),

          onRefresh: _cargarUsuarios(),
          child: _listViewUsuarios(),
        )
      );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
        separatorBuilder: (_, i) => const Divider(),
        itemCount: usuarios.length
      );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
          title: Text(usuario.nombre),
          subtitle: Text(usuario.email),
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(usuario.nombre.substring(0,2),)
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuario.online ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        );
  }
  
  _cargarUsuarios() async {

    await Future.delayed(const Duration(milliseconds: 1000));

    refreshController.refreshCompleted();

  }
}