
import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': (_) => const UsuariosPage(),
  'loading' : (_) => const LoadingPage(),
  'login'   : (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'chat'    : (_) => const ChatPage(),
  
};