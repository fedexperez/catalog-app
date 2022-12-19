import 'package:flutter/material.dart';

import 'package:forms/themes/themes.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.bodyChild});

  final Widget bodyChild;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.grey.shade300,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [_UpperBox(size: size), const _HeaderIcon(), bodyChild],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Icon(
          Icons.person_pin,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _UpperBox extends StatelessWidget {
  const _UpperBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      decoration: _upperBoxDecoration(),
      child: Stack(
        children: const [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: 210, right: -20, child: _Bubble()),
          Positioned(top: 180, left: 150, child: _Bubble()),
          Positioned(top: 10, right: 20, child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _upperBoxDecoration() {
    return BoxDecoration(
        gradient:
            LinearGradient(colors: [AppTheme.primary, Colors.red.shade300]));
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
