import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'location_list_tile.dart';
import 'network_utility.dart';
import 'auto_complete_address.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<AutocompletePrediction> placePredictions = [];

  TextEditingController textEditingController = TextEditingController();

  Future<void> placeAutocomplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {
          "input": query,
          "key": 'AIzaSyDkYhA_4XQR2JZXJ7kvdnWNMPrJayoCZzU',
        });
    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  void updateSearchBar(String selectedLocation) {
    setState(() {
      textEditingController.text = selectedLocation;
      placePredictions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: textEditingController,
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search Property Address",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.location_pin),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: placePredictions.length,
              itemBuilder: (context, index) => LocationListTile(
                press: () {
                  updateSearchBar(placePredictions[index].description!);
                },
                location: placePredictions[index].description!,
              ),
            ),
          )
        ],
      ),
    );
  }
}
