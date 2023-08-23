import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_controller/torch_controller.dart';

class TorchLight extends StatefulWidget {
  const TorchLight({super.key});

  @override
  State<TorchLight> createState() => _TorchLightState();
}

class _TorchLightState extends State<TorchLight> with WidgetsBindingObserver {
  var isOn = false;
  var controller = TorchController();
//  app life cycle

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      if (isOn == true) {
        controller.toggle();
        isOn = !isOn;
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "FlashLight",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: size.height * 0.15,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    isOn ? 'assets/on.png' : 'assets/of.png',
                    height: 250,
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  CircleAvatar(
                    minRadius: 20,
                    maxRadius: 40,
                    child: Transform.scale(
                      scale: 2,
                      child: IconButton(
                        onPressed: () {
                          try {
                            controller.toggle();
                            isOn = !isOn;
                            setState(() {});
                          } on Exception catch (_) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text("FlashLight cannot be found"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                        SystemNavigator.pop();
                                      },
                                      child: const Text("ok"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        icon: const Icon(Icons.power_settings_new),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
