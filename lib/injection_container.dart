import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> init() async {
  // Features - Auth
  // Bloc
  sl.registerFactory(
        () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      authRepository: sl(), // Inject repository for stream
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => FirebaseAuthRemoteDataSourceImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => firebase_auth.FirebaseAuth.instance);
}