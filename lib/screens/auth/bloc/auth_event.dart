abstract class AuthEvent {
  AuthEvent();
}

class SignInWithEmailAndPasswordEvent implements AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

class SignInWithAppleEvent implements AuthEvent {
  SignInWithAppleEvent();
}

class SignInWithFacebookEvent implements AuthEvent {
  SignInWithFacebookEvent();
}

class SignInWithGoogleEvent implements AuthEvent {
  SignInWithGoogleEvent();
}

class UpdateUserRegistrationStatusEvent implements AuthEvent {
  final bool isUserRegister;

  UpdateUserRegistrationStatusEvent({
    required this.isUserRegister,
  });
}

class RegisterWithEmailAndPasswordEvent implements AuthEvent {
  final String email;
  final String password;

  RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}
