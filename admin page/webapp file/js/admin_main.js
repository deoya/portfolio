var html = new Vue({
	el :"#main",
	data : {
		arr:[],
		ea : "",
		n:0,
	},
	methods:{
		datas:function(data){
			this.ea = data["admin"].length
			while(this.n < this.ea) {
				this.arr.push({
					aidx:data['admin'][this.n]['aidx'],
					aid:data["admin"][this.n]['aid'],
					apass:data["admin"][this.n]['apass'],
					aname:data["admin"][this.n]['aname'],
					aemail:data["admin"][this.n]['aemail'],
					atel:data["admin"][this.n]['atel'],
					adiv:data["admin"][this.n]['adiv'],
					aposition:data["admin"][this.n]['aposition'],
					adate:data["admin"][this.n]['adate'],
					approval:data["admin"][this.n]['approval'],
				})
				this.n++;	
			}
		},
		inok:function(a){
			if(confirm('승인처리 하시겠습니까?')){
				location.href="./inok.do?aidx="+a;
			}
		},
		inblock:function(a){
			if(confirm('미승인처리 하시겠습니까?')){
				location.href="./inblock.do?aidx="+a;
			}
		}
		
	},
	computed:{
	ajax:function(){
		fetch("./api_json.do").then(function(aa){
			return aa.json();
		}).then(function(bb){
			html.datas(bb);
		}).catch(function(error){
			console.log("api 서버 접속 오류"+error)
		})
		
	}
}
})