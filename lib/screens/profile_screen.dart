import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision_2/controllers/profile/profile_cubit.dart';
import 'package:revision_2/controllers/profile/profile_state.dart';
import 'package:revision_2/local/shared_prference.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileCubit.get(context).getProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state){
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          backgroundImage: ProfileCubit.get(context).imageUrl != null ? 
                            NetworkImage(ProfileCubit.get(context).imageUrl!) : null,
                        );
                      } ,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: (){
                            ProfileCubit.get(context).getImageFromCamera();
                          }, 
                          icon: Icon(Icons.camera_alt_outlined, size: 15,),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  Cache.getName().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Cache.getEmail().toString(),
                  style: TextStyle(),
                ),
                SizedBox(height: 10,),
                Text(
                  Cache.getPhone().toString(),
                  style: TextStyle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}