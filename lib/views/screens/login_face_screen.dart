import 'dart:io';
import 'package:facedetection/core/constant/app_colors.dart';
import 'package:facedetection/core/functions/show_error_dialog.dart';
import 'package:facedetection/face_detection_enjection.dart';
import 'package:facedetection/service/open_ai_service.dart';
import 'package:facedetection/service/supabase_service.dart';
import 'package:facedetection/view_model/cubit/detection_cubit.dart';
import 'package:facedetection/views/screens/success_login_screen.dart';
import 'package:facedetection/views/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginFaceScreen extends StatefulWidget {
  const LoginFaceScreen({super.key});

  @override
  _LoginFaceScreenState createState() => _LoginFaceScreenState();
}

class _LoginFaceScreenState extends State<LoginFaceScreen> {
  File? _imageFile;
  final picker = ImagePicker();
  final openAIService = OpenAIService();
  final supabaseService = SupabaseService(supabase: Supabase.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: Text(
          'Face Login',
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => ls<DetectionCubit>(),
        child: BlocListener<DetectionCubit, DetectionState>(
          listener: (context, state) {
            if (state is DetecationLoadingSate) {
              showDialog(
                  context: context,
                  builder: (context) => Center(
                        child: Container(
                          height: 60,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColors.secondColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Scaning...',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ));
            } else if (state is DetectionErrorState) {
              Navigator.pop(context);
              showErrorDialog(context, state.message);
            } else if (state is DetectionLoginedState) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuccessLoginScreen(
                            face: state.face,
                          )));
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 150,
                  backgroundImage:
                      _imageFile == null ? null : FileImage(_imageFile!),
                  backgroundColor: AppColors.secondColor,
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Builder(builder: (context) {
                    return CustomIconButton(
                        label: 'Camera',
                        icon: Icons.camera,
                        onTap: () async {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.camera);
                          if (pickedFile != null) {
                            setState(() {
                              _imageFile = File(pickedFile.path);
                            });
                            BlocProvider.of<DetectionCubit>(context)
                                .login(image: _imageFile!);
                          }
                        });
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
