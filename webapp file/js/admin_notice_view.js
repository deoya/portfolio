
var html = new Vue({
	el : "#sec",
	data:{

	},
	methods:{
		go_delete:function(nidx,file){
			
			if(confirm('게시글을 삭제하시겠습니까?\n※삭제한 글은 복구되지 않습니다')){
				location.href="./admin_notice_delete.do?nidx="+nidx+"&xfile="+file;
			}
		}
	}
})