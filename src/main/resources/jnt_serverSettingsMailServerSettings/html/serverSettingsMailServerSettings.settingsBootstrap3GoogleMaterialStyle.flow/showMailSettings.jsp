<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ page import="org.jahia.settings.SettingsBean" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="mailSettings" type="org.jahia.services.mail.MailSettings"--%>
<%--@elvariable id="flowRequestContext" type="org.springframework.webflow.execution.RequestContext"--%>
<template:addResources type="javascript" resources="jquery.min.js,regexValidation.js"/>

<script type="text/javascript">
    function testSettings() {
        if (document.jahiaAdmin.uri.value.length == 0) {
        <fmt:message key="serverSettings.mailServerSettings.errors.server.mandatory" var="msg"/>
            $.snackbar({
                content: "${functions:escapeJavaScript(msg)}",
                style: "error"
            });
            document.jahiaAdmin.uri.focus();
        } else if (document.jahiaAdmin.to.value.length == 0) {
        <fmt:message key="serverSettings.mailServerSettings.errors.administrator.mandatory" var="msg"/>
            $.snackbar({
                content: "${functions:escapeJavaScript(msg)}",
                style: "error"
            });
            document.jahiaAdmin.to.focus();
        } else if (document.jahiaAdmin.from.value.length == 0) {
        <fmt:message key="serverSettings.mailServerSettings.errors.from.mandatory" var="msg"/>
            $.snackbar({
                content: "${functions:escapeJavaScript(msg)}",
                style: "error"
            });
            document.jahiaAdmin.from.focus();
        } else {
            if (typeof workInProgressOverlay != 'undefined') {
                workInProgressOverlay.start();
            }

            $.ajax({
                url:'${url.context}/cms/notification/testEmail',
                type:'POST',
                dataType:'text',
                cache:false,
                data:{
                    host:document.jahiaAdmin.uri.value,
                    from:document.jahiaAdmin.from.value,
                    to:document.jahiaAdmin.to.value
                },
                success:function (data, textStatus) {
                    if (typeof workInProgressOverlay != 'undefined') {
                        workInProgressOverlay.stop();
                    }
                    if ("success" == textStatus) {
                    <fmt:message key="serverSettings.mailServerSettings.testSettings.success" var="msg"/>
                        $.snackbar({
                            content: "${functions:escapeJavaScript(msg)}"
                        });
                    } else {
                    <fmt:message key="serverSettings.mailServerSettings.testSettings.failure" var="msg"/>
                        $.snackbar({
                            content: "${functions:escapeJavaScript(msg)}",
                            style: "error"
                        });
                    }
                },
                error:function (xhr, textStatus, errorThrown) {
                    if (typeof workInProgressOverlay != 'undefined') {
                        workInProgressOverlay.stop();
                    }
                    <fmt:message key="serverSettings.mailServerSettings.testSettings.failure" var="msg"/>
                    $.snackbar({
                        content: "${functions:escapeJavaScript(msg)}" + "\n" + xhr.status + " " + xhr.statusText + "\n" + xhr.responseText,
                        style: "error"
                    });
                }
            });
        }
    }

    var fieldsToValidate = ["to","from"];
    var academyLink = "<%= SettingsBean.getInstance().getString("mailConfigurationAcademyLink","https://academy.jahia.com/documentation/knowledge-base/configuration-mail-server-in-jahia")%>";
    window.onload = function() { document.getElementById('academyBtn').setAttribute('href',academyLink)};

    function toggleVisibility() {
        var uriEntry = $('#uriEntry');
        var visibilityIcon = $('#visibilityIcon');
        var isPassword = uriEntry.get(0).getAttribute("type") === "password";
            uriEntry.get(0).setAttribute("type", isPassword ? "text" : "password");
        isPassword ? visibilityIcon.html("visibility_off") : visibilityIcon.html("visibility");
    }

    function displayErrors(element) {
        var formGroup = $("#group-"+element);
        $.snackbar({
            content: formGroup.get(0).getAttribute("data-error"),
            style: "error"
        });
        formGroup.addClass('has-error');
    }

    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>

<div class="page-header">
    <h2>
        <fmt:message key="serverSettings.mailServerSettings"/>
    </h2>
</div>

<c:forEach items="${flowRequestContext.messageContext.allMessages}" var="message">
    <c:if test="${message.severity eq 'ERROR'}">
        <div class="alert alert-danger">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
                ${message.text}
        </div>
    </c:if>
</c:forEach>

<c:if test="${settingsUpdated}">
    <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <fmt:message key="label.changeSaved"/>
    </div>
