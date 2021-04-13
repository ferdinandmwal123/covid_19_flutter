import 'dart:convert';
import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: kBodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map worldData;
  fetchWorlData() async {
    final http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body) as Map;
    });
  }

 

  @override
  void initState() {
    fetchWorlData();
    super.initState();
  }

//Always ensure this stays outside the widget
  String dropDownValue = 'WorldWide';
  @override
  Widget build(BuildContext context) {
    final today = formatDate(DateTime.now(), [M, ' ', d]);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "Avoid crowds",
              textBottom: "stay at home.",
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFFE5E5E5))),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/maps-and-flags.svg'),
                  const SizedBox(width: 20),
                  Expanded(
                      child: DropdownButton<String>(
                    value: dropDownValue,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                    },
                    items: ['WorldWide', 'Kenya', 'USA', 'Japan']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "$dropDownValue Case Update\n",
                            style: kTitleTextstyle),
                        TextSpan(
                            text: "Newest update $today",
                            style: const TextStyle(
                              color: kTextLightColor,
                            ))
                      ])),
                      const Spacer(),
                      const Text("See details",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 30,
                              color: kShadowColor)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Counter(
                          color: kInfectedColor,
                          number: worldData == null
                              ? const Text('Failed').toString()
                              : worldData['cases']
                                  .toString(), //remember api countries are + 15
                          title: 'Infected',
                        ),
                        Counter(
                          color: kDeathColor,
                          number: worldData == null
                              ? const Text('Failed').toString()
                              : worldData['deaths'].toString(),
                          title: 'Deaths',
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: worldData == null
                              ? const Text('Failed').toString()
                              : worldData['recovered'].toString(),
                          title: 'Recovered',
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const[
                       Text(
                        'Spread of virus',
                        style: kTitleTextstyle,
                      ),
                       Text(
                        'See details',
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(20),
                    height: 175,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 30,
                            color: kShadowColor)
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
