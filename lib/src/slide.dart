class Slide {
    Function() onLoad;

    Slide(this.onLoad);
}

class SlideManager {
    List<Slide> slides = [];
    int _counter = 1;

    int get counter => _counter;

    void operator +(int? n) {
        _counter += n ?? 1;
        if (_counter > slides.length - 1) {
            _counter = slides.length - 1;
        }
        onLoad();
    }

    void addSlide(Slide newSlide) {
        slides.insert(slides.length, newSlide);
    }

    void addSlides(List<Slide> newSlides) {
        for (var slide in newSlides) {
            slides.insert(slides.length, slide);
        }
    }

    void onLoad() async {
        slides[_counter > slides.length - 1 ? slides.length - 1 : _counter].onLoad();
    }
}
var slideman = SlideManager();
