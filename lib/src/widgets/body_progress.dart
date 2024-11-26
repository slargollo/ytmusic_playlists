import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';

class BodyProgress extends StatelessWidget {
  final Widget child;
  final ConnectionState state;

  const BodyProgress({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return state != ConnectionState.waiting
        ? child
        : Stack(
            children: <Widget>[
              child,
              const BodyProgressPopup(),
            ],
          );
  }
}

class BodyProgressPopup extends StatelessWidget {
  const BodyProgressPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: const BoxDecoration(
        color: Colors.white70,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: 300.0,
        height: 200.0,
        alignment: AlignmentDirectional.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 7.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  local(context).processingMessage,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
