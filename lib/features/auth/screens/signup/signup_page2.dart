import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class SignUpPage2 extends StatefulWidget {
  @override
  _SignUpPage2State createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  String? selectedCountry;
  String? selectedDepartment;
  String? selectedMunicipality;
  String? selectedVia;
  String? selectedNumber1;
  String? selectedLetter1;
  String? selectedBis1;
  String? selectedPosition1;
  String? selectedNumber2;
  String? selectedLetter2;
  String? selectedPosition2;
  String? barrio;
  String? selectedAdditionalInfo;
  String direccionIntegrada = '';

  final Map<String, List<String>> countryToDepartments = {
    'Perú': ['Lima', 'Cusco', 'Arequipa'],
    'Colombia': ['Antioquia', 'Cundinamarca', 'Valle del Cauca'],
  };

  final Map<String, List<String>> departmentToMunicipalities = {
    'Lima': ['Miraflores', 'San Isidro', 'Barranco'],
    'Cusco': ['Cusco', 'Urubamba', 'Ollantaytambo'],
    'Arequipa': ['Arequipa', 'Cayma', 'Yanahuara'],
    'Antioquia': ['Medellín', 'Envigado', 'Itagüí'],
    'Cundinamarca': ['Bogotá', 'Soacha', 'Chía'],
    'Valle del Cauca': ['Cali', 'Palmira', 'Buenaventura'],
  };

  final Map<String, String> viaAbbreviations = {
    'Calle': 'Cl',
    'Avenida Calle': 'Cl',
    'Carrera': 'Cr',
    'Avenida Carrera': 'Cr',
    'Transversal': 'Tv',
    'Diagonal': 'Dg',
  };

  final List<String> viasPrincipales = [
    'Calle',
    'Avenida Calle',
    'Carrera',
    'Avenida Carrera',
    'Transversal',
    'Diagonal',
  ];
  final List<String> letters = List.generate(
    26,
    (index) => String.fromCharCode(65 + index),
  ); // A-Z
  final List<String> bisOptions = ['Bis', 'No'];
  final List<String> positions = ['Este', 'Oeste', 'Norte', 'Sur'];
  final List<String> numbers = List.generate(
    99,
    (index) => (index + 1).toString(),
  ); // 1-99
  final List<String> additionalInfoOptions = [
    'Edificio',
    'Apartamento',
    'Casa',
    'Otros',
  ];

  List<String> departments = [];
  List<String> municipalities = [];

  void updateDireccionIntegrada() {
    setState(() {
      final via = viaAbbreviations[selectedVia] ?? selectedVia ?? '';
      direccionIntegrada =
          '$via ${selectedNumber1 ?? ''}${selectedLetter1 ?? ''} #${selectedNumber2 ?? ''} - ${selectedPosition2 ?? ''}';
    });
  }

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
                'Donde Contactarte',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country.name;
                        departments = countryToDepartments[country.name] ?? [];
                        selectedDepartment = null;
                        municipalities = [];
                        selectedMunicipality = null;
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Departamento',
                  border: OutlineInputBorder(),
                ),
                value: selectedDepartment,
                items:
                    departments
                        .map(
                          (dept) =>
                              DropdownMenuItem(value: dept, child: Text(dept)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
                    municipalities = departmentToMunicipalities[value!] ?? [];
                    selectedMunicipality = null;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Municipio',
                  border: OutlineInputBorder(),
                ),
                value: selectedMunicipality,
                items:
                    municipalities
                        .map(
                          (mun) =>
                              DropdownMenuItem(value: mun, child: Text(mun)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMunicipality = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Vía Principal',
                  border: OutlineInputBorder(),
                ),
                value: selectedVia,
                items:
                    viasPrincipales
                        .map(
                          (via) =>
                              DropdownMenuItem(value: via, child: Text(via)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedVia = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Número 1',
                  border: OutlineInputBorder(),
                ),
                value: selectedNumber1,
                items:
                    numbers
                        .map(
                          (num) =>
                              DropdownMenuItem(value: num, child: Text(num)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNumber1 = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Letra',
                  border: OutlineInputBorder(),
                ),
                value: selectedLetter1,
                items:
                    letters
                        .map(
                          (letter) => DropdownMenuItem(
                            value: letter,
                            child: Text(letter),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLetter1 = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Número 2',
                  border: OutlineInputBorder(),
                ),
                value: selectedNumber2,
                items:
                    numbers
                        .map(
                          (num) =>
                              DropdownMenuItem(value: num, child: Text(num)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedNumber2 = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Número 3',
                  border: OutlineInputBorder(),
                ),
                value: selectedPosition2,
                items:
                    numbers
                        .map(
                          (num) =>
                              DropdownMenuItem(value: num, child: Text(num)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPosition2 = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Barrio',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    barrio = value;
                    updateDireccionIntegrada();
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Dirección Integrada',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: direccionIntegrada),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Información Adicional',
                  border: OutlineInputBorder(),
                ),
                value: selectedAdditionalInfo,
                items:
                    additionalInfoOptions
                        .map(
                          (info) =>
                              DropdownMenuItem(value: info, child: Text(info)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAdditionalInfo = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Complemento de Información Adicional',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup3');
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
