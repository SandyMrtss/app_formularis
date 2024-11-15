import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormC extends StatefulWidget {
  const FormC({super.key});

  @override
  State<FormC> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FormC> {
  final _formKey = GlobalKey<FormBuilderState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sandra Martos 24/25 Forms App'),
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              Text(
                'Sport Preferences',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 10,),
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {_formKey.currentState!.save();},
                    autovalidateMode: autoValidateMode,
                    skipDisabled: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderChoiceChip(
                          name: 'favourite_sport',
                          spacing: 5,
                          runSpacing: 10,
                          alignment: WrapAlignment.spaceEvenly,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'Choose one',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                              )
                            ),
                          backgroundColor:  Color.fromRGBO(124, 159, 255, 75),
                          showCheckmark: false,
                          selectedColor: Colors.lightBlueAccent,
                          shape: StadiumBorder(
                            side: BorderSide(color: Colors.transparent)
                          ),
                          options: [
                            FormBuilderChipOption(
                              value: 'Rugby',
                              avatar: Icon(Icons.sports_rugby),
                            ),
                            FormBuilderChipOption(
                              value: 'Basketball',
                              avatar: Icon(Icons.sports_basketball),
                            ),
                            FormBuilderChipOption(
                              value: 'Tennis',
                              avatar: Icon(Icons.sports_tennis),
                            ),
                            FormBuilderChipOption(
                              value: 'Soccer',
                              avatar: Icon(Icons.sports_soccer),
                            ),
                            FormBuilderChipOption(
                              value: 'Gymnastics',
                              avatar: Icon(Icons.sports_gymnastics),
                            ),
                          ],
                          validator: FormBuilderValidators.required(),
                        ),
                        SizedBox(height: 10,),
                        FormBuilderSwitch(
                          name: 'currently_practicing',
                          title: Text('Do you currently practice any sport?'),
                          initialValue: false,
                          decoration: InputDecoration(
                            labelText: 'Currently',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                            )
                          ),
                        ),
                        SizedBox(height: 10,),
                        FormBuilderTextField(
                          name: 'favourite_athlete',
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.none,
                          decoration: const InputDecoration(
                            labelText: 'Who is your favourite athlete?',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(1),
                            FormBuilderValidators.maxLength(15),
                          ]),
                        ),
                        SizedBox(height: 10,),
                        FormBuilderDropdown<String>(
                        name: 'modality',
                        decoration: InputDecoration(
                          labelText: 'Choose a sport modality',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        //initialValue: null,
                        items: [
                          DropdownMenuItem(value: 'individual', child: Text('Individual'),),
                          DropdownMenuItem(value: 'pairs', child: Text('Pairs'),),
                          DropdownMenuItem(value: 'team', child: Text('Team'),)
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        alignment: AlignmentDirectional.centerStart,
                        validator: FormBuilderValidators.required(),
                      ),
                        SizedBox(height: 10,),
                        FormBuilderRadioGroup<String>(
                        name: 'time',
                        decoration: const InputDecoration(
                          labelText: 'Time spent on exercise',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        options: ['<30 min per week', '1h-2h per week', '2h-4h per week', '4-8h per week', '8-12h per week', '>12h per week']
                          .map((time) => FormBuilderFieldOption(
                            value: time,
                            child: Text(time),
                          ))
                          .toList(growable: false),
                        orientation: OptionsOrientation.vertical,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.required(),
                      ),
                    ],
                  ),
                )
              ]
            )
          ),
        ),
        floatingActionButton:  FloatingActionButton(
          onPressed: () {
            if(_formKey.currentState?.saveAndValidate() ?? false){
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: <Widget> [
                        const Icon(Icons.check_circle_rounded,color: Colors.green,),
                        const SizedBox(width: 7,),
                        const Text(
                          'Submission Completed!',
                          style: TextStyle(fontWeight: FontWeight.bold,),
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
                        child: const Text('Close', style: TextStyle(color: Colors.black),))
                    ],
                  );
                }
              );
              setState(() => autoValidateMode = AutovalidateMode.disabled);
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
            backgroundColor: Color.fromRGBO(59, 221, 226, 100),
            child: const Icon(Icons.upload)
        ),
      );
    }
  }

