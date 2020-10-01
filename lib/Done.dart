import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted!'),
      ),
      body: Center(child:
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Text('Your details have been submitted to info@redpositive.in . \nWe will contact you soon !\n',style: TextStyle(
            
            fontSize: 25
          ),),
        )
                   //}
      ,),
    );
  }
}
