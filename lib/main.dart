import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage/details_pays.dart';
import 'package:stage/service/country.dart';
import 'package:stage/service/data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const WhatsAppScreen(),
    );
  }
}

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({super.key});

  @override
  State<WhatsAppScreen> createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
  late Future<List<Country>> futureCountries;
  bool isSearch = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureCountries = fetchCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ?  TextField(
                decoration: const InputDecoration(
                  hintText: "Search...",
                ),
               onChanged: (query) => setState(() => searchQuery = query),
              )
            : const Text('ParPays', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(isSearch ? Icons.arrow_back_outlined : Icons.search),
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
                if (!isSearch) {
                  searchQuery = '';
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No countries found');
          } else {
            List<Country> countries = snapshot.data!;
            countries.sort((a, b) => a.name.compareTo(b.name));
            if(isSearch){
              countries = countries.where((country) => country.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
            }
            if(countries.isEmpty){
              return const Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Text('No Countries found '),
              );
            }

            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                var country = countries[index];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(country.flag),
                            ),
                          ),
                          title: Text(
                            country.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            country.capital,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPays(countryId: country.id),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
