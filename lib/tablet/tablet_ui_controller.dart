import 'package:grimoire/main_controller.dart';

class TabletUIController extends MainController{
   TabletUIController();

   int _mainSelectedIndex = 0;
   int _secondSelectedIndex =0;

   int get  mainSelectedIndex => _mainSelectedIndex;
   int get  secondSelectedIndex => _secondSelectedIndex;

   set mainSelectedIndex(v){_mainSelectedIndex = v;notifyListeners();}
   set secondSelectedIndex(v){_secondSelectedIndex = v;notifyListeners();}


}