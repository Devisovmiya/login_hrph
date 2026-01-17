import 'package:login_hrph/state/editform_state.dart';
import 'package:riverpod/legacy.dart';

final editProfileFormProvider =
    StateNotifierProvider<EditProfileFormNotifier, EditProfileFormState>((ref) {
      return EditProfileFormNotifier();
    });

class EditProfileFormNotifier extends StateNotifier<EditProfileFormState> {
  EditProfileFormNotifier()
    : super(
        EditProfileFormState(
          username: '',
          email: '',
          phnum: '',
          city: '',
          dob: DateTime.now(),
          gender: 'Male',
        ),
      );
  //load user_details from Hive
  // ignore: strict_top_level_inference
  void loadUser(user) {
    state = EditProfileFormState(
      username: user.username ?? '',
      email: user.email ?? '',
      phnum: user.phnum ?? '',
      city: user.city ?? '',
      dob: user.dob,
      gender: user.gender ?? 'Male',
    );
  }

  void setUsername(String v) => state = state.copyWith(username: v);
  void setEmail(String v) => state = state.copyWith(email: v);
  void setphonenum(String v) => state = state.copyWith(phnum: v);
  void setCity(String v) => state = state.copyWith(city: v);
  void setDob(DateTime v) => state = state.copyWith(dob: v);
  void setGender(String v) => state = state.copyWith(gender: v);



  
}

