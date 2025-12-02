import 'package:get_it/get_it.dart';
import 'package:shopping_flutter_app/features/auth/login/data/repositoriesImpl/login_repo_impl.dart';
import 'package:shopping_flutter_app/features/auth/login/presentation/viewmodel/login_viewmodel.dart';
import 'package:shopping_flutter_app/features/auth/signup/data/data_source/signup_remote_data_source.dart';
import 'package:shopping_flutter_app/features/auth/signup/data/repositoriesImpl/signup_repo_impl.dart';
import 'package:shopping_flutter_app/features/auth/signup/domain/usecase/signup_usecase.dart';
import 'package:shopping_flutter_app/features/auth/signup/presentation/viewModel/signup_view_model.dart';
import 'package:shopping_flutter_app/features/home/data/datasource/home_data_source.dart';
import 'package:shopping_flutter_app/features/home/data/repositoriesImpl/home_repositories_impl.dart';
import 'package:shopping_flutter_app/features/home/domain/usecases/home_use_cases.dart';
import 'package:shopping_flutter_app/features/home/presentation/viewmodel/home_view_model.dart';
import 'core/network/local/local_storage.dart';
import 'core/network/remote/api_client.dart';
import 'features/auth/login/data/datasource/remote_data_source.dart';
import 'features/auth/login/domain/usecases/login_user.dart';
import 'features/cart/presentation/ViewModel/cart_viewmodel.dart';
import 'features/favorite/domain/repositories/favorite_repository.dart';
import 'features/favorite/domain/usecase/favorite_usecase.dart';
import 'features/favorite/presentation/viewmodel/favorite_view_model.dart';
import 'features/products/presentation/viewmodel/product_view_model.dart';

final getIt = GetIt.instance;


void setupDI() {
  //core
  getIt.registerLazySingleton<ApiClient>(()=> ApiClient());

  //dataSource
  getIt.registerLazySingleton<RemoteDataSource>(()=>RemoteDataSourceImpl(getIt<ApiClient>()));
  getIt.registerLazySingleton<SignupRemoteData>(()=>SignupRemoteDataImpl(getIt<ApiClient>()));
  getIt.registerLazySingleton<HomeDataSource>(()=>HomeDataSourceImpl(getIt<ApiClient>()));


  // Repository
  getIt.registerLazySingleton<LoginRepoImpl>(()=>LoginRepoImpl(getIt<RemoteDataSource>()));
  getIt.registerLazySingleton<SignupRepoImpl>(()=>SignupRepoImpl(getIt<SignupRemoteData>()));
  getIt.registerLazySingleton<HomeRepoImpl>(()=>HomeRepoImpl(getIt<HomeDataSource>(),getIt<LocalStorage>()));
  getIt.registerLazySingleton<FavoriteRepository>(()=>FavoriteRepository(getIt<LocalStorage>()));


  //useCase
  getIt.registerLazySingleton<LoginUserUseCase>(()=>LoginUserUseCase(getIt<LoginRepoImpl>()));
  getIt.registerLazySingleton<SignupUseCase>(()=>SignupUseCase(getIt<SignupRepoImpl>()));
  getIt.registerLazySingleton<HomeUseCases>(()=>HomeUseCases(getIt<HomeRepoImpl>()));
  getIt.registerLazySingleton<FavoriteUseCase>(()=>FavoriteUseCase(getIt<FavoriteRepository>()));


  //viewModel
  getIt.registerLazySingleton<LoginViewModel>(()=>LoginViewModel(getIt<LoginUserUseCase>(),getIt<LocalStorage>()));
  getIt.registerLazySingleton<SignupViewModel>(()=>SignupViewModel(getIt<SignupUseCase>(),getIt<LocalStorage>()));
  getIt.registerLazySingleton<HomeViewModel>(()=>HomeViewModel(getIt<HomeUseCases>(),getIt<LocalStorage>(),getIt<FavoriteUseCase>()));
  getIt.registerLazySingleton<CartViewModel>(()=>CartViewModel(getIt<LocalStorage>()));
  getIt.registerLazySingleton<ProductViewModel>(()=>ProductViewModel(getIt<LocalStorage>()));
  getIt.registerLazySingleton<FavoritesViewModel>(()=>FavoritesViewModel(getIt<LocalStorage>(),getIt<HomeUseCases>()));


  // inject classes
  getIt.registerLazySingleton<LocalStorage>(()=>LocalStorage());



}