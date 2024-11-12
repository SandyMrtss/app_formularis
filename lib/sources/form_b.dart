import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormB extends StatefulWidget {
  const FormB({super.key});

  @override
  State<FormB> createState() {
    return _CompleteFormState();
  }
}

class _CompleteFormState extends State<FormB> {
  final _formKey = GlobalKey<FormBuilderState>();
  var _currentStep = 0;

  Widget _infoForm(){
    return FormBuilder(
      key: _formKey,
      onChanged: () {_formKey.currentState!.save();},
      child: Column(
        children: <Widget>[
          FormBuilderTextField(
            name: 'email',
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email, color: Colors.lightBlueAccent,),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.lightBlueAccent,),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.lightBlueAccent)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 2 ,color: Colors.indigo)
              ),
            ),
          ),
          SizedBox(height: 10,),
          FormBuilderTextField(
            name: 'address',
            maxLines: 4,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.house, color: Colors.lightBlueAccent,),
              labelText: 'Address',
              labelStyle: TextStyle(color: Colors.lightBlueAccent),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.lightBlueAccent)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 2 ,color: Colors.indigo)
              ),
            ),
          ),
          SizedBox(height: 10,),
          FormBuilderTextField(
            name: 'phoneNumber',
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone, color: Colors.lightBlueAccent,),
              labelText: 'Mobile No',
              labelStyle: TextStyle(color: Colors.lightBlueAccent,),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.lightBlueAccent)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(width: 2 ,color: Colors.indigo)
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Step> _steps(){
    return [
      Step(
        title: const Text('Pers.'),
        state: _stepState(0),
        content: Column(
          children: const [
            Text(
              'Personal',
              style: TextStyle(fontSize: 40),
            ),
            Text('Your personal information is important. '
                'Click continue or Contact to go to the next step'),
          ],
        ),
        isActive: _currentStep == 0,
      ),
      Step(
        title: const Text('Contact'),
        state: _stepState(1),
        content: Column(
          children: const [
            Text(
              'Contact',
              style: TextStyle(fontSize: 40),
            ),
            Text('Pulsi "Upload" o pulsi el botó de "Continue".'),
          ],
        ),
        isActive: _currentStep == 1,
      ),
      Step(
        title: const Text('Upload'),
        state: _stepState(2),
        content: _infoForm(),
        isActive: _currentStep == 2,
      ),
    ];
  }

  void _continue() {
    if (_currentStep < _steps().length - 1) {
      setState(() {
        _currentStep += 1;
      });
      return;
    }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: <Widget>[
                  const Icon(Icons.check_circle_rounded,color: Colors.green,),
                  SizedBox(width: 7,),
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
                    child: const Text('Close', style: TextStyle(color: Colors.black),))
              ],
            );
          });
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _tap(int index){
    setState(() {
      _currentStep = index;
    });
  }

  StepState _stepState (int step){
    if(_currentStep > step){
      return StepState.complete;
    }
    if(_currentStep < step){
      return StepState.indexed;
    }
      return StepState.editing;
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
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  steps: _steps(),
                  onStepContinue: _continue,
                  onStepCancel: _cancel,
                  onStepTapped: _tap,
                  controlsBuilder: (BuildContext context, ControlsDetails details) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 100,),
                        Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              child: const Text('CONTINUE', style: TextStyle(color: Colors.white),),
                            ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextButton(
                            onPressed: details.onStepCancel,
                            child: const Text('CANCEL'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ]
          ),
        ),
    );
  }
}

