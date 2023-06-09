import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../service/api_requests.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService authService;

  SignUpBloc({
    required this.authService,
  }) : super(SignUpInitial()) {
    on<SignUpEvent>(
      (event, emit) async {
        String response = 'Ошибка! Попробуйте еще раз.';

        if (event is SignUpReg) {
          emit(SignUpLoading());
          response = await authService.regUser(
            login: event.login,
            password: event.password,
            name: event.name,
          );
        }
        if (response.contains("Token: ")) {
          emit(SignUpSuccess(token: response));
        } else {
          emit(SignUpError(error: response));
        }
      },
    );
  }
}