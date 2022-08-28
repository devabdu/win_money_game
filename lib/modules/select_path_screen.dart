import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/shared/components/components.dart';

import '../providers/users_provider.dart';

class SelectPathScreen extends StatefulWidget {
  const SelectPathScreen({Key? key}) : super(key: key);

  @override
  State<SelectPathScreen> createState() => _SelectPathScreenState();
}

class _SelectPathScreenState extends State<SelectPathScreen> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final provider = Provider.of<UsersProvider>(
        context, listen: false);

    provider.getMusicState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onTap: () {
                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Tasaly',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Play for fun',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                        backgroundColor: Colors.amberAccent,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectTasaly = true;
                                selectRebh = false;
                              });
                              Navigator.pop(context);
                              return navigateTo(context, const HomeLayoutScreen());
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );

                  },
                  splashColor: Colors.deepPurple,
                  child: Image.asset(
                    "assets/images/Tasaly.png",
                    width: double.infinity,
                    height: 300,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onTap: () {
                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Rebh',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          'Play to win money',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurple,
                          ),
                        ),
                        backgroundColor: Colors.amberAccent,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectRebh = true;
                                selectTasaly = false;
                              });
                              Navigator.pop(context);
                              return navigateTo(context, const HomeLayoutScreen());
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  splashColor: Colors.deepPurple,
                  child: Image.asset(
                    "assets/images/rebh.png",
                    width: double.infinity,
                    height: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground =  state == AppLifecycleState.paused;

    if(isBackground){
      setState(() {});
      stopMusic();
    }else{
      final provider = Provider.of<UsersProvider>(
          context, listen: false);
      provider.turnOnMusicAfterBackground();
      setState(() {});
    }
  }
}
