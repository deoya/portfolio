window.onload = function(){ // 그냥 "boardtext" 만 했다면 에디터가표시 되는데 , {} 에서 안에 뭘쓰면 에디터 css 수정
	var ck = CKEDITOR.replace("incontent",{
		height:290,
		width: 770
	});
}


var html = new Vue({
	el: "#main",
	data : {
		
	},
	methods:{
		noticego:function(){
			
			var ck = CKEDITOR.instances.incontent.getData();
			
			if(f.ntitle.value == "" || ck == ""){
				alert("빈칸을 모두 채우세요")
			}
			else{
				if(confirm('글 작성을 완료 하시겠습니까?')){
					f.action= "./admin_notice_writeok.do"
					f.method="POST"
					f.enctype="multipart/form-data"
					f.submit();
				}
			}
			
			
			
			
			
		}
		
	}
	
	
	
})