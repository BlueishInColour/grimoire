import 'package:flutter/material.dart';

import '../../constant/CONSTANT.dart';
import '../../repository/follow_repository.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key,required this.emailAddress,this.size =10});
final String emailAddress;
final double size;
  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: FollowRepository().isFollowing(widget.emailAddress),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data ==true){
            return  GestureDetector(
                onTap: (){
                  FollowRepository().unFollowWriter(widget.emailAddress);
                },
                child: Icon(Icons.done,size:  widget.size,color: colorBlue,)
            );
          }
          else   return GestureDetector(
            onTap: (){
              FollowRepository().followWriter(widget.emailAddress);


            },
            child: Icon(Icons.person_add_alt_1_outlined,size: widget.size,color: colorBlue,),
          );
        }
    );
  }
}
