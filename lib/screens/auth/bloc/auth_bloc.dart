import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:know_your_time/screens/auth/bloc/auth_event.dart';
import 'package:know_your_time/screens/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.initState()) {
    on<SignInWithEmailAndPasswordEvent>(_signInWithEmailAndPassword);
    on<SignInWithAppleEvent>(_signInWithApple);
    on<SignInWithFacebookEvent>(_signInWithFacebook);
    on<SignInWithGoogleEvent>(_signInWithGoogle);
    on<RegisterWithEmailAndPasswordEvent>(_registerWithEmailAndPassword);
    on<UpdateUserRegistrationStatusEvent>(_updateUserRegistrationStatus);
  }

  void _updateUserRegistrationStatus(
    UpdateUserRegistrationStatusEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      AuthState(
        isUserRegistered: event.isUserRegister,
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(
    SignInWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final String _email = event.email;
    final String _password = event.password;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    final User? user = await _authRepository.signInWithEmailAndPassword(
      EmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      ),
    );
    if (user == null) {
      Fluttertoast.showToast(
        msg: 'general.cant_sign_in_toast'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _signInWithApple(
    SignInWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signInWithSocial(
      AppleSignIn(),
    );
  }

  Future<void> _signInWithFacebook(
    SignInWithFacebookEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signInWithSocial(
      FacebookSignIn(),
    );
  }

  Future<void> _signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signInWithSocial(
      GoogleSignIn(),
    );
  }

  Future<void> _registerWithEmailAndPassword(
    RegisterWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final String _email = event.email;
    final String _password = event.password;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    final User? user = await _authRepository.signUpWithEmailAndPassword(
      EmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      ),
    );
    if (user == null) {
      Fluttertoast.showToast(
        msg: 'general.cant_register_toast'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    }
  }
}
