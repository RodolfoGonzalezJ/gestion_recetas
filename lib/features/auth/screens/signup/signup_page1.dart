import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logos/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Acerca de ti',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Número de Celular',
                  border: OutlineInputBorder(),
                ),
                initialCountryCode: 'PE',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Número de Cédula',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                  }
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup2');
                  },
                  child: Text('Siguiente'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
