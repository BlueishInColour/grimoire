import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:grimoire/commons/views/clover-mark-5-svgrepo-com.dart' as SVGator show Clovermark5svgrepocom, Clovermark5svgrepocomState;
import 'package:path/path.dart';
import '../../constant/CONSTANT.dart';
import 'clover-mark-5-svgrepo-com.dart';

Widget loadWidget({Color color =Colors.black,double size = 30}){
  return Center(
    child: SizedBox.square(
    dimension: size,
      child:CircularProgressIndicator(color:color)//:LoadWidget(size:size),
    ),
  );
}

Widget emptyWidget(){
  return Center(child: Image.asset("assets/empty.png"));
}



class LoadWidget extends StatelessWidget {
  LoadWidget({required this.size});
  GlobalKey<SVGator.Clovermark5svgrepocomState>? _SVGatorPlayer = GlobalKey<SVGator.Clovermark5svgrepocomState>();
final double size;
  void _eventListener([String? message]) {
    print("Message received: $message");
  }

  void _runCommand(String command, int? param,BuildContext context) {
    _SVGatorPlayer?.currentState?.build(context);//currentState. runCommand(command, param);
  }

  @override
  Widget build(BuildContext context) {
    return
              Center(
                child: SVGator.Clovermark5svgrepocom(
                  height: 100,
                  key: _SVGatorPlayer,
                  // onMessage: _eventListener,
                ),
    );
  }
}