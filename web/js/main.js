
//图像预览
function previewImage(file)
{
    var MAXSIZE = 1048576;
    var MAXWIDTH  = 200;
    var MAXHEIGHT = 200;
    if (file.files && file.files[0])
    {
        var img = document.getElementById('preview');
        
        img.onload = function(){
            
            var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
            img.width  =  rect.width;
            img.height =  rect.height;
            img.style.marginLeft = rect.left+'px';
           // img.style.marginTop = rect.top+'px';
        }
        var reader = new FileReader();
        reader.onload = function(evt){
            imagetemp.src = evt.target.result;
            var size = imagetemp.width/imagetemp.height;
            if(size > 1.414||size < 0.707){
                //尺寸不符合的处理
                alert("图像太长/太宽，请重新选择！");
                file.files[0]=null;
                return;
            }
            if(file.files[0].size > MAXSIZE){
                //文件过大的处理
                alert("文件太大，请重新选择！");
                file.files[0]=null;
                return;
            }
            img.src = evt.target.result;
        }
        var imagetemp=new Image();
        
        reader.readAsDataURL(file.files[0]);
    }
    else //兼容IE
    {
        var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
        file.select();
        var src = document.selection.createRange().text;
        var img = document.getElementById('preview');
        img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight )
    {
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;

        if( rateWidth > rateHeight )
        {
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else
        {
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }

    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}
////ajax上传头像
$(function(){
    document.getElementById("submit").onclick=function(){
        //document.getElementById("submit").setAttribute("value","上传中");
       // window.alert("haha");
       // window.alert(document.getElementById("file").value);
        if(document.getElementById("file").value==""){
            window.alert("请点击要上传的图片");
            return false;
        }
        //$.post("/servlet/HeadServlet", {
        //    filename: $("#file").val()
        //    },function(data,textStatus){
        //        alert("上传成功！");
        //    });
        }


});