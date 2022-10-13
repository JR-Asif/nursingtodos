import 'package:flutter/material.dart';
import 'package:get/get.dart';

taskListBox(String title, var colors, String image) {
  return Container(
      width: Get.width * 0.65,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28, left: 24, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                const Text(
                  "Lorem ipsum is a placeholder as text commonly used to demon- strate the visual form of a document",
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                // Spacer(),
              ],
            ),
          ),
         SizedBox(height: 10),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(  
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitHeight,
                  )),
            ),
          )
        ],
      ));
}
