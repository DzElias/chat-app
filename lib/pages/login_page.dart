import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(title: "Ha'upei?"),
                _Form(),
                Labels(ftext: "¿No tienes cuenta?", ltext: "¡Crea una ahora!", routeName: 'register',),
        
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
        
              ],
            ),
          ),
        ),
      )
    );
  }
}



class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>( context );
    return Container(
      margin: const EdgeInsets.only(top: 40,),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline, 
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),

          CustomInput(
            icon: Icons.lock_outlined, 
            placeholder: 'Contraseña',
            textController: passController,
            isPassword: true,
          ),

          CustomButton( 
            text: "INICIAR SESION",            
            onPressed: authService.autenticando ? null : () async {

              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailController.text.trim(), passController.text.trim());
              
              if( loginOk ){
                // TODO: Conectar a socket server
                Navigator.pushReplacementNamed(context, 'usuarios');
              }else{
                mostrarAlerta(context, 'Login incorrecto', 'Verifica tus credenciales nuevamente');
              }
            } 
          )
        ],
      )
    );
  }
}



