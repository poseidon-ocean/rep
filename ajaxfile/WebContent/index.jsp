<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>Ajax实现多文件上传</title>
	<meta name="keywords" content=""/>
	<meta name="description" content=""/>
	
	<style type="text/css">
		*{margin:0;padding:0;}
		body{font-size:16px;font-family:"微软雅黑";color:#666;
			background:#8E8EA7;
		}
		#box{width:960px;height:600px;background:#fff;margin:30px auto;box-shadow:2px 2px 5px #000;}
		#box h1{padding:5px;background:#111;color:#fff;margin-bottom:20px;}
		#box .btn{background-color: #2d2727;text-decoration: none;color: #fff;padding: 5px;
			box-shadow: 2px 2px 5px #000;margin-left: 10px;}
		ul,li{list-style:none;}
		#imgbox li{width:120px;height:160px;margin-left:20px;margin-top:30px;float:left;transition:all 2s ease;}
		#imgbox li:hover{
			transform:scale(1.2);
			border:2px solid gray;
			transition:all 2s ease;
		}
		#imgbox li img{width:120px;height:160px;}
		#imgbox li img:hover{
			transform:scale(1.2);
			border:2px solid gray;
			transition:all 2s ease;
		}
		.progress{width:95%;height:20px;border:1px solid #000;
			margin-top:20px;margin-left:10px;box-shadow:2px 2px 5px #000;
				border-radius:10px;
		}
		#percent{
			background:green;
			width:0%;border-radius:10px;
			text-align:right;
			height:20px;
		}
	</style>
</head>
<body>
	
	<div id="box">
		<h1>Ajax实现多文件上传</h1>
		<input type="file" style="display:none;" onchange="fileup();" id="fileup" multiple="multiple" accept="image/*"/>
		<a href="javascript:;" class="btn" onclick="openBrows();">上传图片</a>
		<div class="progress">
			<div id="percent"></div>
		</div>
		<ul id="imgbox"></ul>
	</div>
	
	
	<script type="text/javascript">
	
		function openBrows(){
			//拿到文件上传对象
			var fileDom = document.getElementById("fileup");
			//模拟用户点击click事件
			fileDom.click();
		}
		
		function fileup(){
			var fileobj = document.getElementById("fileup");
			//获取文件集合
			var files = fileobj.files;
			//创建formdata对象将文件增加到formdata中
			var form = new FormData();
			
			for(var i=0,len=files.length;i<len;i++){
				//添加参数到form表单文件中
				form.append("file"+i,files[i]);
			}
			
			//Ajax做文件上传
			var xhr = new XMLHttpRequest();//创建xmlhttp对象
			//打开一个URL地址
			xhr.open("post","fileUp.do",true);
			xhr.onreadystatechange = function(){
				if(xhr.readyState==4 &&xhr.status==200){
					var result = xhr.responseText.trim();
					eval(result);
					var imgbox = document.getElementById("imgbox");
					var html = "";
					for(var i=0,len=filePaths.length;i<len;i++){
						html += "<li><img src='"+filePaths[i]+"' /></li>";
					}
					imgbox.innerHTML = html;
				}
				
			}
			
			//获取进度
			xhr.upload.addEventListener("progress",function(event){
				var per = document.getElementById("percent");
				if(event.lengthComputable){//文件上传的长度 
					var percent = Math.round(event.loaded/event.total*100) + "%";
					per["style"]["width"] = percent;
				}
			},false);
			
			xhr.send(form);
		}
	</script>
</body>
</html>