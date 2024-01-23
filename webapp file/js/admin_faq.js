
var parm = window.location.search;
var pg = parm.replace("?page=","");
var html = new Vue({
	el : "#vue",
	data : {
		sch : sch
	},
	methods:{
		go_modify:function(data){
			location.href="./admin_faq_modify.do?fidx="+data;
		},
		go_del:function(data){
			if(confirm('해당 FAQ를 삭제하시겠습니까?'))
			location.href="./admin_faq_deleteok.do?fidx="+data;
		},
		search:function(){
			f.action="./admin_faq.do"
			f.method="post"
			f.enctype="application/x-www-form-urlencoded"
		},
		right:function(ea){
		
			if(pg == ""){
				pg = 1
			}
			if(pg < ea){
				pg = Number(pg)+1
				location.href='./admin_faq.do?page='+pg
			}
		},
		left:function(){
			if(pg > 2){
				pg =	Number(pg)-1
				location.href='./admin_faq.do?page='+pg
			}else if(pg == 2) {
				location.href='./admin_faq.do'
			}
		},
		rright:function(ea){
			pg =	ea
			location.href='./admin_faq.do?page='+pg
		},
		lleft:function(){
			location.href='./admin_faq.do'
		}
	}
})