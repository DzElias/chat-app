import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = TextEditingController();
  final _focusNode = FocusNode();


  final List<ChatMessage> _messages = const [
  ];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: const Text('Te', style: TextStyle(fontSize: 12),),
              maxRadius: 14,
            ),
            const SizedBox(height: 3,),
            const Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),

      ),

      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_,i) => Text('$i'),
                reverse: true,
              )
            ),

            const Divider(height: 1,),

            Container(
              color: Colors.white,
              child: _inputChat()
            )
          ],
        )
      )
    );
  }

  Widget _inputChat(){

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [

            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if( texto.trim().length > 0){
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                    hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              )
            ),

            // Boton de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: _estaEscribiendo 
                  ? () =>  _handleSubmit( _textController.text.trim())
                  : null
              )
              : Container(
                margin: const EdgeInsets.symmetric( horizontal: 4),
                child: IconTheme(
                  data: IconThemeData( color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.send),
                    onPressed: _estaEscribiendo 
                      ? () =>  _handleSubmit( _textController.text.trim())
                      : null
                  ),
                )
              )
            )
          ],
        )
      )
    );

  }

  _handleSubmit(String texto){

    if(texto.isEmpty) return; 

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '123', 
      texto: texto, 
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    
    setState(() {
      _estaEscribiendo = false;
    });

  }

  @override
  void dispose(){

    for( ChatMessage message in _messages){
      message.animationController.dispose();
    }

    super.dispose();
  }
}