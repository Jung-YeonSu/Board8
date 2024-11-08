<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul id="menu">
	<li>
		<a href="/Pds/List?menu_id=all&nowpage=1">ALL</a>
	</li>
	
	<c:forEach var="menu" items="${menuList}">
		<li>
			<a href="/Pds/List?menu_id=${menu.menu_id}&nowpage=1">${menu.menu_name}</a>
		</li>
	</c:forEach>
</ul>