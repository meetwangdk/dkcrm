<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入下面的这行代码循环作用域中的对象--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">


	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<%--加入日历插件--%>
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

	<%--加入日历插件--%>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<%--加入分页插件(一定要加在bootstrap下面)--%>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>



	<script type="text/javascript">

		$(function(){

			$(".time").datetimepicker({
				minView : "month",
				language : "zh-CN",
				format : "yyyy-mm-dd",
				autoclose : true,
				todayBtn : true,
				pickerPosition : "bottom-left"
			});
			/*将User用户展示到下拉框中*/
			$("#addBtn").click(function () {
				var html = "";
				$("#create-fullname").val("");
				$("#create-appellation").val("");
				$("#create-owner").val("");
				$("#create-company").val("");
				$("#create-job").val("");
				$("#create-email").val("");
				$("#create-phone").val("");
				$("#create-website").val("");
				$("#create-mphone").val("");
				$("#create-state").val("");
				$("#create-source").val("");
				$("#create-description").val("");
				$("#create-contactSummary").val("");
				$("#create-nextContactTime").val("");
				$("#create-address").val("");
				$.ajax({
					url:"workbench/clue/addUser.do",
					data:{},
					type:"get",
					dataType:"json",
					success:function (data) {
						$.each(data,function (i,n) {
							html += "<option value='"+n.id+"'>"+n.name+"</option>"
						})
						$("#create-owner").html(html);
						/*一定要加上引号！！！！*/
						var userId = "${user.id}";
						$("#create-owner").val(userId);
						$("#createClueModal").modal("show");
					}
				})

			})
			/*创建线索模块内容*/
			$("#saveBtn").click(function () {
				$.ajax({
					url:"workbench/clue/saveClue.do",
					data:{
						fullname:$.trim($("#create-fullname").val()),
						appellation:$.trim($("#create-appellation").val()),
						owner:$.trim($("#create-owner").val()),
						company:$.trim($("#create-company").val()),
						job:$.trim($("#create-job").val()),
						email:$.trim($("#create-email").val()),
						phone:$.trim($("#create-phone").val()),
						website:$.trim($("#create-website").val()),
						mphone:$.trim($("#create-mphone").val()),
						state:$.trim($("#create-state").val()),
						source:$.trim($("#create-source").val()),
						description:$.trim($("#create-description").val()),
						contactSummary:$.trim($("#create-contactSummary").val()),
						nextContactTime:$.trim($("#create-nextContactTime").val()),
						address:$.trim($("#create-address").val()),
					},
					type:"post",
					dataType: "json",
					success:function (data) {
						if (data){
							//	做一些行为
							pageList(1,2);
						}
						else{
							alert("添加失败")
						}
					}
				})
			})
			/*修改线索模块内容*/
			$("#editClueBtn").click(function () {
				var html = "";
				$.ajax({
					url:"workbench/clue/addUser.do",
					data:{},
					type:"get",
					dataType:"json",
					success:function (data) {
						$.each(data,function (i,n) {
							html += "<option value='"+n.id+"'>"+n.name+"</option>"
						})
						$("#edit-owner").html(html);
						/*一定要加上引号！！！！*/
						var userId = "${user.id}";
						$("#edit-owner").val(userId);
					}
				})
				var id = $("input[name=check]:checked").val()
				$.ajax({
					url:"workbench/clue/selectByClueId.do",
					type:"get",
					data:{
						"id":id,
					},
					dataType:"json",
					success:function(data){
						$("#edit-fullname").val(data.fullname),
								$("#edit-appellation").val(data.appellation),
								$("#edit-company").val(data.company),
								$("#edit-job").val(data.job),
								$("#edit-email").val(data.email),
								$("#edit-phone").val(data.phone),
								$("#edit-website").val(data.website),
								$("#edit-mphone").val(data.mphone),
								$("#edit-source").val(data.source),
								$("#edit-state").val(data.state),
								$("#edit-description").val(data.description),
								$("#edit-contactSummary").val(data.contactSummary),
								$("#edit-nextContactTime").val(data.nextContactTime),
								$("#edit-address").val(data.address)
						$("#editClueModal").modal("show");
					}
				})
				$("#updateClue").click(function () {
					var id = $("input[name=check]:checked").val()
					$.ajax({
						url:"workbench/clue/editClue.do",
						data:{
							"id":id,
							"fullname":$.trim($("#edit-fullname").val()),
							"appellation":$.trim($("#edit-appellation").val()),
							"owner":$.trim($("#edit-owner").val()),
							"company":$.trim($("#edit-company").val()),
							"job":$.trim($("#edit-job").val()),
							"email":$.trim($("#edit-email").val()),
							"phone":$.trim($("#edit-phone").val()),
							"website":$.trim($("#edit-website").val()),
							"mphone":$.trim($("#edit-mphone").val()),
							"state":$.trim($("#edit-state").val()),
							"source":$.trim($("#edit-source").val()),
							"description":$.trim($("#edit-description").val()),
							"contactSummary":$.trim($("#edit-contactSummary").val()),
							"nextContactTime":$.trim($("#edit-nextContactTime").val()),
							"address":$.trim($("#edit-address").val())
						},
						type:"post",
						dataType:"json",
						success:function (data) {
							if (data){
								pageList(1,2);
							}else{
								alert("修改失败");
							}
						}

					})
				})

			})

			/*刷新当前页面*/
			pageList(1,2)

			$("#checkedAll").on("click",function () {
				$("input[name='check']").prop("checked",this.checked)
				alert("表示当前选中的js对象"+this.checked)
			})
			$("#tbodyText").on("click",$("input[name=xz]"),function () {
				$("#checkedAll").prop("checked",$("input[name='check']").length ==$("input[name='check']:checked").length)
			})


			/*删除线索按钮*/
			$("#dropBtn").click(function () {
				if (($("input[name=check]:checked").length) == 0)
				{
					alert("请选择您要删除的元素")
				}else{
					var $xz = $("input[name=check]:checked");
					var param = ""
					/*这个地方得到的是选中的jquery对象*/
					for(var i = 0; i<$xz.length ;i++){
						param += "id="+$($xz[i]).val()
						if ( i<($xz.length-1)){
							param += "&"
						}
					}
					if (confirm("确定删除该选中数据吗？")){
						$.ajax({
							url:"workbench/clue/removeClue.do",
							type:"post",
							data:param,
							dataType:"json",
							success:function (data) {
								if (data) {
									if (data) {
										pageList(1, $("#cluePage ").bs_pagination('getOption', 'rowsPerPage'));
									} else {
										alert("删除失败")
									}
								}
							}
						})
					}
				}
			})

			$("#searchBtn").click(function () {
				pageList(1,2);
			})

		});
		function pageList(pageNo,pageSize) {
			$("#checkedAll").prop("checked",false);
            /*$("#search-name").val($.trim($("#hid-name").val()));
            $("#search-owner").val($.trim($("#hid-owner").val()));
            $("#search-startDate").val($.trim($("#hid-startDate").val()));
            $("#search-endDate").val($.trim($("#hid-endDate").val()));*/
			$.ajax({
				url:"workbench/clue/selectClueList.do",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"fullname":$.trim($("#fullname").val()),
					"company":$.trim($("#company").val()),
					"phone":$.trim($("#phone").val()),
					"mphone":$.trim($("#mphone").val()),
					"owner":$.trim($("#owner").val()),
					"source":$("#source option:selected").val(),
					"state":$("#state option:selected").val(),

				},
				type:"post",
				dataType:"json",
				success:function (data) {
					/*console.log($("#activity-body"))*/
					var total = data.total;
					/*console.log("total"+total);*/
					//$("#total").html(total);
					let html = "";
					$.each(data.list,function (i,clue) {
						html += '<tr class="active">';
						html += '<td><input type="checkbox" name="check" value="'+clue.id+'"/></td>';
						html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/clue/detail.do?id='+clue.id+'\'">'+clue.fullname+'</a></td>';
						html += '<td>'+clue.company+'</td>';
						html += '<td>'+clue.phone+'</td>';
						html += '<td>'+clue.mphone+'</td>';
						html += '<td>'+clue.source+'</td>';
						html += '<td>'+clue.fullname+'</td>';
						html += '<td>'+clue.state+'</td>';
						html += '</tr>';
					})
					$("#tbodyText").html(html);
					/*计算总的页数*/
					var totalPages =  Math.ceil(data.total/pageSize) ;
					//data.total%pageSize==0?data.total/pageSize:(parseInt(data.total/pageSize)+1);
					/*console.log("totalPages"+totalPages);*/
					//数据处理完毕后，结合分页查询，对前端展现分页信息
					$("#cluePage ").bs_pagination({
						currentPage: pageNo, // 页码
						rowsPerPage: pageSize, // 每页显示的记录条数
						maxRowsPerPage: 20, // 每页最多显示的记录条数
						totalPages: totalPages, // 总页数
						totalRows: data.total, // 总记录条数
						visiblePageLinks: 3, // 显示几个卡片
						showGoToPage: true,
						showRowsPerPage: true,
						showRowsInfo: true,
						showRowsDefaultInfo: true,
						/*该回调函数在我们点击分页组件的时候*/
						onChangePage : function(event, data){
							pageList(data.currentPage , data.rowsPerPage);
						}
					})
				}
			})
		}
	</script>
