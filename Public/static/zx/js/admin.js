//签到人员选择的函数
var pn = [];

function checkP(obj) {

	if(obj.is(":checked")) {
		pn.push(obj.val());
		obj.closest("td").find(".peopleN").val(pn);
	} else {
		if(pn.indexOf(obj.val()) > -1) {
			pn.splice(pn.indexOf(obj.val()), 1)
		}
		obj.closest("td").find(".peopleN").val(pn);
	}

};
//列表单选多选
var chtrue = function(obj) {
	var checked;
	var chbtn = $("table").find("td.checkboxbtn input");
	for(var i = 0; i < chbtn.length; i++) {
		if(chbtn.eq(i).prop("checked") == false) {
			$("#checkAll").removeAttr("checked");
			return
		} else {
			$("#checkAll").prop("checked", true);
		}
	}

};

//列表单选多选2
var chtrue2 = function(obj) {
	////////点击父级--》，子集有不选中父级不选中，子集全选，父级选中
	var checkedbl;
	var chbtn = obj.closest(".peopleN_s").find(".panel-body input");
	for(var i = 0; i < chbtn.length; i++) {
		if(chbtn.eq(i).prop("checked") == false) { //有一个子集不选中则父级不选中
			obj.closest(".peopleN_s").find(".all_check").removeAttr("checked");
			return
		} else { //子集全部不选中父级选中
			obj.closest(".peopleN_s").find(".all_check").prop("checked", true);
		}
	};

	////////子集取消选择 输入框取消父级输入

};
//参会人员的选择

$(function() {
	$(".slidAll").click(function() {
		$(this).closest(".panel").find(".panel-body").slideToggle();
	})
})

//单个

function checkP2(obj) {
	//判断1所有的选中的值加入数组
	var pn2 = [];
	var flag=true;
	var ckinput = obj.closest(".peopleN_s .panel-body").find("input");
	var titinput = obj.closest(".peopleN_s").find(".all_check");

	//循环每个子集判断是否选中
	for(var i = 0; i < ckinput.length; i++) {
		//判断选中与不选中
		if(ckinput.eq(i).is(":checked")) {
			pn2.push(ckinput.eq(i).val());
			obj.closest("td").find(".peopleN").val(pn2);

		} else {
			if(pn2.indexOf(ckinput.eq(i).val()) > -1) {
				pn2.splice(pn2.indexOf(ckinput.eq(i).val()), 1)
			}
		}
	}
		//判断全选与全不选
		for (var i=0;i<titinput.length;i++) {
			if(titinput.eq(i).is(":checked")) {//有一个选中则不可能为全不选
				alert("全选")
			}
		}

	
	//判断是否全选和其它
	if(flag) { //所有的子集都选中
		pn2.push(obj.closest(".peopleN_s").find(".all_check").val()); //得到通讯组的名字加入数组

	}else{ //所有的子集都不选中
		pn2 = []
	}
	obj.closest("td").find(".peopleN").val(pn2);

	//////
	var checked;
	var chbtn = $(".peopleN_s").find(".panel-body input");
	for(var i = 0; i < chbtn.length; i++) {
		if(chbtn.eq(i).prop("checked") == false) {
			$(this).closest(".peopleN_s ").removeAttr("checked");
			return
		} else {
			$(this).closest(".peopleN_s").prop("checked", true);
		}
	};
}

