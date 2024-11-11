import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FormD extends StatefulWidget {
  const FormD({super.key});

  @override
  State<FormD> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FormD> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController autocompleteController = TextEditingController();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  static const List<String> _countryOptions = <String> ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and/or Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Cook Islands", "Costa Rica", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecudaor", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France, Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kosovo", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfork Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia South Sandwich Islands", "South Sudan", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbarn and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States minor outlying islands", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City State", "Venezuela", "Vietnam", "Virigan Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zaire", "Zambia", "Zimbabwe"];

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
              child: Column(
                  children: <Widget>[
                  Text(
                    "Travel information",
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
                        TypeAheadField(
                          controller: autocompleteController,
                          builder: (context, controller, focusNode) {
                            return FormBuilderTextField(
                              name: 'country',
                              controller: controller,
                              focusNode: focusNode,
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              decoration: const InputDecoration(
                                labelText: 'Which country are you visiting?',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                              validator: FormBuilderValidators.required(),
                            );
                          },
                          suggestionsCallback: (pattern) {
                            return _countryOptions.where((country) => country.toLowerCase().startsWith(pattern.toLowerCase())).toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSelected: (country) {
                            autocompleteController.text = country;
                          },
                        ),
                        SizedBox(height: 10,),
                        FormBuilderDateTimePicker(
                            name: 'departure_date',
                            decoration: InputDecoration(
                            labelText: 'When are you leaving?',
                            suffixIcon: const Icon(Icons.calendar_month_sharp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          initialValue: null,
                          inputType: InputType.date,
                          format: DateFormat('EEEE, MMMM dd, yyyy'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.required()
                        ),
                        SizedBox(height: 10,),
                        FormBuilderDateRangePicker(
                            name: 'travel_date',
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            format: DateFormat('MMM dd, yyyy'),
                            decoration: InputDecoration(
                              labelText: 'Travel dates',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _formKey.currentState!.fields['travel_dates']?.didChange(null);
                                },
                              ),
                            ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.required(),
                        ),
                        SizedBox(height: 10,),
                        FormBuilderDateTimePicker(
                            name: 'hour',
                            decoration: InputDecoration(
                              labelText: 'At what time are you leaving?',
                              suffixIcon: const Icon(Icons.access_time_filled_sharp),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            initialValue: null,
                            locale: Locale('en', 'GB'),
                            format: DateFormat('HH:mm'),
                            inputType: InputType.time,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.required()
                        ),
                        SizedBox(height: 10,),
                        FormBuilderFilterChip(
                            name: 'favourite_sport',
                            spacing: 5,
                            runSpacing: 10,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                labelText: 'Choose all expenses that apply',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(12)
                                )
                            ),
                            backgroundColor: Color.fromRGBO(124, 159, 255, 75),
                            selectedColor: Colors.lightBlueAccent,
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(300)
                            ),
                            options: [
                              FormBuilderChipOption(
                                  value: 'Plane',
                                  avatar: Icon(Icons.airplanemode_active, size: 18,)
                              ),
                              FormBuilderChipOption(
                                  value: 'Train',
                                  avatar: Icon(Icons.train, size: 18,)
                              ),
                              FormBuilderChipOption(
                                  value: 'Bus',
                                  avatar: Icon(Icons.directions_bus, size: 18,)
                              ),
                              FormBuilderChipOption(
                                  value: 'Hotel',
                                  avatar: Icon(Icons.hotel, size: 18,)
                              ),
                              FormBuilderChipOption(
                                  value: 'Medical insurance',
                                  avatar: Icon(Icons.local_hospital, size: 18,)
                              ),
                              FormBuilderChipOption(
                                  value: 'Food',
                                  avatar: Icon(Icons.fastfood, size: 18,)
                              ),
                            ],
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
                          SizedBox(width: 10,),
                          const Text(
                            'Submission Completed!',
                            textAlign: TextAlign.left,
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
                              backgroundColor: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text('Close', style: TextStyle(color: Colors.black),))
                      ],
                    );
                  }
              );
              } else {
                setState(() => autoValidateMode = AutovalidateMode.always);
            }
          },
            backgroundColor: Color.fromRGBO(59, 221, 226, 100),
            child: const Icon(Icons.upload)
        ),
      );
    }
  }

