class AuthState {
  final bool isUserRegistered;

  AuthState({
    required this.isUserRegistered,
  });

  factory AuthState.initState() {
    return AuthState(
      isUserRegistered: true,
    );
  }
}
