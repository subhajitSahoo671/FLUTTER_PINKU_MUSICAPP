
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_bar.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/profile_info_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Profile'),
        action: IconButton(onPressed: () {
          
        }, icon: FaIcon(FontAwesomeIcons.ellipsisVertical, size: 22,)),
      ),
      body: Container(
        color: AppColors.primary.withValues(alpha: 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _profileInfo( context),
            SizedBox(height: 30,),
            _favoriteSongs()
          ],
        ),
      ),
    );
  }

  Widget _profileInfo( context){
        return BlocProvider(
          create: (context) => ProfileInfoCubit()..getUser(),
          child:  Container(
                height: MediaQuery.sizeOf(context).height/4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightBackground,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
                ),
                child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {

              if (state is ProfileInfoLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is ProfileInfoLoaded) {
                 return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 47,
                    backgroundImage: NetworkImage(state.userEntity.imageURL!),
                  ),
                  SizedBox(height: 15),
                  Text(
                    state.userEntity.email!, 
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                   SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!, 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              );
              }

             if (state is ProfileInfoFailure) {
                return Center(child: Text('Please try again later'));
              }
              return Container();
            },
        )
        )
        );
  }


Widget _favoriteSongs(){
  return BlocProvider(
  create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("FAVORITE SONGS",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.lightBackground),),
        BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(
          builder: (context, state) {
          if (state is FavoriteSongsLoading) {
            return Center(child: CircularProgressIndicator.adaptive(),);
          }
    
          if (state is FavoriteSongsLoaded) {
           return ListView.separated(
            shrinkWrap: true,
              itemCount: state.favoriteSongs.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 5,);
              },
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    
                  ],
                );
              },
            );
          }
    
          if (state is FavoriteSongsFailure) {
            return Text("Please try again");
          }
    
          return Container();
        },)
      ],
    ),
  ),
  );
}
}
