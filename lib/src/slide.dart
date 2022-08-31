import 'package:flutter/widgets.dart';

abstract class Slide {
    bool render(Canvas canvas);
}

class NormalSlide implements Slide {
    List<List<String>> text;
    String currentText = "";

    NormalSlide(this.text);

    bool render(Canvas canvas) {
        return true;
    }
}
