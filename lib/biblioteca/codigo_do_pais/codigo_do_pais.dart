import 'package:flutter/material.dart';
/*
import 'package:country_phone_code_picker/country_phone_code_picker.dart';

class CodigoDoPais extends StatefulWidget {
  CodigoDoPais({super.key});

  // You need an instance of the countryController before you can use the countryController
  final CountryController countryController = getCountryController();

  @override
  State<CodigoDoPais> createState() => _CodigoDoPaisState();
}

class _CodigoDoPaisState extends State<CodigoDoPais> {
  @override
  void initState() {
    super.initState();
    // It is important to initialize the countryController to use its values in the application later on!
    // Just use this function below to initialize the countryController!
    initializeCountryController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Phone Code Picker'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CountryPhoneCodePicker.withDefaultSelectedCountry(
                countryController: widget.countryController,
                defaultCountryCode:
                    Country(name: 'India', countryCode: 'IN', phoneCode: '+91'),
                borderRadius: 5,
                borderWidth: 1,
                flagBorderRadius: 5,
                flagHeight: 20,
                flagWidth: 30,
                borderColor: Colors.grey,
                style: const TextStyle(fontSize: 16),
                searchBarHintText: 'Search by name',
              ),
              const SizedBox(height: 10),
              CountryFlagWidget(
                height: 30,
                width: 50,
                borderStyle: BorderStyle.none,
              ),
              const SizedBox(height: 10),
              CountryNameWidget(
                height: 30,
                width: 50,
                borderStyle: BorderStyle.none,
                textStyle: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              CountryCodeWidget(
                height: 30,
                width: 50,
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CountryPhoneCodeWidget(
                height: 30,
                width: 50,
                textStyle: const TextStyle(fontSize: 15),
                borderWidth: 1,
                borderRadius: 5,
                borderColor: Colors.black,
              ),
              const SizedBox(height: 10),
              // access the value of the countryController like this.
              Text(widget.countryController.selectedCountryCode)
            ],
          ),
        ),
      ),
    );
  }
}
*/