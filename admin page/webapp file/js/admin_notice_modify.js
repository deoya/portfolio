window.onload = function(){ // 그냥 "boardtext" 만 했다면 에디터가표시 되는데 , {} 에서 안에 뭘쓰면 에디터 css 수정
	var ck = CKEDITOR.replace("incontent",{
		height:290,
		width: 770
	});
}



var html = new Vue({
	el : "#sec",
	data:{},
	methods:{
		go_update:function(){
			if(confirm('수정을 완료 하시겠습니까?')){
				var ck = CKEDITOR.instances.incontent.getData();
				
				f.action="./admin_notice_modifyok.do"
				f.method="POST"
				f.enctype="multipart/form-data"
				f.submit();
			}
		}
	}
})

