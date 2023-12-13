import 'package:bloc/bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<FetchProfileData>(_fetchProfileData);
  }

  void _fetchProfileData(
    FetchProfileData event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('profile')
              .doc('An2djocCyq9Hc22opqop')
              .get();

      // Extracting fields from the snapshot
      final name = snapshot['name'];
      final imageUrl = snapshot['image_url'];
      final email = snapshot['email'];
      final address = snapshot['address'];

      // Emitting ProfileLoadedState with extracted data
      emit(ProfileLoadedState(
        name: name,
        imageUrl: imageUrl,
        email: email,
        address: address,
      ));
    } catch (error) {
      emit(ProfileErrorState('Failed to fetch profile data'));
    }
  }
}


