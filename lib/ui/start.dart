import 'package:flutter/material.dart';
import 'package:notesmaker/ui/home.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/123.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.display3,
                children: [
                  TextSpan(
                    text: "NotesMaker",
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Satisfy'),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: RaisedButton(
                child: Text('START', style: TextStyle(color: Colors.white),),
                color: Color.fromRGBO(58, 66, 86, 1.0),
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Home();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}