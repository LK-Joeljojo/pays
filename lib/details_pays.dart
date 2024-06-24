import 'package:flutter/material.dart';
import 'package:stage/service/country.dart';
import 'package:stage/service/data_service.dart';

class DetailsPays extends StatelessWidget {
  final String countryId;
  const DetailsPays({
    super.key,
    required this.countryId,
  });



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Country>(
      future: fetchCountryById(countryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {

          var country = snapshot.data!;

          return Scaffold(
            appBar: AppBar(

            ),
            body: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Card(
                              child:  Image.network(country.flag),



                            ),
                            const SizedBox(height: 10,),
                            Text(  "Name : ${country.name}"),
                            const SizedBox(height: 10,),
                            Text(  "Capital : ${country.capital}"),

                          ],
                        ),
                      )

                    ],
                  ),
                ),

              ],
            ),
          );
        }
      },
    );
  }
}








