$(document).ready(function () {
    $(".in_banner").each(function () {

        var $interval = 2000,
            $delaytext = 300,
            $sep = " ",
            $intervalN = 100;

        var obj = this;
        obj.step = 0;
        obj.now = 0;
        obj.source = $(this).find(".in_banner_text");
        obj.soursewrap = $(this).find(".in_banner_text_wrap");
        obj.sourceimg = $(this).find(".in_banner_image_text");

        var banner_play = function () {

            switch (obj.step) {
                case 0:
                case 4:
                    obj.step = 5;
                    setTimeout(function () {
                        obj.step = 1;
                    }, $interval);
                    break;
                case 1:
                    obj.step = 2;
                    obj.source.html('');
                    obj.sourceimg.attr("style", "");
                    obj.soursewrap.css("display", "block");
                    showtext();
                    break;
                case 2:
                    break;
                case 3:
                    obj.step = 4;
                    obj.source.html("");
                    obj.soursewrap.css("display", "none");
                    obj.sourceimg.attr("style", obj.css);
                    break;
            }
        };
        var showtext = function () {

            if (obj.step == 2) {
                obj.source.append(obj.words[obj.now] + $sep);
                obj.now++;
                obj.height = parseInt(obj.source.height(), 10);
                if (obj.height <= 170) {
                    obj.source.css("bottom", "-" + (obj.height / 2) + "px");
                }
                if (obj.now < obj.words.length) {
                    setTimeout(showtext, $delaytext);
                } else {
                    setTimeout(function () {
                        obj.now = 0;
                        obj.step = 3;
                    }, $interval);
                }
            }
        };

        if (obj.source.html() != null) {
            obj.words = obj.source.html().split($sep);
            obj.css = obj.sourceimg.attr("style");
            if (obj.words.length > 1) {
                setInterval(banner_play, $intervalN);
            }
        }
    });

});
