<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CDN 서버에 파일 업로드 기능</title>
</head>
<body>
	<form id="f" method="post" action="./cdn_flieok.do" enctype="multipart/form-data">
	파일 업로드 : <input type="file" name="mfile" >
	<input type="button" value="전송" onclick="cdn_file()">
</form>
</body>
<script>
	function cdn_file(){
		var fsize = f.mfile.files[0].size;
		/*
		.files[0].size : 첨부파일이 1개 일때
		만약에 동일한 name일 경우 f.mfile[0].files[0], f.mfile[1].....
		mutiple일 경우 f.mfile.files[0], f.mfile.files[1]......
		*/
		if(fsize > 2197152){ // 비트가 아니고 바이트 단위
			alert("첨부파일 용량은 최대 2MB까지 업로드 가능합니다")	
		}
		else {
			f.submit();	
		}
		
	}
</script>
</html>