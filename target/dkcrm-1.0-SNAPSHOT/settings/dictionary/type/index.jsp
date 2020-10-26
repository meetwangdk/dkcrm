<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
	<title>Title</title>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

	<%--一般将下拉框，单选框，复选框。。。中的字典值放在application全局作用域中（上下文作用域中）--%>
	<%--<script type="text/javascript">
		$(document).ready(function () {
			freshList();
			function freshList() {
				var html = "";
				$.ajax({
					url:"setting/set/selectDicType",
					type:"get",
					dataType:"json",
					success:function (data) {
						$.each(data,function (i,n) {
						html += '<tbody>'
						html += '<tr class="active">'
						html += '<td><input type="checkbox" /></td>'
						html += '<td>1</td>'
						html += '<td>sex</td>'
						html += '<td>性别</td>'
						html += '<td>性别包括男和女</td>'
						html += '</tr>'
						html += '</tbody>'
						})
					}
				})
			}
		})
	</script>--%>
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典类型列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='settings/dictionary/type/save.jsp'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-default" onclick="window.location.href='settings/dictionary/type/edit.jsp'"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" /></td>
					<td>序号</td>
					<td>编码</td>
					<td>名称</td>
					<td>描述</td>
				</tr>
			</thead>
			<%--<tbody>
				<tr class="active">
					<td><input type="checkbox" /></td>
					<td>1</td>
					<td>sex</td>
					<td>性别</td>
					<td>性别包括男和女</td>
				</tr>
			</tbody>--%>
		</table>
	</div>
	
</body>
</html>