var parm = window.location.search;
var pg = parm.replace("?page=","");

var html = new Vue({
	el : "#sec",
	data : {
		all:false,
		a:[],
		ck:document.getElementsByName("del_ck"),
		result:[],
	},
	methods:{
		go_view:function(data,idx){
			location.href="./admin_notice_view.do?nidx="+data+"&idx="+idx;
		},
		alldata:function(){
			if(this.all == true) {
				
				for (var i = 0; i < this.ck.length; i++) {
		            this.ck[i].checked = true;
					this.a.push(this.ck[i].value)
		        }
			}
			else if(this.all == false) {
				this.a = []
			}
			
		},
		onedata:function(){
		
			if(this.all == true){
				this.all = false
			}
			else if(this.a.length == this.ck.length){
				this.all = true
			}
		},
		delete_list:function(){
			if(confirm('해당 게시글들을 삭제 하시겠습니까?')){
				location.href="./admin_notice_deleteAll.do?nidx="+this.a;
			}
		},
		right:function(ea){
			
			if(pg == ""){
				pg = 1
			}
			if(pg < ea){
				pg = Number(pg)+1
				location.href='./admin_notice.do?page='+pg			
			}
		},
		left:function(){
			if(pg > 2){
				pg =	Number(pg)-1
				location.href='./admin_notice.do?page='+pg
			}else if(pg == 2) {
				location.href='./admin_product.do'
			}
		},
		rright:function(ea){
			pg =	ea
			location.href='./admin_notice.do?page='+pg
		},
		lleft:function(){
			location.href='./admin_notice.do'
		}
	}
})