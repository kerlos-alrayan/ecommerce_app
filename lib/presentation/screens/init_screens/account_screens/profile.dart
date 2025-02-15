import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/cubits/profile_cubit/profile_cubit.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xffD9D9D9),
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileSuccess) {
            final profileData = state.profile.data;
            return Column(
              children: [
                Divider(
                  height: 2,
                  color: const Color(0xffD9D9D9),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Color(0xff9098B1),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: profileData.image,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Color(0xff9098B1),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileData.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '@${profileData.name}',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              color: Color(0xff9098B1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _profileItems(
                  icon: Icons.perm_identity_outlined,
                  text: 'ID',
                  suffixText: '${profileData.id}',
                  func: () {},
                ),
                _profileItems(
                  icon: Icons.control_point_duplicate_outlined,
                  text: 'Points',
                  suffixText: '${profileData.points}',
                  func: () {},
                ),
                _profileItems(
                  icon: Icons.credit_card_outlined,
                  text: 'credit',
                  suffixText: '${profileData.credit}',
                  func: () {},
                ),
                _profileItems(
                  icon: Icons.email_outlined,
                  text: 'Email',
                  suffixText: profileData.email,
                  func: () {},
                ),
                _profileItems(
                  icon: Icons.phone_android,
                  text: 'Phone Number',
                  suffixText: profileData.phone,
                  func: () {},
                ),
                _profileItems(
                  icon: Icons.lock_outline_sharp,
                  text: 'Change Password',
                  suffixText: '********',
                  func: () {},
                ),


              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _profileItems({
    required IconData icon,
    required String text,
    required String suffixText,
    required Function func,
  }) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 60  ,
        width: double.infinity,
        child: Row(
          spacing: 16,
          children: [
            Icon(
              icon,
              color: Color(0xff40BFFF),
              size: 30,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black),
              ),
            ),
            Text(
              suffixText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Color(0xff9098B1),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xff9098B1),
            ),
          ],
        ),
      ),
    );
  }
}