</head>
<body>

<!-- 创建线索的模态窗口 -->
<div class="modal fade" id="createClueModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">创建线索</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">

					<div class="form-group">
						<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-owner">

							</select>
						</div>
						<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-company">
						</div>
					</div>

					<div class="form-group">
						<label for="create-call" class="col-sm-2 control-label">称呼</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-appellation">
								<option></option>
								<c:forEach items="${appellation}" var="a">
									<option value="${a.value}">${a.text}</option>
								</c:forEach>
							</select>
						</div>
						<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-fullname">
						</div>
					</div>

					<div class="form-group">
						<label for="create-job" class="col-sm-2 control-label">职位</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-job">
						</div>
						<label for="create-email" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-email">
						</div>
					</div>

					<div class="form-group">
						<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-phone">
						</div>
						<label for="create-website" class="col-sm-2 control-label">公司网站</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-website">
						</div>
					</div>

					<div class="form-group">
						<label for="create-mphone" class="col-sm-2 control-label">手机</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-mphone">
						</div>
						<label for="create-status" class="col-sm-2 control-label">线索状态</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-state">
								<option></option>
								<c:forEach items="${clueState}" var="a">
									<option value="${a.value}">${a.text}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="create-source" class="col-sm-2 control-label">线索来源</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-source">
								<option></option>
								<c:forEach items="${source}" var="a">
									<option value="${a.value}">${a.text}</option>
								</c:forEach>
							</select>
						</div>
					</div>


					<div class="form-group">
						<label for="create-describe" class="col-sm-2 control-label">线索描述</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="create-description"></textarea>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

					<div style="position: relative;top: 15px;">
						<div class="form-group">
							<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-nextContactTime">
							</div>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

					<div style="position: relative;top: 20px;">
						<div class="form-group">
							<label for="create-address" class="col-sm-2 control-label">详细地址</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="1" id="create-address"></textarea>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" id="saveBtn" class="btn btn-primary" data-dismiss="modal">保存</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改线索的模态窗口 -->
