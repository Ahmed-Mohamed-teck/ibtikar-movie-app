import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget? child;
  final Function(T)? initState;
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  const BaseWidget(
      {Key? key,
      required this.model,
      required this.builder,
      this.initState,
      this.child})
      : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  // We want to store the instance of the model in the state
  // that way it stays constant through rebuilds
  late T model;

  @override
  void initState() {
    // assign the model once when state is initialised
    model = widget.model;
    if (widget.initState != null) {
      widget.initState!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
