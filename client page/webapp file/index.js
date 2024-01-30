var html = new Vue({
	el : '#vue',
	data: {
		menu:menu,
		seat:[],
		num1:0,
		num2:0,
		num3:0,
		a:1
	},
	
	methods:{
		ch:function(){
			if(f.ugostyle.value == "편도"){
				f.uend.readOnly = "true"
			}else {
				f.uend.readOnly = "false"				
			}
		},
		aa:function(){
			if(f.uend.readOnly == true){
				f.uend.value = f.ustart.value;
			}
		},
		
		
		
		start:function(){
			var end = document.getElementById("end")
			var list = '<option value="">도착지를 선택하세요</option>';
			
			if(f.start_point.value != ""){
				var ea = menu[f.start_point.value].length
				var w = 0;
				
				while(w < ea){
					list+= `<option>${menu[f.start_point.value][w]}</option>`
					w++;	
				}
			
			}
			else {
				
			}
			end.innerHTML = list;
			
			
			
		},
		end:function(){
				fetch("./index_seat_ch.do?start_point="+f.start_point.value+"&end_point="+f.end_point.value).then(function(data){
					return data.json()
				}).then(function(data){
					html.seat_from(data)
				}).catch(function(error){
					console.log("ajax통신 오류",error)
				})
			
		},
		seat_from:function(data){
			console.log(f.start_point.value)
			console.log(f.end_point.value)
			
			this.seat = data;
		
		},
		insert:function(){
			f.ucount.value = this.a
			if(f.start_point.value == ""||f.end_point.value == ""||f.ustart.value == ""||f.uend.value == ""||f.seat_form.value == ""||f.ucount.value == ""||f.uname.value == ""||f.utel.value == ""){
				alert("프로모션 외에 빈칸을 채워주세요")
			}
			else if(confirm('예약을 완료 하시겠습니까?')){
				f.action="./reserveok.do"
				f.method="post"
				f.enctype="application/x-www-form-urlencoded"
				f.submit();
			}
		}
		
		
	},
	computed:{
		ea:function(){
			this.a = Number(this.num1)+Number(this.num2)+Number(this.num3)
		}
		
	}
})