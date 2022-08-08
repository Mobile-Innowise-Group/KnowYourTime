import 'package:core/core.dart';
import 'package:data/src/providers/time_frame/time_frame_api_provider.dart';
import 'package:data/src/providers/time_frame/time_frame_provider.dart';
import 'package:data/src/repositories/auth_repository_impl.dart';
import 'package:data/src/repositories/time_frame/time_frame_repository_impl.dart';
import 'package:data/src/services/firebase_auth_service.dart';
import 'package:domain/domain.dart';

class DataDI {
  static void initDependencies() {
    serviceLocator.registerSingleton<TimeFrameProvider>(TimeFrameApiProvider());
    serviceLocator.registerSingleton<TimeFrameRepository>(
      TimeFrameRepositoryImpl(
        timeFrameProvider: serviceLocator.get<TimeFrameProvider>(),
      ),
    );
    serviceLocator.registerLazySingleton<AuthService>(AuthService.new);
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authService: serviceLocator.get<AuthService>(),
      ),
    );
  }
}
