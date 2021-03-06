<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
			/*添加时间日期插件*/
			$(".time").datetimepicker({
				minView : "month",
				language : "zh-CN",
				format : "yyyy-mm-dd",
				autoclose : true,
				todayBtn : true,
				pickerPosition : "bottom-left"
			});

			$("#edit-startTime").datetimepicker({
				minView : "month",
				language : "zh-CN",
				format : "yyyy-mm-dd",
				autoclose : true,
				todayBtn : true,
				pickerPosition : "bottom-left"
			});$("#edit-endTime").datetimepicker({
				minView : "month",
				language : "zh-CN",
				format : "yyyy-mm-dd",
				autoclose : true,
				todayBtn : true,
				pickerPosition : "bottom-left"
			});

			/*为按钮绑定一个模态窗口
            * 需要操作的模态窗口的jquery对象。调用modal方法， 为该方法传递参数show:打开模态窗口hide: 关闭模态窗口*/
			$("#addBtn").click(function () {
				/*为下拉列表铺值*/
				var html = "";
				$.ajax({
							url:"workbench/activity/getUserList.do",
							data:{
							},
							type:"get",
							dataType:"json",
							success:function (resp) {
								/*遍历出来的每一个n都是一个User对象*/
								$.each(resp,function(i,n) {
									/*做一个拼接*/
									html +=  "<option value='"+n.id+"'>"+n.name+"</option>";

								})
								$("#create-owner").html(html)
								/*将当前用户信息显示到下拉列表*/
								var user = "${user.id}"
								$("#create-owner").val(user)
								/*处理完下拉框中的数据后打开模态窗口*/
								$("#createActivityModal").modal("show");
							}
				})
			})


			/*
			保存活动信息模
			块*/
			$("#saveBtn").click(function () {
				$.ajax({
					url:"workbench/activity/addActivity.do",
					data: {
						"owner":$.trim($("#create-owner").val()),
						"name":$.trim($("#create-name").val()),
						"startDate":$.trim($("#create-startTime").val()),
						"endDate":$.trim($("#create-endTime").val()),
						"cost":$.trim($("#create-cost").val()),
						"description":$.trim($("#create-description").val()),
					},
					type: "post",
					dataType: "json",
					success:function (resp) {
						if(resp.success){
							alert("保存成功");
							/*点击保存过后需要将表单重置
							* jQuery对象如何转换为Dom对象：
							* 		jQuery对象[数字下标]
							*Dom对象如何转换为jQuery对象
							*		$(dom对象)
							*
							* */
							$("#createActivityModal").modal("hide");
							$("#resetActivityForm")[0].reset();
							/*pageList(1,2);*/
							/*
							* 	($("#activityPage").bs_pagination('getOption', 'currentPage')
							*	表示:操作后停留在当前页面
							* 	$("#activityPage").bs_pagination('getOption', 'rowsPerPage')
							* 	表示：操作后维持之前设置好的展示的记录数
							*
							*
							*  */
							/*pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
									,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));*/
							pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
						}
						else{
							alert("保存失败")
						}

					}


				})
			})

			pageList(1,2);
			/*为了解决在改变当前搜索框中的内容，但不点击查询，
			之后点击下一页出现搜索当前收索框中的内同进行展现的问题
			通过一个隐藏域进行传递值保存值
			*/
			$("#searchBut").click(function () {
				/*将搜索框中的数据保存到隐藏域当中*/
				$("#hid-name").val($.trim($("#search-name").val()));
				$("#hid-owner").val($.trim($("#search-owner").val()));
				$("#hid-startDate").val($.trim($("#search-startDate").val()));
				$("#hid-endDate").val($.trim($("#search-endDate").val()));
				pageList(1,2);
			})



			/*将复选框进行全选操作
			* 以及活动删除功能的实现
			* */

			$("#selectAll").click(function () {
				$("input[name=check]").prop("checked",this.checked);
			})
			//以下这种做法是不行的
			/*$("input[name=xz]").click(function () {
            alert(123);
            })*/

			//因为动态生成的元素，是不能够以普通绑定事件的形式来进行操作的
			/*动态生成的元素，我们要以on方法的形式来触发事件
				语法:
					$(需要绑定元素的有效的外层元素). on(绑定事件的方式,需要绑定的元素的jquery对象,回调函数)
			*/
			$("#activityBody").on("click",$("input[name=xz]"),function () {
				$("#selectAll").prop("checked",$("input[name=check]").length ==$("input[name=check]:checked").length)
			})



			/*对于删除操作，data数据使用json格式的拼接比较麻烦，并且key不能重复\
			* 但是具有多个id值因此我们取普通的字符串拼接的方式来完成
			* 	http://localhost:8080:/dkcrm/workbench/activity/removeActivity.do?id=?????&id=?????.....
			* */
			/*下面几行代码是为了拼接：id=?????&id=?????....*/
			$("#removeActivity").click(function () {
				if ($("input[name=check]:checked").length == 0){
					alert("请选择您要删除的市场活动")
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
							url:"workbench/activity/removeActivity.do",
							type:"post",
							data:param,
							dataType:"json",
							success:function (data) {
								if (data == true ){
									pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));}
								else {
									alert("删除失败")
								}
							}
						})
					}

				}
			})


			/*实现活动修改内容
			* 	第一步：先将查询的结果展示给前台页面
			* 	第二部：将前台输出的结果更新到后台页面
			* */
			$("#editActivity").click(function () {
				var html = "";
				$.ajax({
					url:"workbench/activity/getUserList.do",
					data:{
					},
					type:"get",
					dataType:"json",
					success:function (resp) {
						/*遍历出来的每一个n都是一个User对象*/
						$.each(resp,function(i,n) {
							/*做一个拼接*/
							html +=  "<option value='"+n.id+"'>"+n.name+"</option>";
						})
						$("#edit-marketActivityOwner").html(html)
						/*处理完下拉框中的数据后打开模态窗口*/
					}
				})
				var id = $("input[name=check]:checked").val();
				$.ajax({
					url:"workbench/activity/editActivity.do",
					data:{
						id:id
					},
					type:"post",
					datatype:"json",
					success:function (data) {
						$("#editActivityModal").modal("show");
						$("#edit-marketActivityName").val(data.name);
						$("#edit-startTime").val(data.startDate);
						$("#edit-endTime").val(data.endDate);
						$("#edit-cost").val(data.cost);
						$("#edit-describe").val(data.description);
					}
				})
				/* 开始实行更新内容 */
				$("#updateBtn").click(function () {
					$.ajax({
						url:"workbench/activity/updateActivity.do",
						data:{
							/*owner:$.trim($("#edit-marketActivityOwner option:selected").val()),*/
							owner:$.trim($("#edit-marketActivityOwner").val()),
							id:$.trim($("input[name=check]:checked").val()),
							name:$.trim($("#edit-marketActivityName").val()),
							startDate:$.trim($("#edit-startTime").val()),
							endDate:$.trim($("#edit-endTime").val()),
							cost:$.trim($("#edit-cost").val()),
							description:$.trim($("#edit-describe").val())
						},
						type:"post",
						dataType:"json",
						success:function (data) {
							if (data == true){
								/*表示修改成功后维持到当前页面*/
								pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
										,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'))

								$("#editActivityModal").modal("hide");
								alert("更新成功");
								/*console.log($.trim($("#edit-marketActivityOwner").val()));*/
							}
							else{
								alert("更新失败")
							}
						}
					})
				})
			})








		});



		/*对于所有的关系型数据库，做前端的分页相关操作的基础组件
			就是pageNo和pageSize
			pageNo:页码
			pageSize:每页展现的记录数
			pagelist方法:就是发出ajax请求到后台，从后台取得最新的市场活动信息列表数据
			通过响应回来的数据，局部刷新市场活动信息列表
			我们都在哪些情况下，需要调用pagelist方法 (什么情况下需要刷新一下市场活动列表)
			(1)点击左侧菜单中的“市场活动"超链接，需要刷新市场活动列表，调用pageList方法
			(2)添加，修改，删除后，需要刷新市场活动列表，调用pagelist方法
			(3)点击查询按钮的时候，需要刷新市场活动列表，调用pagelist方法
			(4)点击分页组件的时候，调用pagelist方法
			
			以上为pagelist方法制定了六个入口，也就是说，在以上6个操作执行完毕后，我们必须要调用pagelist方法，刷新市场活动信息列表

		*/
		function pageList(pageNo,pageSize) {
			$("#selectAll").prop("checked",false);
			$("#search-name").val($.trim($("#hid-name").val()));
			$("#search-owner").val($.trim($("#hid-owner").val()));
			$("#search-startDate").val($.trim($("#hid-startDate").val()));
			$("#search-endDate").val($.trim($("#hid-endDate").val()));

			$.ajax({
				url:"workbench/activity/pageList.do",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"name":$.trim($("#search-name").val()),
					"owner":$.trim($("#search-owner").val()),
					"startDate":$.trim($("#search-startDate").val()),
					"endDate":$.trim($("#search-endDate").val())
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					/*console.log($("#activity-body"))*/
					var total = data.total;
					/*console.log("total"+total);*/
					//$("#total").html(total);
					let html = "";
					$.each(data.list,function (i,activity) {
						html += '<tr class="active">';
						html += '<td><input type="checkbox" class="inputName" name="check" value="'+activity.id+'" /></td>';
						html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="href = \'workbench/activity/detail.do?id='+activity.id+'\'">'+activity.name+'</a></td>';
						html += '<td>'+activity.owner+'</td>';
						html += '<td>'+activity.startDate+'</td>';
						html += '<td>'+activity.endDate+'</td>';
						html += '</tr>'
					})
					$("#activityBody").html(html);
				    /*计算总的页数*/
					var totalPages =  Math.ceil(data.total/pageSize) ;
							//data.total%pageSize==0?data.total/pageSize:(parseInt(data.total/pageSize)+1);
					/*console.log("totalPages"+totalPages);*/
					//数据处理完毕后，结合分页查询，对前端展现分页信息
					$("#activityPage").bs_pagination({
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
<%--创建4个隐藏域--%>
<input type="hidden" id="hid-name"/>
<input type="hidden" id="hid-owner"/>
<input type="hidden" id="hid-startDate"/>
<input type="hidden" id="hid-endDate"/>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
			</div>
			<div class="modal-body">

				<form id="resetActivityForm" class="form-horizontal" role="form">

					<div class="form-group">
						<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-owner">

							</select>
						</div>
						<label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-name">
						</div>
					</div>

					<div class="form-group">
						<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="create-startTime" readonly>
						</div>
						<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control time" id="create-endTime" readonly>
						</div>
					</div>
					<div class="form-group">
						<label for="create-cost" class="col-sm-2 control-label">成本</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-cost">
						</div>
					</div>
					<div class="form-group">
						<label for="create-describe" class="col-sm-2 control-label">描述</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="create-description"></textarea>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<%--

				data-dismiss="modal"，表示关闭模态窗口

				--%>
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
			</div>
		</div>
	</div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 85%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-marketActivityOwner">

							</select>
						</div>
						<label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-marketActivityName">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-startTime">
						</div>
						<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-endTime">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-cost" class="col-sm-2 control-label">成本</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-cost">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-describe" class="col-sm-2 control-label">描述</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="edit-describe"></textarea>
						</div>
					</div>

				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
			</div>
		</div>
	</div>
</div>




<div>
	<div style="position: relative; left: 10px; top: -10px;">
		<div class="page-header">
			<h3>市场活动列表</h3>
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
						<input class="form-control" type="text" id="search-name">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">所有者</div>
						<input class="form-control" type="text" id="search-owner">
					</div>
				</div>


				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">开始日期</div>
						<input class="form-control" type="text" id="search-startDate" />
					</div>
				</div>
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">结束日期</div>
						<input class="form-control" type="text" id="search-endDate">
					</div>
				</div>

				<button type="button" class="btn btn-default" id="searchBut">查询</button>

			</form>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
			<div class="btn-group" style="position: relative; top: 18%;">
				<%--

                data-toggle="modal"
                    表示触发该按钮，将要打开一个模态窗口
                data-target
                    表示我要打开哪个模态窗口。。。
                    data-toggle="modal" data-target="#createActivityModal"
                --%>
				<button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				<button type="button" class="btn btn-default" id="editActivity"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				<button type="button" class="btn btn-danger" id="removeActivity"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>

		</div>
		<div style="position: relative;top: 10px;">
			<table class="table table-hover">
				<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" id="selectAll"/></td>
					<td>名称</td>
					<td>所有者</td>
					<td>开始日期</td>
					<td>结束日期</td>
				</tr>
				</thead>
				<tbody id="activityBody">

				</tbody>
			</table>
		</div>

		<div style="height: 50px; position: relative;top: 30px;">

			<div id="activityPage"></div>
		</div>

	</div>

</div>
</div>
</body>
</html>