import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormA extends StatefulWidget {
  const FormA({super.key});

  @override
  State<FormA> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FormA> {
  final _formKey = GlobalKey<FormBuilderState>();

  Text questionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Text subquestionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey,
      ),
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
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Text(
              'Music Preferences',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilder(
              key: _formKey,
              onChanged: () {
                _formKey.currentState!.save();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  questionText('How old are you?'),
                  subquestionText('Please chose one of the options below'),
                  SizedBox(
                    height: 5,
                  ),
                  FormBuilderRadioGroup<String>(
                    name: 'age',
                    options: ['<10', '11-16', '17-25', '26-35', '36-46', '+46']
                      .map((age) => FormBuilderFieldOption(
                          value: age,
                          child: Text(age),
                        ))
                      .toList(growable: false),
                    orientation: OptionsOrientation.vertical,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  questionText('Full name'),
                  SizedBox(
                    height: 5,
                  ),
                  FormBuilderTextField(
                    name: 'name',
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Color.fromRGBO(192, 192, 192, 100),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  questionText('What is your gender?'),
                  subquestionText('Please chose one of the options below'),
                  SizedBox(
                    height: 5,
                  ),
                  FormBuilderDropdown<String>(
                    name: 'gender',
                    decoration: InputDecoration(
                      hintText: 'Select Gender',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text('Other'),
                      )
                    ],
                    alignment: AlignmentDirectional.centerStart,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  questionText('Which music genres do you listen to?'),
                  subquestionText('Please chose one or more of the options given below'),
                  SizedBox(
                    height: 5,
                  ),
                  FormBuilderCheckboxGroup<String>(
                    name: 'music_styles',
                    options: const [
                      FormBuilderFieldOption(value: 'Pop'),
                      FormBuilderFieldOption(value: 'Rock'),
                      FormBuilderFieldOption(value: 'Hip Hop'),
                      FormBuilderFieldOption(value: 'Rap'),
                      FormBuilderFieldOption(value: 'Jazz'),
                      FormBuilderFieldOption(value: 'Classical'),
                      FormBuilderFieldOption(value: 'Techno'),
                      FormBuilderFieldOption(value: 'Reggaeton'),
                      FormBuilderFieldOption(value: 'Spanish'),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            )
          ]
        )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  children: <Widget>[
                    const Icon(Icons.check_circle_rounded, color: Colors.green,),
                    const SizedBox(width: 7,),
                    const Text(
                      'Submission Completed!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                    )
                  ],
                ),
                content: Text(
                  _formKey.currentState!.value.toString(),
                  textAlign: TextAlign.left,
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(145, 255, 245, 100),
                    ),
                    child: const Text('Close', style: TextStyle(color: Colors.black),)
                  )
                ],
              );
            }
          );
        },
        backgroundColor: Color.fromRGBO(59, 221, 226, 100),
        child: const Icon(Icons.upload)),
    );
  }
}
