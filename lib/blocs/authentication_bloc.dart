abstract class AuthenticationEvent extends BlocEvent {
  final String name;

  AuthenticationEvent({
    this.name: '',
  });
}

class BlocEvent {
}

class AuthenticationEventLogin extends AuthenticationEvent {
  AuthenticationEventLogin({
    String name,
  }) : super(
          name: name,
        );
}

class AuthenticationEventLogout extends AuthenticationEvent {}