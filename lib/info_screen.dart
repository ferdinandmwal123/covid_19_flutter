import 'dart:ui';

import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: 'Get to know',
              textBottom: 'About Covid',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Symptoms',
                    style: kTitleTextstyle,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const[
                       SymptomsCard(
                        image: 'assets/images/headache.png',
                        title: 'Headache',
                        isActive: true,
                      ),
                       SymptomsCard(
                        image: 'assets/images/cough.png',
                        title: 'Cough',
                      ),
                       SymptomsCard(
                        image: 'assets/images/fever.png',
                        title: 'Fever',
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    "Prevention",
                    style: kTitleTextstyle,
                  ),
                  const SizedBox(height: 20,),
                  const PreventCard(
                    text:
                        'Since the outbreak many people have embraced wearing masks',
                    image: 'assets/images/wear_mask.png',
                    title: 'Wear face mask',
                  ),
                  const PreventCard(
                    text:
                        'Since the outbreak many people have embraced wearing masks',
                    image: 'assets/images/wash_hands.png',
                    title: 'Wash your hands',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;

  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 8), blurRadius: 24, color: kShadowColor)
              ]),
        ),
        Image.asset(image),
        Positioned(
            left: 130,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              height: 136,
              width: MediaQuery.of(context).size.width - 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: kTitleTextstyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 10),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset('assets/icons/forward.svg'))
                ],
              ),
            ))
      ],
    );
  }
}

class SymptomsCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomsCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            if (isActive) BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                    color: kActiveShadowColor) else BoxShadow(
                    offset: const Offset(0, 3), blurRadius: 6, color: kShadowColor)
          ]),
      child: Column(
        children: [
          Image.asset(image),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
