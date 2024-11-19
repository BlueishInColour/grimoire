import 'dart:io';
import 'dart:math';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:provider/provider.dart';

class CropImageScreen extends StatefulWidget {
  const CropImageScreen({super.key,required this.ratio,required this.afterCropped});
final Ratio? ratio;
final Function(MemoryImage) afterCropped;

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {

  late CustomImageCropController controller;

  @override
  void initState() {
    super.initState();
    controller = CustomImageCropController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PublishController>(
      builder: (context,c,child)=> Scaffold(
        appBar: AppBar(
          title: Text("crop image"),
          actions: [
            IconButton(onPressed: ()async{
              final image = await controller.onCropImage();
              if (image != null) {
             widget.afterCropped(image);
              }
              }, icon: Icon(Icons.check,color: Colors.green.shade900,))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomImageCrop(
                forceInsideCropArea: true,
                ratio: widget.ratio,
                shape: CustomCropShape.Ratio,
                cropController: controller,
                image:FileImage(File(c.bookCoverPhotoPath)), // Any Imageprovider will work, try with a NetworkImage for example...
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: const Icon(Icons.refresh), onPressed: controller.reset),
                IconButton(icon: const Icon(Icons.zoom_in), onPressed: () => controller.addTransition(CropImageData(scale: 1.33))),
                IconButton(icon: const Icon(Icons.zoom_out), onPressed: () => controller.addTransition(CropImageData(scale: 0.75))),
                IconButton(icon: const Icon(Icons.rotate_left), onPressed: () => controller.addTransition(CropImageData(angle: -pi / 4))),
                IconButton(icon: const Icon(Icons.rotate_right), onPressed: () => controller.addTransition(CropImageData(angle: pi / 4))),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),

      ),
    );
  }
}
