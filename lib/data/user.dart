class User{
  final String username;
  final String password;
  late String JWT;

  User({required this.username, required this.password});

  void assignJWT(jwToken){
    this.JWT=jwToken;
  }

}