import 'package:comunidade_de_engenheiros_de_software/util/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingControl {
  final CallbackClosable _closable = CallbackClosable();

  bool isShowing = false;

  Widget create() {
    isShowing = true;
    return WillPopScope(child: LoadingWidget(callbackClosable: _closable), onWillPop: () async => false);
  }

  void close() {
    isShowing = false;
    _closable.close();
  }
}

class CallbackClosable {
  VoidCallback? _callback;

  void close() {
    _callback?.call();
  }

  void addListener(VoidCallback callback) {
    _callback = callback;
  }
}

class LoadingWidget extends StatefulWidget {
  final CallbackClosable callbackClosable;

  const LoadingWidget({Key? key, required this.callbackClosable}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  void initState() {
    widget.callbackClosable.addListener(() {
      try {
        Navigator.pop(context);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor.withAlpha(127),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColor.secondColor,
        ),
      ),
    );
  }

  void close() {
    Navigator.pop(context);
  }
}
