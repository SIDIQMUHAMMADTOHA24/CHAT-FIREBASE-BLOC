import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:secure_chat/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:secure_chat/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:secure_chat/features/auth/domain/entities/user_entity.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, User])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockUser mockUser;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    mockUser = MockUser();
  });

  group('login', () {
    const testEmail = 'test@mail.com';
    const testPassword = 'password123';

    test('should return UserEntity when login is successful', () async {
      // arrange
      when(mockUser.uid).thenReturn('abc123');
      when(mockUser.email).thenReturn(testEmail);
      when(
        mockRemoteDataSource.signIn(testEmail, testPassword),
      ).thenAnswer((_) async => mockUser);

      // act
      final result = await repository.login(testEmail, testPassword);

      // assert
      expect(result, isA<UserEntity>());
      expect(result.uid, 'abc123');
      expect(result.email, testEmail);
      verify(mockRemoteDataSource.signIn(testEmail, testPassword)).called(1);
    });
  });

  group('register', () {
    const testEmail = 'test@mail.com';
    const testPassword = 'password123';

    test('should return UserEntity when register is successful', () async {
      // arrange
      when(mockUser.uid).thenReturn('abc123');
      when(mockUser.email).thenReturn(testEmail);
      when(
        mockRemoteDataSource.register(testEmail, testPassword),
      ).thenAnswer((_) async => mockUser);

      // act
      final result = await repository.register(testEmail, testPassword);

      // assert
      expect(result, isA<UserEntity>());
      expect(result.uid, 'abc123');
      expect(result.email, testEmail);
      verify(mockRemoteDataSource.register(testEmail, testPassword)).called(1);
    });
  });

  group('logout', () {
    test('should call remoteDataSource.signOut()', () async {
      // arrange
      when(mockRemoteDataSource.signOut()).thenAnswer((_) async {});

      // act
      await repository.logout();

      // assert
      verify(mockRemoteDataSource.signOut()).called(1);
    });
  });
}
