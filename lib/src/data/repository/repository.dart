import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:barayafood/core/app_asset.dart';
import 'package:barayafood/src/data/model/barayafood.dart';
import 'package:barayafood/src/data/model/barayafood_color.dart';

class Repository {
  get getBarayaFoodList {
    const dummyText = """Makanan Enak, jika dimakan saat lapar.""";

    List<BarayaFood> barayafoodList = [
      BarayaFood(
        id: 1,
        quantity: 1,
        title: 'Mie Ayam enak',
        description: dummyText,
        price: 15000.0,
        distance: 3.5,
        images: const [
          AppAsset.mieayam1,
          AppAsset.mieayam2,
          AppAsset.mieayam3,
          AppAsset.mieayam4,
          AppAsset.mieayam5,
          AppAsset.mieayam6,
          AppAsset.mieayam7,
        ],
      ),
      BarayaFood(
        id: 2,
        quantity: 1,
        title: 'Bubur ayam',
        description: dummyText,
        price: 10000.0,
        distance: 1.5,
        images: const [
          AppAsset.bubur1,
          AppAsset.bubur2,
          AppAsset.bubur3,
          AppAsset.bubur4,
          AppAsset.bubur5,
        ],
      ),
      BarayaFood(
        id: 3,
        quantity: 1,
        title: 'Kupat tahu',
        description: dummyText,
        price: 10000.0,
        distance: 0.3,
        images: const [
          AppAsset.kupat1,
          AppAsset.kupat2,
          AppAsset.kupat3,
          AppAsset.kupat4,
          AppAsset.kupat5,
          AppAsset.kupat6,
        ],
      ),
      BarayaFood(
        id: 4,
        quantity: 1,
        title: 'Batagor',
        description: dummyText,
        price: 10000.00,
        distance: 2.5,
        images: const [
          AppAsset.batagor1,
          AppAsset.batagor2,
          AppAsset.batagor3,
          AppAsset.batagor4,
          AppAsset.batagor5,
          AppAsset.batagor6,
        ],
      ),
      BarayaFood(
        id: 5,
        quantity: 1,
        title: 'Mie Bakso',
        description: dummyText,
        price: 12000.0,
        distance: 2.8,
        images: const [
          AppAsset.miebakso1,
          AppAsset.miebakso2,
          AppAsset.miebakso3,
          AppAsset.miebakso4,
          AppAsset.miebakso5,
        ],
      ),
    ];

    return barayafoodList;
  }
}
