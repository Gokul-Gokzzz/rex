import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/carsoul_provider.dart';
import 'package:rexparts/view/home/home.dart';

Widget slide({required carouselimage, required double height}) {
  return Stack(
    children: [
      Consumer<CaroselProvider>(
        builder: (context, value, child) => CarouselSlider(
          items: slider.map((item) {
            return Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Colors.grey,
                  ),
                ],
              ),
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: 300,
                  height: 150,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              value.carouselChange(index);
            },
          ),
        ),
      ),
    ],
  );
}
