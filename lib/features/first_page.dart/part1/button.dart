import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../ar/views/ar_home.dart';
import '../../constilation/views/constilation_home_widget.dart';

class ButtonColumn extends StatelessWidget {
  const ButtonColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TweenAnimationBuilder(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, double value, _) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: Container(
                      width: 225,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 11.0),
                        child: Text(
                          "More info",
                          style: GoogleFonts.oxygen(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    // child: const SizedBox(),
                    child: const ArHome(),
                  ));

            },
            child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutCirc,
                tween: Tween<double>(begin: 0.0, end: 1.0),
                builder: (context, double value, _) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 40 * (1 - value)),
                      child: Container(
                        width: 225,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          child: Text(
                            "Show In Camera",
                            style: GoogleFonts.oxygen(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    // child: const SizedBox(),
                    child: const ConstilationHomeWidget(),
                  ));

            },
            child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOutCirc,
                tween: Tween<double>(begin: 0.0, end: 1.0),
                builder: (context, double value, _) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 40 * (1 - value)),
                      child: Container(
                        width: 225,
                        margin: const EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          child: Text(
                            "Show Constilation",
                            style: GoogleFonts.oxygen(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
