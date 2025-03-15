import 'dart:io';
import 'package:facedetection/core/constant/app_colors.dart';
import 'package:facedetection/core/functions/show_loading_dialog.dart';
import 'package:facedetection/core/functions/success_snack_bar.dart';
import 'package:facedetection/face_detection_enjection.dart';
import 'package:facedetection/view_model/cubit/detection_cubit.dart';
import 'package:facedetection/views/widgets/custom_icon_button.dart';
import 'package:facedetection/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterFaceScreen extends StatefulWidget {
  const RegisterFaceScreen({super.key});

  @override
  State<RegisterFaceScreen> createState() => _RegisterFaceScreenState();
}

class _RegisterFaceScreenState extends State<RegisterFaceScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  TextEditingController controller = TextEditingController();
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageUseGallary() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ls<DetectionCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          title: Text(
            'Face Register',
          ),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: BlocListener<DetectionCubit, DetectionState>(
          listener: (context, state) {
            if (state is DetecationLoadingSate) {
              showLoadingDialog(context);
            } else if (state is DetectionErrorState) {
              Navigator.pop(context);
            } else if (state is DetecationLoadedSate) {
              Navigator.pop(context);
              Navigator.pop(context);
              showSnackBar('Registering success', context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 150,
                  backgroundImage:
                      _imageFile == null ? null : FileImage(_imageFile!),
                  backgroundColor: AppColors.secondColor,
                ),
                CustomTextField(controller: controller),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                          label: "Gallary",
                          icon: Icons.photo,
                          onTap: () => _pickImageUseGallary()),
                      Builder(builder: (context) {
                        return CustomIconButton(
                            icon: Icons.save_rounded,
                            onTap: () {
                              if (_imageFile != null &&
                                  controller.text.isNotEmpty) {
                                BlocProvider.of<DetectionCubit>(context)
                                    .register(
                                        image: _imageFile!,
                                        name: controller.text);
                              } else {
                                showSnackBar(
                                    "Please fill all the fields", context);
                              }
                            },
                            label: 'Save');
                      }),
                      CustomIconButton(
                          label: 'Camera',
                          icon: Icons.camera,
                          onTap: () => _pickImage())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
