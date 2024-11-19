import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/local/local_story_model.dart';
import 'package:grimoire/main_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalBooksController extends MainController {
static final storyBox = Hive.box("stories");

  addToStories( LocalStoryModel v)async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> stories = pref.getStringList("stories")??[];
    stories.add(v.id);
    await pref.setStringList("stories", stories);

    await storyBox.put(v.id,v).whenComplete((){
      showToast("Downloaded");
    });
  }

  removeFromStories(storyId)async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> stories = pref.getStringList("stories")??[];
    stories.remove(storyId);
    await pref.setStringList("stories", stories);

    await storyBox.delete(storyId).whenComplete((){showToast("Deleted");});


  }

Future<List<Future<LocalStoryModel>>?>  fetchStories()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> storiesId = pref.getStringList("stories")??[];

    if(storiesId.isEmpty)return null;

    var localStories =storiesId.map((v)async{
      var ref = await storyBox.get(v);
      LocalStoryModel localStory = ref;
      print(localStory.title);
      return localStory;
    }).toList();

    return localStories;
  }

Stream<bool> isStoryDownloaded(storyId)async*{
    bool isDownloaded = storyBox.containsKey(storyId);
    yield isDownloaded;
}

}

  initializeLocalBooksStorage()async{
    await Hive.initFlutter();
    Hive.registerAdapter(LocalStoryModelAdapter());
    await Hive.openBox('stories');
  }