<div class="modal fade" id="editClueModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">修改线索</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">

					<div class="form-group">
						<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-owner">
							</select>
						</div>
						<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-company" value="动力节点">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-call" class="col-sm-2 control-label">称呼</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-appellation">
								<option></option>
								<c:forEach items="${appellation}" var="a">
									<option value="${a.value}">${a.text}</option>
								</c:forEach>
							</select>
						</div>
						<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-fullname" value="李四">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-job" class="col-sm-2 control-label">职位</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-job" value="CTO">
						</div>
						<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-phone" value="010-84846003">
						</div>
						<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-mphone" value="12345678901">
						</div>
						<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-state">
								<option></option>
								<c:forEach items="${clueState}" var="a">
									<option value="${a.value}">${a.text}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-source">
								<option></option>
								<c:forEach items="${source}" var="a">
									<option value="${a.value}">${a.text}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="edit-describe" class="col-sm-2 control-label">描述</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="edit-description">这是一条线索的描述信息</textarea>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

					<div style="position: relative;top: 15px;">
						<div class="form-group">
							<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-nextContactTime" value="2017-05-01">
							</div>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

					<div style="position: relative;top: 20px;">
						<div class="form-group">
							<label for="edit-address" class="col-sm-2 control-label">详细地址</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="1" id="edit-address">北京大兴区大族企业湾</textarea>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" id="updateClue" class="btn btn-primary" data-dismiss="modal">更新</button>
			</div>
		</div>
	</div>
