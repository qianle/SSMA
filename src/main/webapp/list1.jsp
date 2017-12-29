<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function sendAjax(url, methodType, param, retnFunction) {
		//无刷新调用http://localhost:8080/s/queryFood 获取到数据 数据通过dom方式添加到table中
		//ajax（异步的ajax）+json
		var xmlhttp = null;
		//兼容所有的游览器创建这个对象 XHR对象
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		//回调函数 当请求发送后 收到结果自动调用该方法
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				retnFunction(xmlhttp.responseText);
			}
		}
		if (methodType == "get" || methodType == "GET") {
			xmlhttp.open("GET", url + "?" + param, true);
			xmlhttp.send();
		} else {
			xmlhttp.open("POST", url, true);
			xmlhttp.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded;charset=UTF-8");
			xmlhttp.send(param);
		}

	}
	/*
		使用ajax
		尽量使用true 异步模式 （防假死）
		尽量将获取数据之后的逻辑处理（页面渲染） 放在回调函数之中
	 */
	function query() {
		/**
		readyState	
		存有 XMLHttpRequest 的状态。从 0 到 4 发生变化。
		0: 请求未初始化（没有调用send方法）
		1: 服务器连接已建立（socket已连接）
		2: 请求已接收（获取到参数 没有执行action 方法）
		3: 请求处理中（已经在执行action方法 未执行完）
		4: 请求已完成，且响应已就绪（已经响应 并且能获取到最终的数据）
		status	响应的状态
		200: "OK"
		404: 未找到页面
		 */
		var foodName = document.getElementsByName("foodName")[0].value;
		sendAjax("${pageContext.request.contextPath}/queryFoodList", "POST","foodname="+foodName, function(responseText){

					//返回的是字符串的json
					var resutJson = responseText;
					//转换为js对象
					var resultObj = JSON.parse(resutJson);
					//获取表格对象
					var table = document.getElementById("table");
					//将所有名字为dataTr的tr全部删除
					var dtr = document.getElementsByName("dataTr");
					var length = dtr.length;
					for ( var i = 0; i < length; i++) {
						table.removeChild(dtr[0]);
					}
					
					//根据json的行数追加多个str
					for ( var i = 0; i < resultObj.length; i++) {
						var obj = resultObj[i];
						var td = document.createElement("td");
						td.innerText = obj.foodname;
						var td1 = document.createElement("td");
						td1.innerText = obj.price;

						var td2 = document.createElement("td");
						
						var ib = document.createElement("button");
						ib.innerText = "x";
						var ib1 = document.createElement("button");
						ib1.innerText = "u";
						td2.appendChild(ib);
						td2.appendChild(ib1);
						var tr = document.createElement("tr");
						//将当前行的json对象绑定到当前按钮上
						ib.foodObj = obj;
						//将当前行的tr绑定到当前按钮上
						ib.myLinerTr = tr;
						//删除按钮事件
						ib.addEventListener("click", function() {
							var eventSrc = event.srcElement;
							//删除当前行 + 发送 ajax请求到后台 删除数据库
							table.removeChild(eventSrc.myLinerTr);
							sendAjax("${pageContext.request.contextPath}/food/"+eventSrc.foodObj.foodid, "POST","&_method=DELETE", function(responseText){
								if(responseText==1){
									alert("删除成功");
								}else{
									alert("删除失败");
								}
							});
						});
						//将当前行的json对象绑定到当前按钮上
						ib1.foodObj = obj;
						ib1.addEventListener("click", function() {
							var eventSrc = event.srcElement;
							document.getElementById('updateDiv').style.display='block';
							document.getElementsByName('upfoodname')[0].value=eventSrc.foodObj.foodname;
							document.getElementsByName('upprice')[0].value=eventSrc.foodObj.price;
							document.getElementsByName('foodid')[0].value=eventSrc.foodObj.foodid;
						});
						tr.appendChild(td);
						tr.appendChild(td1);
						tr.appendChild(td2);

						tr.setAttribute("name", "dataTr");
						/* 	var trHtml = "<tr><td>"+obj.foodname+"</td><td>"+obj.price+"</td></tr>"; */
						table.appendChild(tr);
					}
				});

		//open(method(请求格式),url(文件地址),Async(异步true/同步false));
		//一个ajax线程是否执行完成 可以通过回调函数 xmlhttp.onreadystatechange 是否执行完成判断
		//异步 多个线程同时执行 无法判断 谁先执行 true
		//同步 一次只允许一个线程执行 false 页面会假死
		//true 通过 AJAX，JavaScript 无需等待服务器的响应，而是：
		//	在等待服务器响应时执行其他脚本
		//	当响应就绪后对响应进行处理
		//false javaScript 会等到服务器响应就绪才继续执行。如果服务器繁忙或缓慢，应用程序会挂起或停止。
		//	当您使用 async=false 时，请不要编写 onreadystatechange 函数 - 把代码放到 send() 语句后面即可：
		//	open方法表示产生一个请求的关联（get 提交）
		/* xmlhttp.open("GET","${pageContext.request.contextPath}/queryFood?foodname="
						+ foodName, true);
		xmlhttp.send(); */
		//post提交
		/* xmlhttp.open("POST", "${pageContext.request.contextPath}/queryFood",
				false);
		xmlhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded;charset=UTF-8");
		xmlhttp.send("foodname=" + foodName + "&a=1"); */
	}
	function saveFood(){
		var foodName = document.getElementsByName("foodname")[0].value;
		var price = document.getElementsByName("price")[0].value;
		sendAjax("${pageContext.request.contextPath}/food", "POST","foodName="+foodName+"&price="+price, function(responseText){
								if(responseText==1){
									alert("添加成功");
									document.getElementById('addDiv').style.display='none';
									query();
								}else{
									alert("添加失败");
								}
		});
	}
	function updateFood(){
		var foodId = document.getElementsByName("foodid")[0].value;
		var foodName = document.getElementsByName("upfoodname")[0].value;
		var price = document.getElementsByName("upprice")[0].value;
		sendAjax("${pageContext.request.contextPath}/food/"+foodId, "POST","foodName="+foodName+"&price="+price+"&_method=PUT", function(responseText){
								if(responseText==1){
									alert("修改成功");
									document.getElementById('updateDiv').style.display='none';
									query();
								}else{
									alert("修改失败");
								}
		});
	}
</script>
</head>
<body>
	<input type="text" name="foodName" />
	<input type="button" value="查询" onclick="query()" />
	<input type="button" value="新增" onclick="document.getElementById('addDiv').style.display='block';"/>
	<table id="table">
		<tr>
			<th>菜名</th>
			<th>价格</th>
			<th>操作</th>
		</tr>
	</table>
	<div id="addDiv" style="display:none;position:absolute;left:43%;top:43%;z-index:100;border:1px solid black;width:240px;height: 240px;">
	 	菜名:<input type="text"  name="foodname"/><br/>
	 	价格:<input type="text"  name="price"/><br/>
	 	<input type="button" value="保存" onclick="saveFood()" />
	 	<input type="button" value="关闭" onclick="document.getElementById('addDiv').style.display='none';"/>
	</div>
	<div id="updateDiv" style="display:none;position:absolute;left:43%;top:43%;z-index:100;border:1px solid black;width:240px;height: 240px;">
	 	菜名:<input type="text"  name="upfoodname"/><br/>
	 	价格:<input type="text"  name="upprice"/><br/>
	 	<input type="hidden" name="foodid"/>
	 	<input type="button" value="修改" onclick="updateFood()" />
	 	<input type="button" value="关闭" onclick="document.getElementById('updateDiv').style.display='none';"/>
	</div>
</body>
</html>