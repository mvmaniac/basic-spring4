<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="tilesx" uri="http://tiles.apache.org/tags-tiles-extras" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />

    <title><tiles:insertAttribute name="title" /></title>

    <tilesx:useAttribute id="css" name="stylesheet" classname="java.util.List" />
    <c:forEach var="href" items="${css}">
        <link type="text/css" rel="stylesheet" href="<c:url value="${href}"/>"/>
    </c:forEach>
</head>
<body class="hold-transition sidebar-mini">

    <!-- wrapper -->
    <div class="wrapper">

        <!-- navbar -->
        <nav class="main-header navbar navbar-expand bg-white navbar-light border-bottom">
            <tiles:insertAttribute name="header" />
        </nav>
        <!-- // navbar -->

        <!-- main sidebar container -->
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <tiles:insertAttribute name="sidebar" />
        </aside>
        <!-- // main sidebar container -->

        <!-- content wrapper. contains page content -->
        <div class="content-wrapper">
            <tiles:insertAttribute name="content" />
        </div>
        <!-- // content-wrapper -->

        <!-- // footer -->
        <footer class="main-footer">
            <tiles:insertAttribute name="footer" />
        </footer>
        <!-- // footer -->

    </div>
    <!-- // wrapper -->

    <tilesx:useAttribute id="js" name="javascript" classname="java.util.List" />
    <c:forEach var="src" items="${js}">
        <script src="<c:url value="${src}" />"></script>
    </c:forEach>
</body>
</html>
