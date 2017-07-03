<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
	.box{
		width: 1000px;
		margin: 0 auto;
		text-align: center;
	}
	i{
	display: inline-block;
	}
	
	span{
		cursor: pointer;
		font-weight: bold;
		font-size: 16px;
		margin : 0 10px;
	}
	
	.paging{
		margin : 20px auto;
	}
	
	.search{
		width: 150px;
	}
</style>
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
	
		 var page="${board}";
	
		$("#write").click(function(){
			location.href="./"+page+"Write";
		});
		
		$("#home").click(function(){
			location.href="../";
		});
	/* 	
		$(".go").click(function(){
			var curPage=$(this).attr("id");
			location.href="./"+page+"List?curPage="+curPage+"&kind=${kind}&search=${search}";
		});  */
		
		
		//user 메뉴
		$(".w3-container").on("click","#userMenu",function(){
			var f_id=$(this).val();
			alert(f_id);
			
			 var message ="#m"+f_id;
			var fAdd="#a"+f_id;
			var fDel="#d"+f_id;
			
		//메세지 보내기
			$(message).click(function() {
				$("#to_id").val(f_id);
			})
			
			 
			//친구 추가
			$(fAdd).click(function() {
				 var r = confirm("친구추가 하시겠습니까?");
				    if (r == true) {
				       location.href="../friend/friendAdd?f_id="+f_id;
				    } else {
				    	location.href="../";
				 	}
			})
			
			$(fDel).click(function() {
				var r = confirm("친구삭제 하시겠습니까?");
				    if (r == true) {
				       location.href="../friend/friendDel?f_id="+f_id;
				    } else {
				    	location.href="../";
				    }
			}) 
			
			
		});
});
</script>

</head>
<body>
	<%@ include file="../sub/header.jspf"%>
	<div class="box">
	<h2>${board} List</h2>
	<table id="Mtable" class="table table-hover">
		<tr>
			<td>번호</td><td>제목</td><td>작성자</td><td>작성일자</td><td>조회수</td>
		</tr>
		<c:forEach items="${list}" var="f">
			<tr>
				<td >${f.num }</td>
				<td style="width: 500px; text-align: left;">
				<c:catch var="e">
					<c:forEach begin="1" end="${f.depth}">
						ㄴ
					</c:forEach>
				</c:catch>
				
				<a href="${board}View?num=${f.num}&pnum=${f.num}&m_id=${member.id}&kind=${f.kind}">${f.title}</a>
				</td>
				

<!-- id메뉴 -->				
<td class="w3-container" >
	<span id="mSpan" class="dropdown">
	<input id="userMenu" class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown" value="${f.m_id}">
	
	<span class="dropdown-menu" >
      <i><a href="#" id="a${f.m_id}" class="w3-bar-item w3-button">친구추가</a></i>
      <i><a href="#" id="d${f.m_id}" class="w3-bar-item w3-button">친구삭제</a></i>
      <i><a href="#" id="m${f.m_id}" class="w3-bar-item w3-button" data-toggle="modal" data-target="#myMemo">쪽지</a></i>
     </span>
		 
	</span>
				
</td>
				<td>${f.reg_date }</td>
				<td>${f.hit }</td>
			</tr>
		</c:forEach>
	</table>
	
<!-- MODAL 쪽지기능 처리  -->
<div class="modal fade" id="myMemo" role="dialog">
    <div class="modal-dialog">
   	<!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">쪽 지 </h4>
        </div>
        <div class="modal-body">
          <form action="../message/messageSend" method="post">
         	<p>보내는 사람<input type="text" name="from_id" value="${member.id}" readonly="readonly"></p>
			<p>받는 사람<input type="text" name="to_id" id="to_id" readonly="readonly"></p>
			<p>제목:<input type="text" name="title">
			<p><textarea rows="10" cols="40" name="contents"></textarea></p>
			<p><button class="btn btn-default">작성</button> </p>			          
          </form>
         <button type="button" id="mClose" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
        <div class="modal-footer">
        </div>
      </div>
      
    </div>
  </div>
	
<!-- MODAL 쪽지기능 끝 -->	
	
	

	<!--검색  -->
	
	<div class="search">
		<form action="${board}List">
			<select name="kind" class="form-control">
				<option value="title">제목으로 검색</option>
				<option value="contents">내용으로 검색</option>
				<option value="writer">작성자로 검색</option>
			</select>
			<input type="hidden" name="curPage" value="${curPage}">
			<input type="text" class="form-control" name="search" placeholder="검색">
			<button class="btn btn-info">검색</button>
		</form>
	</div>
	
	<div class="paging">
		<c:if test="${pageResult.curBlock>1}">
			<span class="go" id="${pageResult.startNum-1}">[이전]</span>
		</c:if>
		<c:forEach begin="${pageResult.startNum}" end="${pageResult.lastNum}" var="i">
			<span class="go" id="${i}">${i}</span>
		</c:forEach>
		<c:if test="${pageResult.curBlock<pageResult.totalBlock}">
			<span class="go" id="${pageResult.lastNum+1}">[다음]</span>
		</c:if>
	</div>
	
	<c:if test="${board == 'wish' && member.id == 'manager'}">
	<input type="button" class="btn btn-info" value="글쓰기" id="write">
	</c:if>
	
	<c:if test="${board == 'review' && member.id ne null}">
	<input type="button" class="btn btn-info" value="글쓰기" id="write">
	</c:if>
	
	<input type="button" class="btn btn-success" value="홈으로" id="home">
	</div>
		<%@ include file="../sub/footer.jspf"%>
</body>
</html>