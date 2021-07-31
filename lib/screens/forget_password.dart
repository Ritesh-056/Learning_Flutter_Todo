import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/loginPage.dart';

import '../main.dart';



class ForgetPassword extends StatefulWidget {

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var _emailController = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;


  Widget _modelBox(text){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: new Icon(
                    Icons.error,
                    size: 50,
                    color: Color.fromRGBO(180, 0, 20, 0.9),),
                  title: new Text(
                      'Oops...!',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  subtitle: new Text(
                      text,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  trailing: new IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 20,
                    color: Color.fromRGBO(20, 20, 20, 0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                ),
              ],
            ),
          );
        });
  }

     showAlertDialog(BuildContext context){
       var alert =  new AlertDialog(
         title: Center(child: Text('Check your mail',style: TextStyle(color: colorsName, fontWeight: FontWeight.w600),)),
         content: Text('Please check the email for resetting the password',style: TextStyle(color: colorsName,fontWeight: FontWeight.w400)),
         actions: [
           new FlatButton(
             child: Text('Okay',style: TextStyle(color: colorsName,fontWeight: FontWeight.w500)),
             onPressed: (){
               Navigator.of(context).pop();
             },
           )
         ],
       );

       showDialog(
           context: context,
           builder: (context){
             return alert;
           });
     }


  @override
  Widget build(BuildContext context) {
    return new SafeArea(

        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child:Icon(Icons.close),
            backgroundColor: colorsName,
            onPressed: (){
               Navigator.pop(context);
            },
          ),


          body:Center(
            child: new Stack(
                fit: StackFit.passthrough,
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    top:-80.0,
                    left: 20,
                    right: 20,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: new Text(
                            'Forget your Password?',
                            style: TextStyle(
                                color: colorsName,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ),
                  Positioned(
                    top:-48.0,
                    left: 60,
                    right: 60,
                    child:Divider(
                      thickness: 3,
                      color: colorsName,
                    ),
                  ),
                  new SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:Colors.white70,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 0,
                                offset: Offset(3, 4) // changes position of shadow
                            ),
                          ],

                        ),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: new TextField(
                                  style:TextStyle( fontSize: 14) ,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      hintText: "******@gmail.com",
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f1f1),
                                      filled: true
                                  ),

                              ),
                            ),


                            SizedBox(height: 20,),
                            new GestureDetector(
                              onTap: () async {
                                   //your code


                                     try{
                                        if(_emailController.text.isEmpty){
                                         return _modelBox(
                                            'Please,make sure you have inserted email.');
                                        }else{
                                           await auth.sendPasswordResetEmail(
                                           email:_emailController.text );

                                           showAlertDialog(context);
                                           Navigator.pop(context);
                                        }
                                     } on FirebaseAuthException catch(ex){
                                       print("==========Error[FirebaseAuth]=============");
                                       print('${ex.message}');
                                       _modelBox('${ex.message}');

                                     } catch(e){
                                       print("==========Error[catch]=============");
                                       print('${e.toString()}');
                                       _modelBox('${e.toString()}');

                                     }

                                },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: new Container(
                                  height:50,
                                  width:MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorsName,
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Send',
                                        style: TextStyle(
                                            color: text_color_white,
                                            fontSize: 14),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '** Dear user, please check your email for resetting the new password. **',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                ]
            ),
          ),
        ));

  }
}