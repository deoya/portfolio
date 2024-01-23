var html = new Vue({
	el : "#main",
	data : {},
	methods:{
		info_save:function(){
			
			if(confirm("해당 내용을 저장하시겠습니까?")){
				f.action="./admin_siteinfo_save.do";
				f.method = "post";
				f.enctype="application/x-www-form-urlencoded";
				f.submit();
			}
		}
	}
})