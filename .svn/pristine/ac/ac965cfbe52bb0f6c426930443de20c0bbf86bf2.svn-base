// JScript 文件
// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
/*
    记录每次页面跳转以后的页面地址和标题后写入COOKIE
*/
var art_title =  document.title; //文章标题 
var art_url = document.URL; //页面地址 
var art_time =new Date().Format("yyyy-MM-dd hh:mm:ss");//访问时间


var canAdd = true; //初始可以插入cookie信息 
var hisArt = $.cookie("lsjl"); 
var len = 0; 
if(hisArt){ 
    hisArt = eval("("+hisArt+")"); 
    len = hisArt.length; 

} 
 //alert(hisArt)
 /*
if(len!=0){
    $(hisArt).each(function(){ 
        //alert(this.title + "++++++" + art_title)
        if(this.title == art_title){ 
            canAdd = false; //已经存在，不能插入 
            return false; 
        } 
    }); 
}
*/
//alert(canAdd)
if(canAdd==true){ 

    var json = "["; 
    var start = 0; 
    if(len>7){start = 1;} 
    for(var i=start;i<len;i++){ 
        if (art_title!= hisArt[i].title)
        {
            json =  json + "{\"title\":\""+hisArt[i].title+"\",\"url\":\""+hisArt[i].url+"\",\"newtime\":\""+hisArt[i].newtime+"\"}," ; 
        }
    } 
    json =  json + "{\"title\":\""+art_title+"\",\"url\":\""+art_url+"\",\"newtime\":\""+art_time+"\"}]"  ; 
    $.cookie("lsjl",json,{expires:30,path:'/'}); 
    //alert(canAdd)
} 