</c:if>
<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <div class="panel panel-default">
            <div class="panel-body">
                <form name="jahiaAdmin" action='${flowExecutionUrl}' method="post">

                    <div class="form-group">
                        <div class="togglebutton">
                            <label for="serviceActivated">
                                <input type="checkbox" name="serviceActivated" id="serviceActivated"<c:if test='${mailSettings.serviceActivated}'> checked="checked"</c:if>/>
                                <fmt:message key="serverSettings.mailServerSettings.serviceEnabled"/>
                            </label>
                        </div>
                        <input type="hidden" name="_serviceActivated"/>
                    </div>

                    <div class="form-group label-floating">
                        <div class="input-group">
                            <label class="control-label">
                                <fmt:message key="serverSettings.mailServerSettings.address"/> <span class="text-danger"><strong>*</strong></span>
                            </label>
                            <input class="form-control" type="password" id="uriEntry" name="uri" size="70" maxlength="250" value="<c:out
                            value='${mailSettings.uri}'/>"/>
                            <span class="input-group-btn">
                                <span onclick="toggleVisibility()" class="btn btn-fab btn-fab-xs btn-default">
                                    <i id="visibilityIcon" class="material-icons">visibility</i>
                                </span>
                            </span>
                            <span class="input-group-btn">
                                <a class="btn btn-fab btn-fab-xs btn-info" id="academyBtn" target="_blank"
                                style="cursor: pointer;">
                                    <i class="material-icons">open_in_new</i>
                                </a>
                            </span>
                        </div>
                    </div>

                    <div class="form-group label-floating" id="group-to" data-error="<fmt:message key="serverSettings.mailServerSettings.errors.emailList"/>">
                        <div class="input-group">
                            <label class="control-label">
                                <fmt:message key="serverSettings.mailServerSettings.administrator"/> <span class="text-danger"><strong>*</strong></span>
                            </label>
                            <input class="form-control" type="text" name="to" size="64" maxlength="250"
                                   value="<c:out value='${mailSettings.to}'/>">
                            <span class="input-group-btn">
                                <i class="material-icons text-info" data-toggle="tooltip" data-placement="left"
                                   title="<fmt:message key='serverSettings.mailServerSettings.administratorTooltip'/>"
                                   style="cursor: default;" data-container="body">info_outline</i>
                            </span>
                        </div>
                    </div>

                    <div class="form-group label-floating" id="group-from" data-error="<fmt:message key="serverSettings.mailServerSettings.errors.email"/>">
                        <label class="control-label">
                            <fmt:message key="serverSettings.mailServerSettings.from"/> <span class="text-danger"><strong>*</strong></span>
                        </label>
                        <input class="form-control" type="text" name="from" size="64" maxlength="250" value="<c:out
                        value='${mailSettings.from}'/>">
                    </div>

                    <div class="form-group label-floating">
                        <label class="control-label">
                            <fmt:message key="serverSettings.mailServerSettings.eventNotificationLevel"/>
                        </label>
                        <select class="form-control" name="notificationLevel">
                            <option value="Disabled" ${mailSettings.notificationLevel == 'Disabled' ? 'selected="selected"' : ''}>
                                <fmt:message key="serverSettings.mailServerSettings.eventNotificationLevel.disabled"/></option>
                            <option value="Standard" ${mailSettings.notificationLevel == 'Standard' ? 'selected="selected"' : ''}>
                                <fmt:message key="serverSettings.mailServerSettings.eventNotificationLevel.standard"/></option>
                            <option value="Wary" ${mailSettings.notificationLevel == 'Wary' ? 'selected="selected"' : ''}>
                                <fmt:message key="serverSettings.mailServerSettings.eventNotificationLevel.wary"/></option>
                            <option value="Paranoid" ${mailSettings.notificationLevel == 'Paranoid' ? 'selected="selected"' : ''}>
                                <fmt:message key="serverSettings.mailServerSettings.eventNotificationLevel.paranoid"/></option>
                        </select>
                    </div>

                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="workflowNotificationsDisabled" ${mailSettings.workflowNotificationsDisabled ?'checked="checked"' : ''}/>
                                <fmt:message key="serverSettings.mailServerSettings.workflowNotificationsDisabled"/>
                            </label>
                        </div>
                        <input type="hidden" name="_workflowNotificationsDisabled"/>
                    </div>

                    <div class="form-group form-group-sm text-right">
                        <button class="btn btn-default" type="button" onclick="testSettings(); return false;">
                            <fmt:message key="serverSettings.mailServerSettings.testSettings"/>
                        </button>
                        <button class="btn btn-raised btn-primary" type="submit" onclick="return validateForm(fieldsToValidate,displayErrors)"
                                name="_eventId_submitMailSettings">
                            <fmt:message key="label.save"/>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
