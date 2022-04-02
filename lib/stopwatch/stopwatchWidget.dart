import 'dart:async';

import 'package:flutter/material.dart';

class stopWatch extends StatefulWidget {
  const stopWatch({Key? key}) : super(key: key);

  @override
  _stopWatchState createState() => _stopWatchState();
}

class _stopWatchState extends State<stopWatch> {

  int sec=0,min=0,hours=0;
  String digitSec="00",digitMin="00",digitHours="00";
  Timer? timer;
  bool isStarted=false;
  List laps=[];

  void stop(){
    timer!.cancel();
    setState(() {
      isStarted=false;
    });
  }

  void reset(){
    timer!.cancel();
    setState(() {
      sec=0;
      min=0;
      hours=0;
      digitHours="00";
      digitMin="00";
      digitSec="00";
      laps.clear();
      isStarted=false;
    });
  }

  void addlaps(){
    String lap="$digitHours:$digitMin:$digitSec";
    setState(() {
      laps.add(lap);
    });
  }

  void start(){
    isStarted=true;
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      int LocalSec=sec+1;
      int LocalMin=min;
      int LocalHour=hours;

      if(LocalSec > 59) {
        if (LocalMin > 59) {
          LocalHour += 1;
          LocalMin = 0;
        } else {
          LocalMin += 1;
          LocalSec = 0;
        }

        print(LocalSec);
      }
      setState(() {
        sec = LocalSec;
        min = LocalMin;
        hours = LocalHour;

        digitSec = (sec >= 10) ? "$sec" : "0$sec";
        digitMin = (min >= 10) ? "$min" : "0$min";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child:Text(
                  "STOPWATCH APP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                  child:Text(
                    "$digitHours:$digitMin:$digitSec",
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 82.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF323f68),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                    itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap no ${index+1}",
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                    }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: (){
                        (!isStarted)?start():stop();
                      },
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue)
                        ),
                      child:Text(
                        isStarted ? "Pause":"Start",
                        style:const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),

                  IconButton(
                      onPressed: (){
                        addlaps();
                      },
                    color: Colors.white ,
                      icon: const Icon(Icons.flag),
                  )
                  ,
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                        onPressed: (){
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: const StadiumBorder(),
                        child:const Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
