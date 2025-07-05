import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await remoteDataSource.signIn(email, password);
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final user = await remoteDataSource.register(email, password);
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.signOut();
  }
}
