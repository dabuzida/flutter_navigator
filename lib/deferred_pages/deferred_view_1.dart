import 'package:flutter/material.dart';
import '../media_query/media_query_layout.dart';
import '../ui/ui_property.dart';

class DeferredView1 extends StatelessWidget {
  const DeferredView1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   child: Opacity(
        //     opacity: 0.15,
        //     child: Image(
        //       image: AssetImage('./images/login_bg.jpg'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        MediaQueryLayout(
          screenS: () {
            return textFontSet(fontSize: 18);
          },
          screenM: () {
            return ListView(
              children: [
                _buildUILongHeader(),
                textFontSet(fontSize: 36),
              ],
            );
          },
          screenL: () {
            return ListView(
              children: [
                _buildUILongHeader(),
                textFontSet(fontSize: 48),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildUILongHeader() {
    return MediaQueryLayout(
      screenS: () {
        return const Text('LongHeader in MediaQuery Small');
      },
      screenM: () {
        return SizedBox(
          height: 60,
          child: Row(
            children: const <Widget>[
              Expanded(
                flex: 10,
                child: Text('LongHeader Item 1 in MediaQuery Medium'),
              ),
              Expanded(
                flex: 10,
                child: Text('LongHeader Item 2 in MediaQuery Medium'),
              ),
            ],
          ),
        );
      },
      screenL: () {
        return SizedBox(
          height: 60,
          child: Row(
            children: const <Widget>[
              Expanded(
                flex: 20,
                child: Text('LongHeader Item 1 in MediaQuery Large'),
              ),
              Expanded(
                flex: 20,
                child: Text('LongHeader Item 2 in MediaQuery Large'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget textFontSet({double fontSize = 10.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL (unsetted)',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL (wrong font)',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'asdf',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL Malgun Gothic',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'Malgun Gothic',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL MalgunGothic',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'MalgunGothic',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL Pretendard',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'Pretendard',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL apple-system',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'apple-system',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL Helvetica Neue',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'Helvetica Neue',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL Georgia',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'Georgia',
          ),
        ),
        Text(
          '다람쥐 헌 쳇바퀴 123 hjklHJKL Nanum Gothic',
          style: TextStyle(
            fontSize: fontSize,
            // fontWeight: FontWeight.w900,
            fontFamily: 'Nanum Gothic',
          ),
        ),
      ],
    );
  }
}
