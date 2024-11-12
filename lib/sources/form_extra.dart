import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class FormExtra extends StatefulWidget {
  const FormExtra({super.key});

  @override
  State<FormExtra> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FormExtra> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _genderKey = GlobalKey<FormBuilderFieldState>();

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
            child:
              SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                  FormBuilder(
                    key: _formKey,
                    onChanged: () {_formKey.currentState!.save();},
                    autovalidateMode: autoValidateMode,
                    skipDisabled: true,
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          name: 'full_name',
                          decoration: const InputDecoration(labelText: 'Full Name'),
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          validator: FormBuilderValidators.required(),
                        ),
                        FormBuilderDropdown<String>(
                          key: _genderKey,
                          name: 'gender',
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            hintText: 'Select Gender',
                          ),
                          //initialValue: null,
                          items: [
                            DropdownMenuItem(value: 'male', child: Text('Male'),),
                            DropdownMenuItem(value: 'female', child: Text('Female'),),
                            DropdownMenuItem(value: 'other', child: Text('Other'),)
                          ],
                          alignment: AlignmentDirectional.centerStart,
                          validator: FormBuilderValidators.required(),
                        ),
                        FormBuilderRadioGroup<String>(
                          name: 'age_range',
                          decoration: const InputDecoration(labelText: 'Age range',),
                          options: ['<10', '11-16', '17-25', '26-35', '36-46', '+46']
                              .map((age) => FormBuilderFieldOption(
                            value: age,
                            child: Text(age),
                          ))
                              .toList(growable: false),
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          validator: FormBuilderValidators.required(),

                        ),
                        FormBuilderSlider(
                          name: 'minutes',
                          decoration: const InputDecoration(labelText: 'How many minutes do you listen to music per day?',),
                          initialValue: 0.00,
                          min: 0.0,
                          max: 500.0,
                          divisions: 50,
                          activeColor: Colors.blueAccent,
                          inactiveColor: Colors.lightBlue[100],

                        ),
                        FormBuilderRangeSlider(
                          name: 'concerts',
                          decoration: const InputDecoration(labelText: 'How many concerts a year do you go to?'),
                          min: 0.0,
                          max: 50.0,
                          divisions: 50,
                          maxValueWidget: (max) => TextButton(
                            onPressed: () {
                              _formKey.currentState?.patchValue(
                                {'concerts': const RangeValues(0, 50)},
                              );
                            },
                            child: Text(max,
                              style: TextStyle(color: Colors.black),),
                          ),
                          activeColor: Colors.blueAccent,
                          inactiveColor: Colors.lightBlue[100],

                        ),
                        FormBuilderCheckboxGroup<String>(
                          name: 'music_styles',
                          decoration: const InputDecoration(labelText: 'What are your favourite music styles?'),
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
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.minLength(1),
                            FormBuilderValidators.maxLength(3),
                          ]),
                        ),
                        FormBuilderDateTimePicker(
                          name: 'date',
                          decoration: InputDecoration(
                            labelText: 'When are you answering this?',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState!.fields['date']?.didChange(null);
                              },
                            ),
                          ),
                          initialValue: null,
                          initialEntryMode: DatePickerEntryMode.calendar,
                          inputType: InputType.date,
                          onChanged: (newValue){
                            if(newValue != null) {
                              newValue =   DateFormat('dd-MM-yyyy').parse(newValue.toString());
                              autoValidateMode = AutovalidateMode.onUnfocus;
                            }
                          },
                          validator: FormBuilderValidators.required(),
                        ),
                        FormBuilderCheckbox(
                          name: 'accept_terms',
                          initialValue: false,
                          title: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I have read and agree to the ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                          validator: FormBuilderValidators.equal(
                            true,
                            errorText: 'You must accept terms and conditions to continue',
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  debugPrint(_formKey.currentState!.value.toString());
                                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                                    debugPrint(_formKey.currentState?.value.toString());
                                    setState(() => autoValidateMode = AutovalidateMode.disabled);
                                    _formKey.currentState?.reset();
                                    _genderKey.currentState?.reset();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Row(
                                              children: <Widget> [
                                                const Icon(Icons.check_circle_rounded,color: Colors.green,),
                                                const Text(
                                                  'Success!',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(fontWeight: FontWeight.bold,),
                                                )
                                              ],
                                            ),
                                            content: const Text(
                                              "Information submitted successfully",
                                              textAlign: TextAlign.left,
                                            ),
                                          );
                                        });
                                  } else {
                                    debugPrint(_formKey.currentState?.value.toString());
                                    debugPrint('validation failed');
                                    setState(() => autoValidateMode = AutovalidateMode.onUserInteraction);
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                child: const Text('Submit',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() => autoValidateMode = AutovalidateMode.disabled);
                                  _formKey.currentState?.reset();
                                  _genderKey.currentState?.reset();
                                },
                                // color: Theme.of(context).colorScheme.secondary,
                                child: Text(
                                  'Reset',
                                  style: TextStyle(color: Theme.of(context).primaryColor),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]
              )
            )
        ),
      );
    }
  }

