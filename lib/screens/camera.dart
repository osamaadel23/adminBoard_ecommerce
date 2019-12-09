import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class CameraImage extends StatefulWidget {
  static const name = '/Choose-Image';
  final Function taken;
  CameraImage(this.taken);
  @override
  _CameraImageState createState() => _CameraImageState();
}

class _CameraImageState extends State<CameraImage> {
  //Function taken = widget.taken;
  File _image;    
  String _uploadedFileURL;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
     appBar: AppBar(    
       title: Text('Firestore File Upload'),    
     ),    
     body: Center(    
       child: Column(    
         children: <Widget>[    
           Text('Selected Image'),    
           _image != null    
               ? Image.asset(    
                   _image.path,    
                   height: 150,    
                 )    
               : Container(height: 150),    
           _image == null    
               ? RaisedButton(    
                   child: Text('Choose File'),    
                   onPressed: chooseFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),    
           _image != null    
               ? RaisedButton(    
                   child: Text('Upload File'),    
                   onPressed: uploadFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),    
           Text('Uploaded Image'),    
           _uploadedFileURL != null    
               ? Image.network(    
                   _uploadedFileURL,    
                   height: 150,    
                 )    
               : _isLoading ? Center(child: 
               CircularProgressIndicator() ,): Container(),    
         ],    
       ),    
     ),    
   );
  }
  
    Future chooseFile() async {    
       await ImagePicker.pickImage(source: ImageSource.camera).then((image) {    
         setState(() {    
           _image = image;    
         });    
       });    
     }  

    Future uploadFile() async {  
      setState(() {
        _isLoading = true;  
      });
       StorageReference storageReference = FirebaseStorage.instance    
           .ref()    
           .child('chats/${Path.basename(_image.path)}}');    
       StorageUploadTask uploadTask = storageReference.putFile(_image);    
       await uploadTask.onComplete;    
       print('File Uploaded');    
       storageReference.getDownloadURL().then((fileURL) {    
         setState(() {    
           _uploadedFileURL = fileURL;   
            widget.taken(_uploadedFileURL);
            _isLoading = false;
         });    
       });    
     }  
}