import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotable/view_model/bloc/quote_bloc.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    super.initState();
    _fetchRandom();
  }

  NetworkImage getImage() {
    return NetworkImage("https://picsum.photos/720/1280/?image=${_getRandomNum()}");
  }

  void _fetchRandom() {
    context.read<QuoteBloc>().add(GetRandom());
  }

  int _getRandomNum() {
    var rng = Random();
    for(var i = 0; i<100; i++) {
      return rng.nextInt(100);
    }
    return 101;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 100,
        controller: PageController(initialPage: 0,keepPage: true,viewportFraction: 1),
        onPageChanged: (index) {
          _fetchRandom();
        },
        itemBuilder:(BuildContext context, int index) {
          return methodBloc();
        }
      ),
    );
  }

  Widget buildMenu(state) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration:  BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.6),
                BlendMode.dstATop),
              image: getImage(),
              fit: BoxFit.cover
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.quote.content!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,height: 1.5,
                  color: Colors.black),),

          ],
        ),
      ),
    );
  }

  Widget methodBloc() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if(state is QuoteLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is QuoteError) {
              return Center(child: Text(state.message));
            }
            if(state is QuoteSuccess) {
              return buildMenu(state);
            }
            return Container();
          },
        ),
      ],
    );
  }
}