$(function() {

	$(".peopleN").click(function() {
		$(this).parent("td").find(".peopleN_s").slideToggle()
	});
	$(".sideMenu ul>li").click(function() {
		$(this).find("ol").slideToggle()
	});

	//	浏览器版本判断
	var DEFAULT_VERSION = "8.0";
	var ua = navigator.userAgent.toLowerCase();
	var isIE = ua.indexOf("msie") > -1;
	var safariVersion;
	if(isIE) {
		safariVersion = ua.match(/msie ([\d.]+)/)[1];
		if(safariVersion <= DEFAULT_VERSION) {
			$('body').html('<h1 style="color:red">您的浏览器版本太低，请升级浏览器，或更换其它浏览器</h1>')
		} else {
			// 跳转至页面2
		}
	} else {
		// 跳转至页面2
	}

	window.addEventListener("resize", setSize, false);

	function setSize() {
		var H = $(window).height();
		var W = $(window).width();
		var TH = $(".ar_nav_top").height();
		var TW = $(".ar_nav_top").width();
		var sW = $(".ar_sidebar").width()
		$(".ar_content").height(H - TH);
		$(".ar_content").width(W - sW);
		$(".ar_sidebar").height(H - TH);

		$(".ar_content").css({
			"left": sW
		})
	}
	setSize()

	//左侧隐藏
	var onoff_btn = true
	$("#sider_btn").click(function() {
		if(onoff_btn == true) {
			$(".ar_sidebar").animate({
				width: '0px'
			}, 0, function() {
				setSize()
			})
			$("#ar_sidebar_box").animate({
				width: '0px'
			}, 0)
			$(this).text("展开")
			onoff_btn = false;
		} else {
			$(".ar_sidebar").animate({
				width: '250px'
			}, 0, function() {
				setSize()
			});
			$("#ar_sidebar_box").animate({
				width: '250px'
			}, 0)
			$(this).text("隐藏")
			onoff_btn = true;
		}

	});
	//end
	// 头像上传
	$(".img").change(function() {
		var fileImg = $(".fileImg");
		var explorer = navigator.userAgent;
		var imgSrc = $(this)[0].value;
		if(explorer.indexOf('MSIE') >= 0) {
			//只支持jpg和png的图片格式
			if(!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/.test(imgSrc)) {
				imgSrc = "";
				fileImg.attr("src", "/img/default.png");
				return false;
			} else {
				fileImg.attr("src", imgSrc);
			}
		} else {
			if(!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/.test(imgSrc)) {
				imgSrc = "";
				fileImg.attr("src", "/img/default.png");
				return false;
			} else {
				var file = $(this)[0].files[0];
				var url = URL.createObjectURL(file);
				fileImg.attr("src", url);
			}
		}
	});
	//end
	//???
	$(".file").change(function() {
		$(".fileshow").html($(this)[0].value)
	});
	//end
	//获取协办单位的值
	var selectarr = [];
	if($('#my-select').length >= 1) {
		$('#my-select').multiSelect({
			afterSelect: function(values) {
				//这里values是一个隐形的数组格式坑啊
				//所以先转换成字符串
				values = JSON.stringify(values);
				selectarr.push(values);
				console.log(selectarr);
				$("#my-multiple").val(selectarr);
			},
			afterDeselect: function(values2) {
				values2 = JSON.stringify(values2)
				var index = selectarr.indexOf(values2);
				console.log(index);
				if(index > -1) {
					selectarr.splice(index, 1)
				}
				$("#my-multiple").val(selectarr);
			}
		})
	};

	//end
	//左侧菜单的选中状态：
	$(".sideMenu>li").click(function(event) {
		$(this).addClass('active').siblings('li').removeClass('active')
	});
	$(".sideMenu>li").find("li").click(function(event) {
		$(this).addClass('active').siblings('li').removeClass('active')
	});

	// top-nav 的选中状态
	$(".top-nav").find('li').click(function(event) {
		$(this).addClass('on').siblings('li').removeClass('on')
	});

	//列表全选
	//列表全选

	///////////////////////////////////
	//全选
	$("#checkAll").click(function() {
		if($("#checkAll").is(":checked")) {
			$(".checkboxbtn input").prop("checked", true);
		} else {
			$(".checkboxbtn input").removeAttr("checked");
		};
	});

	//添加办理单位
/*	$(function() {
		//删除
		$("#tableDate").delegate("td .btn", "click", function() {
			$(this).closest("tr").remove();
		});
		//添加
		$("#addbtn").click(function() {
			var selectval = $('#danweilist option:selected').val();
			var leaderval = $('#leaderval').val();
			var adminval = $('#adminval').val();

			$("#tableDate tbody").append('<tr><td  class="text-center">' + selectval + '</td><td  class="text-center">' + leaderval + '</td><td  class="text-center">' + adminval + '</td><td  class="text-center"><div class="btn btn-default btn-sm del-btn">移除</div></td></tr>')

		})

	});

	//添加办理单位
	$(function() {
		//删除
		$("#tableDate2").delegate("td .btn", "click", function() {
			$(this).closest("tr").remove();
		});
		//添加
		$("#addbtn").click(function() {
			var selectval = $('#danweilist option:selected').val();
			var leaderval = $('#leaderval').val();
			var adminval = $('#adminval').val();

			$("#tableDate2 tbody").append('<tr><td  class="text-center">' + leaderval + '</td><td  class="text-center">' + adminval + '</td><td  class="text-center"><div class="btn btn-default btn-sm del-btn">移除</div></td></tr>')

		})

	});
*/
	//、、、日历插件的调用

	$(function() {
		//日历初始

		// $('.form_datetime').datetimepicker({
		// 	language: 'zh-CN',
		// 	autoclose: true,
		// 	todayHighlight: true,
		// 	format: 'yyyy-mm-dd hh:ii'
		// });
		//表格下委托
		$("#time-table").delegate("td .laydate-icon", "click", function() {
				//委托的日历转中文
				laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})
				
			})
		

		//日历插件精确到天
		//日历初始

		// $('.form_datetime_day').datetimepicker({
		// 	language: 'zh-CN',
		// 	minView: "month",
		// 	autoclose: true,
		// 	todayHighlight: true,
		// 	format: 'yyyy-mm-dd'
		// });

	});
	//、、、日历插件的调用end

		//添加次数
		$(function() {
			var timeNum = $("#time-table").find("tr").length-1;
			$(".add-time").click(function() {
				timeNum++;
				$("#time-table").append('<tr><td><input value='+timeNum+' name="mark_sort['+timeNum+']" style="border:none;" readonly="readonly" class="text-center form-control"/></td><td> <input size="16" type="text" value="" readonly class="form-control laydate-icon" required onClick="laydate({istime: true, format: "YYYY-MM-DD hh:mm:ss"})" name="mark_time['+timeNum+']"/></td></tr>')
			})
		});

		

	
	//、、、日历插件的调用end

})