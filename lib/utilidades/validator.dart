class Validator {
  static String name(String name) {
    if (name == null || name.isEmpty) {
      return 'Nombre no puede estar en blanco';
    }

    return null;
  }

  static String email(String email) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email == null || email.isEmpty) {
      return 'Email no puede estar en blanco';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Ingresar un Email correcto';
    }

    return null;
  }

  static String password(String password) {
    if (password == null || password.isEmpty) {
      return 'El Password no puede estar en blanco';
    } else if (password.length < 6) {
      return 'Ingresar Password de al menos 6 caracteres';
    }

    return null;
  }
}
