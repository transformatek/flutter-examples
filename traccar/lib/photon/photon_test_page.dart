import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/photon_bloc.dart';
import 'models/address_data.dart';

class PhotonTestPage extends StatefulWidget {
  const PhotonTestPage({Key? key, required this.startAddress})
      : super(key: key);
  final ValueChanged startAddress;

  @override
  State<PhotonTestPage> createState() => _PhotonTestPageState();
}

class _PhotonTestPageState extends State<PhotonTestPage> {
  TextEditingController addressController = TextEditingController();
  String selectedText = '';
  List<AddressData> addressesList = [];

  @override
  Widget build(BuildContext context) {
    String localeLanguage = Localizations.localeOf(context).toString();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            const Text('Search Address', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<PhotonBloc, PhotonState>(
          listener: (context, state) {
            if (state is AddressListLoaded) {
              setState(() {
                addressesList = state.photonResponse.addressList;
              });
            }
          },
          child: Column(
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Enter an address',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.location_on_outlined,
                        color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.trim().isEmpty || value == '') {
                      setState(() {
                        selectedText = 'Empty Address selected';
                        addressesList = [];
                      });
                    } else {
                      BlocProvider.of<PhotonBloc>(context).add(
                        GetSelectionLocation(
                            address: value.trim(),
                            localeLanguage: localeLanguage),
                      );
                    }
                  },
                ),
              ),
              if (selectedText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    selectedText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: addressesList.length,
                  itemBuilder: (context, index) {
                    final address =
                        addressesList[index].properties!.fullAddress;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      child: ListTile(
                        title: Text(
                          address,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            selectedText = address;
                            widget.startAddress(address);
                            addressController.text = '';
                            addressesList = [];
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
