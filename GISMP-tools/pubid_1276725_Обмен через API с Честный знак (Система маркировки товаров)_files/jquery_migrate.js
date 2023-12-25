Cookies.defaults.secure = true;
let arrLocation = window.location.host.split('.').reverse();
if(arrLocation[0] === "ru" && arrLocation[1] === "infostart") {
    if(arrLocation[2] === "beta") {
        Cookies.defaults.domain = ".beta.infostart.ru";
    } else {
        Cookies.defaults.domain = ".infostart.ru";
    }
}
$(function () {
    $.cookie = function (key, value, options) {
        if(value === undefined && options === undefined) {
            return Cookies.get(key);
        }else{
            return Cookies.set(key, value, options);
        }
    };
    $.removeCookie = function (key, options) {
        return Cookies.remove(key, options);
    };
});

let rxhtmlTag = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([a-z][^\/\0>\x20\t\r\n\f]*)[^>]*)\/>/gi;
jQuery.htmlPrefilter = function( html ) {
    let res = html.replace( rxhtmlTag, "<$1></$2>" );
    if(html !== res) {
        let xhr = new XMLHttpRequest();
        xhr.open('POST', '/bitrix/ajax/js_errors/catch.php?code=htmlPrefilter&data=' + encodeURIComponent(html.substring(0, 150)), true);
        xhr.send();
    }
    return res;
};