import '../../model/login_model.dart';

abstract class FistanState{}

class FistanInitialState extends FistanState{}

class FistanChangeSecureState extends FistanState{}

class FistanLoginProgressState extends FistanState{}

class FistanLoginSuccessState extends FistanState{
  late LoginModel object;
 FistanLoginSuccessState(this.object){}
}

class FistanLoginErrorState extends FistanState{}

class FistanRegisterProgressState extends FistanState{}

class FistanRegisterSuccessState extends FistanState{
  late LoginModel object;
  FistanRegisterSuccessState(this.object){}
}

class FistanRegisterErrorState extends FistanState{}

