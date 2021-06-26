import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageInput extends HookWidget {
  const ImageInput(this.onSaveImage, {Key? key}) : super(key: key);
  final Function onSaveImage;

  @override
  Widget build(BuildContext context) {
    final storedImage = useState<File?>(null);

    Future<void> takePicture() async {
      final picker = ImagePicker();
      PickedFile? imageFile = await picker.getImage(source: ImageSource.camera);

      if (imageFile == null) {
        return;
      }

      storedImage.value = File(imageFile.path);
      Directory appDir = await getApplicationDocumentsDirectory();
      String fileName = p.basename(imageFile.path);
      File savedImage =
          await storedImage.value!.copy('${appDir.path}/$fileName');
      onSaveImage(savedImage);
    }

    return Row(
      children: [
        Container(
          width: 180,
          height: 120,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: storedImage.value != null
              ? Image.file(
                  File(storedImage.value!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        Expanded(
            child: TextButton.icon(
          onPressed: takePicture,
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
        ))
      ],
    );
  }
}
