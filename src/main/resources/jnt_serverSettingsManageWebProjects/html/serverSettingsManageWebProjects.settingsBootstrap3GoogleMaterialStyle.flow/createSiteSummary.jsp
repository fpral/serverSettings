<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<template:addResources type="javascript" resources="jquery.min.js,jquery.blockUI.js,workInProgress.js"/>
<fmt:message key="label.workInProgressTitle" var="i18nWaiting"/><c:set var="i18nWaiting" value="${functions:escapeJavaScript(i18nWaiting)}"/>
<template:addResources>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#${currentNode.identifier}-next').click(function() {workInProgress('${i18nWaiting}');});
        });
    </script>
</template:addResources>

<div class="page-header">
    <h2><fmt:message key="serverSettings.manageWebProjects.createWebProject"/></h2>
</div>

<form action="${flowExecutionUrl}" method="POST">
    <div class="panel panel-default">
        <div class="panel-body">
            <table class="table table-no-border">
                <tbody>
                    <tr>
                        <td style="width: 30%">
                            <strong><fmt:message key="serverSettings.manageWebProjects.webProject.siteKey"/></strong>
                        </td>
                        <td style="width: 70%">
                            ${siteBean.siteKey}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="label.name"/></strong>&nbsp;
                        </td>
                        <td>
                            ${fn:escapeXml(siteBean.title)}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="serverSettings.manageWebProjects.webProject.serverName"/></strong>&nbsp;
                        </td>
                        <td>
                            ${fn:escapeXml(siteBean.serverName)}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="serverSettings.manageWebProjects.webProject.serverNameAliases"/></strong>&nbsp;
                        </td>
                        <td>
                            ${fn:escapeXml(siteBean.serverNameAliases)}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="label.description"/></strong>&nbsp;
                        </td>
                        <td>
                            ${fn:escapeXml(siteBean.description)}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="serverSettings.manageWebProjects.webProject.defaultSite"/></strong>&nbsp;
                        </td>
                        <td>
                            ${siteBean.defaultSite}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="serverSettings.manageWebProjects.webProject.templateSet"/></strong>&nbsp;
                        </td>
                        <td>
                            ${siteBean.templateSetPackage.name}&nbsp;(${siteBean.templateSet})
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="label.modules"/></strong>&nbsp;
                        </td>
                        <td>
                            <p style="line-height: 2em">
                                <c:forEach items="${siteBean.modulePackages}" var="module" varStatus="loopStatus">
                                    <span class="label label-info">${module.name}</span>
                                </c:forEach>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong><fmt:message key="serverSettings.manageWebProjects.webProject.language"/>:&nbsp;
                        </td>
                        <td>
                            ${siteBean.language}
                        </td>
                    </tr>

                </tbody>
            </table>

            <button class="btn btn-primary btn-raised pull-right" type="submit" name="_eventId_next" id="${currentNode.identifier}-next">
                <fmt:message key='label.save'/>
            </button>
            <button class="btn btn-default pull-right" type="submit" name="_eventId_previous">
                <fmt:message key='label.previous'/>
            </button>
        </div>
    </div>
</form>
