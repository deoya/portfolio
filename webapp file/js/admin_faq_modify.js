window.onload = function(){ 
	var ck = CKEDITOR.replace("incontent",{
		height:390,
		width: 925
	});
}


var html = new Vue({
	el: "#vue",
	data : {
		
	},
	methods:{
		modifyok:function(){
			var ck = CKEDITOR.instances.incontent.getData();
			if(f.ftitle.value == "" || ck == ""){
				alert("빈칸을 모두 채우세요")
			}
			else{
				if(confirm('수정하시겠습니까?')){
					f.action= "./admin_faq_modifyok.do"
					f.method="POST"
					f.enctype="application/x-www-form-urlencoded"
					f.submit();
				}
			}
		}
	}
})