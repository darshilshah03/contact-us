import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mailer/flutter_mailer.dart';
import './Done.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  
  var nameController =  TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  void showError(String message) {
     showDialog(
       context: context,
       builder: (ctx) => AlertDialog(
         title: Text('An error occured'),
         content: Text(message),
         actions: <Widget>[
           FlatButton(
             child: Text('Okay'),
             onPressed: () {
               Navigator.of(context).pop();
             },
           )
         ],
       )
    );
  }

  void onSubmitHandler() async{
    print("Hello");
    var name = nameController.text.trim();
    var phone = phoneController.text.trim();
    var email = emailController.text.trim();

    if(name==null || name=='' || name.length==0){
        showError('Name cannot be empty');
        return;
    }
    if(phone==null || phone=='' || phone.length==0){
        showError('Phone Number  cannot be empty');
        return;
    }
    if(email==null || email=='' || email.length==0){
        showError('Email cannot be empty');
        return;
    }
    if(phone.length!=8 && phone.length!=10)
    {
      showError('Invalid phone number provided. It should be of 8 or 10 digits. ');
      return;
    }

    try{
        var url = 'https://contactus-b4190.firebaseio.com/.json';

        var res = await http.post(url,body: json.encode({
          'name' : name,
          'phone' : phone,
          'email' : email,
          'time' : DateTime.now().toIso8601String()
        }));


        final MailOptions mailOptions = MailOptions(
        body: '<p>Following are the details submitted throught the Contact Us form . <br><br> Name : ' + name + '<br> Phone Number : '+phone+'<br> Email address : '+email+'</p>',
        subject: 'Sending the contact details',
        recipients: ['info@redpositive.in'],
        isHTML: true,
      );

      await FlutterMailer.send(mailOptions);

        print(res.body);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Done())
      );
    }
    catch(error ) {
      showError(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Us'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 550,
            
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                
                Text('Contact Us',style: TextStyle(
                  fontSize: 35
                ),),
                Container(
                  height: 350,
                child: Card(
                  
                  margin: EdgeInsets.all(20),
                  
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: 20,),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Your name  ',
                          labelStyle: TextStyle(
                            fontSize: 20
                          ),

                        ),
                      ),

                      SizedBox(height: 10,),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Your phone number ',
                          labelStyle: TextStyle(
                            fontSize: 20
                          ),

                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10,),
                      TextField(

                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Your email id ',
                          labelStyle: TextStyle(
                            fontSize: 20
                          ),

                        ),
                        keyboardType: TextInputType.emailAddress
                      ),
                      SizedBox(height: 10,),
                      FlatButton(
                        child: Text('Submit',style: TextStyle(
                          fontSize: 20,
                        ),),
                        color: Colors.amberAccent,
                        onPressed: this.onSubmitHandler,
                      )
                    ],
                  ),
              ),
                ),
                SizedBox(height: 15,),
                Text('You will be directed to Gmail App. Click on the send button to send the details to us.',style: TextStyle(
                  fontSize: 20
                )),
              ],
              
            ),
          ),
        ),
    );
  }
}