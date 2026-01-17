

class EditProfileFormState {
final String username;
final String email;
final String phnum;
final String city;
final DateTime dob;
final String gender;

  const EditProfileFormState({
    required this.username,
    required this.email,
    required this.phnum,
    required this.city,
    required this.dob,
    required this.gender,
  });

  EditProfileFormState copyWith({
    String? username,
    String? email,
    String? phnum,
    String? city,
    DateTime? dob,
    String? gender,
  }) {
    return EditProfileFormState(
      username: username ?? this.username,
      email: email ?? this.email,
      phnum: phnum?? this.phnum,
      city: city ?? this.city,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
    );
  }
}
