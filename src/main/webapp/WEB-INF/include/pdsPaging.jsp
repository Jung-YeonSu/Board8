<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="startNum" value="${searchVo.pagination.startPage}"/>
<c:set var="endNum" value="${searchVo.pagination.endPage}"/>
<c:set var="totalpagecount" value="${searchVo.pagination.totalPageCount}"/>
<div id="paging">
	<table>
		<tr>
		<c:if test="${startNum ne 1 }">
			<td>
				<a href="/Pds/List?menu_id=${map.menu_id}&nowpage=1&search=${map.search}&searchtext=${map.searchtext}">⏮</a>
				<a href="/Pds/List?menu_id=${map.menu_id}&nowpage=${startNum-1}&search=${map.search}&searchtext=${map.searchtext}">◀</a>
			</td>		
		</c:if>
			<c:forEach var="pagenum" begin="${startNum}" end="${endNum}" step="1">
				<td>
					<a href="/Pds/List?menu_id=${map.menu_id}&nowpage=${pagenum}&search=${map.search}&searchtext=${map.searchtext}">${pagenum}</a>
				</td>
			</c:forEach>
			<!-- 다음 / 마지막 -->
			<c:if test="${endNum ne totalpagecount }">			
			<td>
				<a href="/Pds/List?menu_id=${map.menu_id}&nowpage=${endNum+1}&search=${map.search}&searchtext=${map.searchtext}">▶</a>
				<a href="/Pds/List?menu_id=${map.menu_id}&nowpage=${totalpagecount}&search=${map.search}&searchtext=${map.searchtext}">⏭</a>
			</td>
			</c:if> 
		</tr>
	</table>   
</div>