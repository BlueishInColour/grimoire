import 'package:flutter/material.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/models/scheduled_model.dart';
import 'package:grimoire/models/story_model.dart';

import '../../constant/CONSTANT.dart';
import '../../publish/coming_soon_screen.dart';
import '../../repository/calender_repository.dart';
import '../../repository/follow_repository.dart';

class CalenderButton extends StatefulWidget {
  const CalenderButton({super.key,required this.book,
    this.storyModel,
    this.isStory = false,
    required this.endDate, required this.startDate,required this.scheduledModel});
  final BookModel book;
  final DateTime startDate;
  final DateTime endDate;
  final StoryModel? storyModel;
  final bool isStory;
  final ScheduledModel scheduledModel;
  @override
  State<CalenderButton> createState() => _CalenderButtonState();
}

class _CalenderButtonState extends State<CalenderButton> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<bool>(
        stream: CalenderBookRepository().isCalenderMarked(widget.book.bookId),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null && snapshot.data != false){
            return IconButton(onPressed: ()async {
              await  CalenderBookRepository().removeFromCalender(widget.book.bookId);
            },
                icon: Icon(Icons.alarm_on_rounded, color: colorBlue,));
          }
          else{
            return IconButton(onPressed: () async{
              await addToCalenderEvent(
                  book:widget. book,
                  story: widget.storyModel,
                  isStory: widget.isStory,
                  startDate:widget. scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                  endDate:widget.scheduledModel.releasedOn!.add(Duration(days: 1)) );
            },
                icon: Icon(Icons.alarm_add, color: colorBlue,));
          }
        }
    );
  }
}

