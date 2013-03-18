<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<div>
    <span style="font-size: larger;"><fmt:message key="label.password.policies"/></span>

    <div>
        <form action='${flowExecutionUrl}' method="post">
            <table border="0" cellpadding="5" cellspacing="0" width="100%">
                <thead>
                <tr>
                    <th width="7%">
                        <fmt:message key="org.jahia.admin.passwordPolicies.active.label"/>
                    </th>
                    <th width="50%">
                        <fmt:message key="label.name"/>
                    </th>
                    <th width="43%">
                        <fmt:message key="label.parameters"/>
                    </th>
                </tr>
                </thead>
                <c:forEach items="${jahiaPasswordPolicy.rules}" var="rule" varStatus="rlzStatus">
                    <tr>
                        <td align="center">
                            <input type="checkbox" name="rules[<c:out value='${rlzStatus.index}'/>].active"
                            <c:if test="${rule.active}">
                                checked="checked"
                            </c:if>
                            value="true"/>
                            <input type="hidden" name="_rules[<c:out value='${rlzStatus.index}'/>].active"/>
                        </td>
                        <c:set var="i18nKey" value='org.jahia.admin.passwordPolicies.rule.${rule.name}'/>
                        <td>
                            <fmt:message key='${i18nKey}'/>
                        </td>
                        <td>
                            <table width="100%">
                                <c:forEach items="${rule.conditionParameters}" var="condParam" varStatus="paramsStatus">
                                    <tr>
                                        <c:set var="i18nKey" value='label.${condParam.name}'/>
                                        <td width="45%" align="right">
                                            <label for="rules_${paramsStatus.count}"><fmt:message key='${i18nKey}'/></label>
                                        </td>
                                        <td width="55%">
                                            <input type="text" id="rules_${paramsStatus.count}" name="rules[<c:out value='${rlzStatus.index}'/>].conditionParameters[<c:out value='${paramsStatus.index}'/>].value" value="<c:out value='${condParam.value}'/>"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <input type="submit" name="_eventId_submitPwdPolicy" value="<fmt:message key="org.jahia.admin.saveChanges.label"/>"/>
        </form>
    </div>
</div>