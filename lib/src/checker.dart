import 'package:flutter/material.dart';

import '../api/api.dart';

class PageSuccess extends StatelessWidget {
  const PageSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'SUCCESS',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class PageLoading extends StatelessWidget {
  const PageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class PageError extends StatelessWidget {
  const PageError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          'Wrong Key try to follow documents',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class AzulEnvatoChecker extends StatefulWidget {
  const AzulEnvatoChecker({
    Key? key,
    this.successPage = const PageSuccess(),
    this.errorPage = const PageError(),
    this.loadingPage = const PageLoading(),
    required this.uniqueKey,
  }) : super(key: key);
  final Widget successPage, errorPage, loadingPage;

  final String uniqueKey;

  @override
  State<AzulEnvatoChecker> createState() => _AzulEnvatoCheckerState();
}

class _AzulEnvatoCheckerState extends State<AzulEnvatoChecker> {
  final AzulApi azulApi = AzulApi();

  late Future<bool> _checker;

  @override
  void initState() {
    _checker = azulApi.checkApp(uniqueKey: widget.uniqueKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _checker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return widget.loadingPage;
          } else if (snapshot.hasError || !snapshot.hasData) {
            return widget.errorPage;
          }
          if (snapshot.data == true) {
            return widget.successPage;
          }
          return widget.errorPage;
        });
  }
}
