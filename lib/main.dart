import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'sources/form_a.dart';
import 'sources/form_b.dart';
import 'sources/form_c.dart';
import 'sources/form_d.dart';
import 'sources/form_extra.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandra Martos 24/25',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.indigoAccent,
          secondary: Colors.lightBlue,
        ),
      ),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  void _simpleDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Is this a Simple Dialog?',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold,),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text ('Yes'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text ('Also yes'),
            ),
          ],
        );
      },
    );
  }

  void _alertDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                const Icon(
                  Icons.info_sharp, color: Colors.red,),
                SizedBox(width: 10,),
                const Text(
                  'Alert Dialog!',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,),
                )
              ],
            ),
            content: const Text(
              "Am I an alert dialog?",
              textAlign: TextAlign.left,
            ),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),

                  child: const Text('Yes', style: TextStyle(color: Colors.black),),
              ),
            ],
          );
        });
  }

  void _snackBar(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This is a Snack Bar'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.teal,
        showCloseIcon: true,
      )
    );
  }

  void _modalButtonSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text("I am a Modal Bottom Sheet"),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        child: const Text("Close me"))
                  ],
                )
              ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sandra Martos 24/25 Forms App'),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {_simpleDialog(context);},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        alignment: AlignmentDirectional.center,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Simple Dialog', style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),
                  )
                ),
                Expanded(
                  child: Padding(
                  padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {_alertDialog(context);},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        alignment: AlignmentDirectional.center,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Alert Dialog',style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {_snackBar(context);},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        alignment: AlignmentDirectional.center,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Snack Bar',style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: ElevatedButton(
                      onPressed: () {_modalButtonSheet(context);},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        alignment: AlignmentDirectional.center,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Modal Sheet',style: TextStyle(fontSize: 12, color: Colors.white),),
                    ),
                  )
                ),
              ],
            ),
            const Divider(),
            ListTile(
              title: const Text('Form A: Music'),
              trailing: const Icon(Icons.headphones),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FormA();
                    },
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Form B: Stepper'),
              trailing: const Icon(Icons.looks_one),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FormB();
                    },
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Form C: Sports'),
              trailing: const Icon(Icons.sports_basketball),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FormC();
                    },
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Form D: Travel'),
              trailing: const Icon(Icons.airplanemode_on),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FormD();
                    },
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Form Extra: Music'),
              trailing: const Icon(Icons.music_note),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FormExtra();
                    },
                  ),
                );
              },
            ),
          ],
        )
      ),
    );
  }
}