<%@page import="java.util.Set"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="app" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	Date today = new Date();
	request.setAttribute("today", today);
	//ArrayList key = request.getAttribute("list").keySet();
	JSONObject data = (JSONObject)request.getAttribute("list");
    Set<String> menu = data.keySet();
    request.setAttribute("menu", menu);
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Air_K-Travel</title>
    <link rel="icon" type="image/png" sizes="32x32" href="./ico/favicon-32x32.png">
    <link rel="stylesheet" type="text/css" href="./css/main.css">
    <link rel="stylesheet" type="text/css" href="./css/main_page.css?v=1">
        <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
</head>
<body>
<div style="color:white;">
</div>
	<div id="vue">
	<form id="f">
    <header class="headercss">
        <nav class="navcss">
            <ol>
                <li>
                    <span class="logos">Air_K-Travel</span>
                </li>
                <li>항공예약</li>
                <li>이벤트</li>
                <li>서비스 안내</li>
                <li>공지사항</li>
                <li>고객센터</li>
                <li><img src="./image/menu.svg" class="menu_ico"></li>
            </ol>
        </nav>
    </header>
    <main>
        <section class="main_view">
        <aside class="titles">Air<em class="color1">_</em>K-Travel (항공편 조회)</aside>
        <section class="air_search">
            <div class="air_parts">
                <ul class="air_pt1">
                    <li><label class="rd"><input type="radio" name="ugostyle" value="왕복" class="radio_box" checked @change="ch"> 왕복</label></li>
                    <li><label class="rd"><input type="radio" name="ugostyle" value="편도" class="radio_box" @change="ch"> 편도</label></li>
                </ul>
                <ul class="air_pt2">
                    <li>
                    <span>출발지</span>
                    <span>
                        <select name="start_point" class="separts" @change="start">
                        		<option value="">출발지를 선택하세요</option>
                        	<app:forEach var="mn" items="${menu}">
                            	<option>${mn}</option>
                            </app:forEach>
                        </select>
                    </span>
                    </li>
                    <li><img src="./image/arrow.svg"></li>
                    <li>
                    <span>목적지</span>
                    <span>
                    
                        <select class="separts" name="end_point" id="end" @change = "end">
                            <option >도착지를 선택하세요</option>
                        </select>
                    </span>
                    </li>
                </ul>
                <ul class="air_pt2">
                    <li>
                    <span>가는날</span>
                    <span>
                        <input type="date" name="ustart" class="datecss" @change="aa">
                    </span>
                    </li>
                    <li><img src="./image/arrow.svg"></li>
                    <li>
                    <span>오는날</span>
                    <span>
                        <input type="date" name="uend" class="datecss">
                    </span>
                    </li>
                </ul>
                <ul class="air_pt2">
                    <li>
                    <span>좌석선택</span>
                    <span>
                        <select class="separts" name="seat_form">
                            <option>좌석을 선택하세요</option>
                            <option v-for="n in seat" :value="n">{{n}}</option>
                        </select>
                    </span>
                    </li>
                    <li></li>
                    <li>
                    <span>프로모션 코드</span>
                    <span>
                        <input type="text" name="promotion" class="datecss" placeholder="프로모션 코드가 있을 경우 입력하세요" maxlength="12">
                    </span>
                    </li>
                </ul>
                <div class="part_titles">인원 선택</div>
                <ul class="air_pt3">
                    <li>
                        성인 : <input type="text" v-model="num1" class="persons" maxlength="3">
                    </li>
                    <li>
                        소아 : <input type="text" v-model="num2" class="persons" maxlength="3">
                    </li>
                    <li>
                        유아 : <input type="text" v-model="num3" class="persons" maxlength="3">
                    </li>
                    <li>
                    	<input type="hidden" name="ucount">
                        총인원 : <em class="totals" >{{ea}}{{a}}</em>명
                    </li>
                </ul>
                <div class="part_titles">예약 자</div>
                <ul class="air_pt3">
                    <li>
                        예약자명 : <input type="text" name="uname" class="persons" style="width:inherit">
                    </li>
                    <li>
                        전화번호 : <input type="text" name="utel" class="persons" style="width:inherit">
                    </li>
                </ul>
                <button type="button" class="btn" style="margin-left:calc( 50% - 110px);" @click="insert">항공편 예매</button>
            </div>
        </section>
    </main>
    </form>
    </div>
</body>
<script>
var menu = <%=data%>;
</script>
<script src="./index.js?v=${today}"></script>
</html>