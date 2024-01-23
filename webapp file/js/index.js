var html = new Vue({
	el : "#admin_bgcolor",
	data : {
		
	},
	methods: {
		newjoin:function(){
			location.href='./add_master.jsp';
		},
		login:function(){
			f.method = "POST"
			f.enctype="application/x-www-form-urlencoded"
			f.action="./loginck.do"
		}
	}
	



})