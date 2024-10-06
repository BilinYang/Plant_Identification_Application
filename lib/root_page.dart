import 'package:flutter/material.dart';
import 'const.dart';
import 'discover_cell.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // int _currentIndex = 0;
  // List <Widget> _pages = [Games1Page(), Games1Page(),IdentPage1(), IdentPage2()];
  // final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: WeChatThemeColor,
          title: Text('BPT Gamer'),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          //color: WeChatThemeColor,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/backgd.png'),
              fit: BoxFit.cover,
            ),
          ),
          //alignment: Alignment(-1.0,0.0),
          //color: Colors.red,
          child: ListView(
           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment(-0.6,0.0),
              child: const Text(
                  'GAMES',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),

                ),
              ),
            Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [


                        DiscoverCell(
                          imageName: 'images/hangman.png',
                          title: 'HangMan',
                          index: 0,
                        ),
                        DiscoverCell(
                          imageName: 'images/flip.png',
                          title: 'Flip',
                          index: 1,

                        ),
                      ],
                      ),
                    ),

            SizedBox(
                height: 10,
              ),

            Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        DiscoverCell(
                          imageName: 'images/flip.png',
                          title: 'Flip',
                          index: 1,

                        ),
                        DiscoverCell(
                          imageName: 'images/flip.png',
                          title: 'Flip',
                          index: 1,

                        ),
                      ],
                    ),
              ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment(-0.6,0.0),
              child: const Text(
                'AI IDENTIFICATION',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),

              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  DiscoverCell(
                    imageName: 'images/plants.png',
                    title: 'AI plant',
                    index: 2,
                  ),
                  DiscoverCell(
                    imageName: 'images/plants.png',
                    title: 'AI plant',
                    index: 2,
                  ),
                ],
              ),
            ),

            // Row(
            //   children: [
            //     Container(
            //       width: 50,
            //       height: 5,
            //       color: Colors.white,
            //     ),
            //     Container(
            //       height: 5,
            //       width: 100,
            //       color: Colors.cyan,
            //     ),
            //   ],
            // )
              ],
            ),
        ),
      );
              // Container(
              //   margin: EdgeInsets.only(top: 40, right: 10),
              //   height: 25,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Image(image: AssetImage('images/camera.png')),
              //   ),
              // ),
  }
}
