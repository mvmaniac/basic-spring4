<%--suppress XmlPathReference --%>

<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- left navbar links -->
<ul class="navbar-nav">
    <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#"><i class="fa fa-bars"></i></a>
    </li>
    <li class="nav-item d-none d-sm-inline-block">
        <a href="<c:url value="/" />" class="nav-link">Home</a>
    </li>
    <li class="nav-item d-none d-sm-inline-block">
        <a href="<c:url value="/board/listAll" />" class="nav-link">Board</a>
    </li>
</ul>

<!-- search form -->
<form class="form-inline ml-3">
    <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
        <div class="input-group-append">
            <button class="btn btn-navbar" type="submit">
                <i class="fa fa-search"></i>
            </button>
        </div>
    </div>
</form>

<!-- right navbar links -->
<ul class="navbar-nav ml-auto">
    <li class="nav-item"></li>
</ul>