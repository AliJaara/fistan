import '../../model/login_model.dart';
import '../../modules/fistan_book/fistan_book_screen.dart';

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

class FistanLogoutState extends FistanState{}

class FistanChangeScreenState extends FistanState{}

class FistanChangeScreenToBookScreen extends FistanState{}


class FistanChangeFavoriteIcon extends FistanState{}

class FistanChangeImageFromGallery extends FistanState{}

class FistanChangeImageFromCamera extends FistanState{}

class FistanIncremant extends FistanState{}

class FistanMinimize extends FistanState{}



