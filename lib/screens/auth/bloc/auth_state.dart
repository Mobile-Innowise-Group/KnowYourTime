class AuthState {
  final bool? isUserRegistered;
  final bool? isInternetAvailable;

  AuthState({
    this.isUserRegistered,
    this.isInternetAvailable,
  });

  factory AuthState.initState() {
    return AuthState(
      isUserRegistered: true,
      isInternetAvailable: true,
    );
  }

  AuthState copyWith({
    bool? isUserRegistered,
    bool? isInternetAvailable,
  }) {
    return AuthState(
      isUserRegistered: isUserRegistered ?? this.isUserRegistered,
      isInternetAvailable: isInternetAvailable ?? this.isInternetAvailable,
    );
  }
}
