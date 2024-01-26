
var footer = new Vue({
	el :"#footer_vue",
	data : {
		hcompany:"",
		hcompany_num:"",
		hceo:"",
		hceo_hp:"",
		hreport_num:"",
		hpost_code:"",
		haddr:"",
		hinfo_officer:"",
		hinfo_email:"",
		hprovide_num:""
	},
	methods:{
		
		ft:function(data){
			if(data[0] != undefined){ // 모든 데이터가 없을 시 전체가 출력되지 않기 위한 기준점
				this.hcompany = data[0]
			}
			this.hcompany_num = data[1]
			this.hceo = data[2]
			this.hceo_hp = data[3]
			this.hreport_num = data[4]
			this.hpost_code = data[5]
			this.haddr = data[6]
			this.hinfo_officer = data[7]
			this.hinfo_email = data[8]
			if(data[9] != undefined){ // 필수값이 아닌 데이터
				this.hprovide_num = data[9]				
			}
		}
	},
	computed:{
		footer:function(){
			fetch('./api_footer.do').then(function(data){
					return data.json();
				}).then(function(data){
					footer.ft(data)
				}).catch(function(error){
					console.log("ajax 통신 오류",error)
				})
		}
		
		
	}
})
	