import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revision_2/controllers/profile/profile_state.dart';
import 'package:revision_2/services/firebase_storage.dart';

class ProfileCubit extends Cubit<ProfileState>{
  File? profileImage;
  String? imageUrl;

  ProfileCubit() : super(InitProfileState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  
  void getImageFromCamera() async{
    ImagePicker picker = ImagePicker();
    XFile? xfile = await picker.pickImage(source: ImageSource.camera);
    if(xfile != null){
      profileImage = File(xfile.path);
      emit(GetImageProfileState());
      FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices();
      firebaseStorageServices.uploadImage(profileImage!);
    }
  }

  void getProfileImage() async{
    FirebaseStorageServices firebaseStorageServices = FirebaseStorageServices();
    imageUrl = await firebaseStorageServices.getProfileImage();
    emit(GetImageProfileState());
  }
}