</div>




<div>
	<div style="position: relative; left: 10px; top: -10px;">
		<div class="page-header">
			<h3>线索列表</h3>
		</div>
	</div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

	<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

		<div class="btn-toolbar" role="toolbar" style="height: 80px;">
			<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">名称</div>
						<input class="form-control" type="text" id="fullname">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">公司</div>
						<input class="form-control" type="text" id="company">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">公司座机</div>
						<input class="form-control" type="text" id="phone">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">线索来源</div>
						<select class="form-control" id="source">
							<option></option>
							<c:forEach items="${source}" var="a">
								<option value="${a.value}">${a.text}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<br>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">所有者</div>
						<input class="form-control" type="text" id="owner">
					</div>
				</div>



				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">手机</div>
						<input class="form-control" type="text" id="mphone">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">线索状态</div>
						<select class="form-control" id="state">
							<option></option>
							<c:forEach items="${clueState}" var="a">
								<option value="${a.value}">${a.text}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<button type="button" id="searchBtn" class="btn btn-default">查询</button>

			</form>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
			<div class="btn-group" style="position: relative; top: 18%;">

				<%--data-toggle="modal" data-target="#createClueModal"
                        手动打开模态窗口
                --%>
				<button type="button" id="addBtn" class="btn btn-primary" ><span class="glyphicon glyphicon-plus"></span> 创建</button>
				<button type="button" id="editClueBtn" class="btn btn-default"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				<button type="button" id="dropBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>


		</div>
		<div style="position: relative;top: 50px;">
			<table class="table table-hover">
				<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="checkedAll" type="checkbox" /></td>
					<td>名称</td>
					<td>公司</td>
					<td>公司座机</td>
					<td>手机</td>
					<td>线索来源</td>
					<td>所有者</td>
					<td>线索状态</td>
				</tr>
				</thead>
				<tbody id="tbodyText">
				</tbody>
			</table>
		</div>

		<div style="height: 50px; position: relative;top: 60px;">
			<%--<div>
				<button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
			</div>
			<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
				<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
				<div class="btn-group">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						10
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">20</a></li>
						<li><a href="#">30</a></li>
					</ul>
				</div>
				<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
			</div>
			<div style="position: relative;top: -88px; left: 285px;">--%>
			<%--<nav>
                <ul class="pagination">
                    <li class="disabled"><a href="#">首页</a></li>
                    <li class="disabled"><a href="#">上一页</a></li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li><a href="#">下一页</a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </ul>
            </nav>--%>
			<%--</div>--%>
			<div id="cluePage"></div>
		</div>
	</div>

</div>
</body>
</html>