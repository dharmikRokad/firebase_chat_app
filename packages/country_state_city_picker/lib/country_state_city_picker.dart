library country_state_city_picker_nona;

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dropdown_search/dropdown_search.dart';
import 'model/select_status_model.dart' as StatusModel;

class SelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final VoidCallback? onCountryTap;
  final VoidCallback? onStateTap;
  final VoidCallback? onCityTap;
  final TextStyle? style;
  final Color? dropdownColor;
  final InputDecoration decoration;
  final double spacing;

  final String? Function(String?)? countryValidator;
  final String? Function(String?)? stateValidator;
  final String? Function(String?)? cityValidator;

  const SelectState({
    Key? key,
    required this.onCountryChanged,
    required this.onStateChanged,
    required this.onCityChanged,
    this.decoration =
        const InputDecoration(contentPadding: EdgeInsets.all(0.0)),
    this.spacing = 0.0,
    this.style,
    this.dropdownColor,
    this.onCountryTap,
    this.onStateTap,
    this.onCityTap,
    this.cityValidator,
    this.countryValidator,
    this.stateValidator,
  }) : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  List<String> _cities = [];
  List<String> _states = [];
  List<String> _country = [];
  String? _selectedCity;
  String? _selectedState;
  String? _selectedCountry;
  var responses;

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    for (var data in countryres) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) continue;
      setState(() {
        _country.add("${model.emoji!}    ${model.name!}");
      });
    }

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => "${item.emoji}    ${item.name}" == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      if (!mounted) continue;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          log(statename.toString());

          _states.add(statename.toString());
        }
      });
    }

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => "${item.emoji}    ${item.name}" == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            log(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    }
    return _cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = null;
      _states = [];
      _selectedCountry = value;
      widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = null;
      _cities = [];
      _selectedState = value;
      widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      widget.onCityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownSearch<String>(
          items: _country,
          dropdownBuilder: (context, selectedItem) {
            return Container(
              child: selectedItem != null ? Text(selectedItem) : null,
            );
          },
          popupProps: PopupProps.menu(
            disabledItemFn: (value) => value == "Choose Country",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(autofocus: true),
            // showSelectedItems: true,
          ),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              label: Text('Choose Country'),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          validator: widget.countryValidator,
          onChanged: (value) => _onSelectedCountry(value!),
        ),
        SizedBox(height: widget.spacing),
        DropdownSearch<String>(
          items: _states,
          dropdownBuilder: (context, selectedItem) {
            return Container(
              child: selectedItem != null ? Text(selectedItem) : null,
            );
          },
          popupProps: PopupProps.menu(
            disabledItemFn: (value) => value == "Choose  State/Province",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(autofocus: true),
            // showSelectedItems: true,
          ),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              label: Text('Choose  State/Province'),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          validator: widget.stateValidator,
          onChanged: (value) => _onSelectedState(value!),
        ),
        SizedBox(height: widget.spacing),
        DropdownSearch<String>(
          items: _cities,
          dropdownBuilder: (context, selectedItem) {
            return Container(
              child: selectedItem != null ? Text(selectedItem) : null,
            );
          },
          popupProps: PopupProps.menu(
            disabledItemFn: (value) => value == "Choose City",
            showSearchBox: true,
            searchFieldProps: const TextFieldProps(autofocus: true),
            // showSelectedItems: true,
          ),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              label: Text('Choose City'),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          validator: widget.cityValidator,
          onChanged: (value) => _onSelectedCity(value!),
        ),
      ],
    );
  }
}
