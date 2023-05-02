import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:software_todo_app_v2/bloc/login_state.dart';
import 'package:software_todo_app_v2/dto/login_response_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_todo_app_v2/services/login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login(String username, String password) async {
    const storage = FlutterSecureStorage(); // para mantener los tokens seguros
    emit(state.copyWith(status: PageStatus.loading));
    try {
      LoginResponseDto loginResponse = await LoginService.login(
          username, password); // devuelve {token, refreshToken}
      await storage.write(key: "Token", value: loginResponse.authToken);
      await storage.write(
          key: "Refresh",
          value: loginResponse
              .refreshToken); // TODO: actualizar el token cada cierto tiempo
      emit(state.copyWith(
          status: PageStatus.success,
          loginSuccess: true,
          token: loginResponse.authToken,
          refreshToken: loginResponse.refreshToken));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: PageStatus.failure,
          loginSuccess: false,
          errorMessage: e.toString(),
          exception: e));
    }
  }
}
