import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/wine_controller.dart';

class WinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WineController>();

    return Scaffold(
      appBar: AppBar(title: Text('Wine Shop')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.wines.length,
            itemBuilder: (context, index) {
              final wine = controller.wines[index];
              return ListTile(
                title: Text(wine.title),
                subtitle: Text(wine.subtitle),
              );
            },
          );
        }
      }),
    );
  }
}
