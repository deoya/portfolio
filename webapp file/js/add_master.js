var html = new Vue({
	el : "#admin_bgcolor_add",
	data : {
		tel2:"",
		tel3:"",
		pwdck:"",
		rd : false,
		idcout:0 // 아이디 중복확인 유무 
		

	},
	methods: {
		join:function(){
			var email_r =  /[0-9a-z]+\@[0-9a-z]+\.[a-z]+/i;
		
			if (f.aid.value == "" || f.apass.value == "" || f.aname.value == "" ||f.aemail.vaule == "" || f.adiv.value == "x" || f.aposition.value == "x" || f.atel.value == "" || this.tel2 == "" ||this.tel3 == "" ){
				alert("빈칸을 모두 채워주셔야 합니다.");			
			}
			
			else if (this.idcount == 0) {
				alert("아이디 중복확인을 진행하여 주세요")
				f.aid.focus();
			}else if(f.apass.value != this.pwdck || f.apass.value.length < 5){
				alert("비밀번호를 다시 확인하여 주세요 (최소 5글자 이상이어야 합니다)");
				f.apass.focus();
			} else if(!email_r.test(f.aemail.value)){
				alert("이메일을 다시 확인하여 주세요");
				f.aemail.focus();
			} 
			else {
				f.atel.value += this.tel2
				f.atel.value += this.tel3
				
				f.method = "POST"
				f.enctype="application/x-www-form-urlencoded"
				f.action="./masterjoinok.do"
				f.submit();
			}
		
		
		},
		cancel:function(){
			location.href='./index.jsp';
		},
		idcheck:function(){
			fetch("./idcheck.do?aid="+f.aid.value).then(function(data){
					return data.text();
				}).then(function(data){
					console.log(data)
					html.idcheck2(data);
				}).catch(function(error){
					console.log("통신오류 발생!!")
				});
		},
		idcheck2:function(bb){
			if(bb == "1") {
				alert("해당 아이디는 사용하실 수 없습니다");
			}
			else {
				if ( f.aid.value == "" || f.aid.value.length < 5) {
					alert("아이디를 다시 확인하여 주세요(최소 5글자 이상이어야 합니다)")
					f.aid.focus();
				}else {
					alert("사용가능한 아이디 입니다");
					this.rd = true;
					this.idcout = 1;
				
				}
				
			}
		
		}
	}
	
})