import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatelessWidget {
  final double maxImageWidth;
  final double maxImageHeight;
  final Function(XFile) onImageSelected;

  const ImagePickerButton(
      {Key key,
      this.maxImageWidth,
      this.maxImageHeight,
      @required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getImage(ImageSource src) async {
      var img = await ImagePicker().pickImage(
          source: src, maxHeight: maxImageHeight, maxWidth: maxImageWidth);
      if (onImageSelected != null) {
        onImageSelected(img);
      }
    }

    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                    title: Text("Camera/Gallery"),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () async {
                          Navigator.pop(context); //close the dialog box
                          _getImage(ImageSource.gallery);
                        },
                        child: const Text('Pick From Gallery'),
                      ),
                      SimpleDialogOption(
                        onPressed: () async {
                          Navigator.pop(context); //close the dialog box
                          _getImage(ImageSource.camera);
                        },
                        child: const Text('Take A New Picture'),
                      ),
                    ]);
              });
        },
        child: Text("Scan Your Ingredient"));
  }
}
