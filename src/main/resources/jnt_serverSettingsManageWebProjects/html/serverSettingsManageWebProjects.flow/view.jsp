<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>

<jcr:node var="sites" path="/sites"/>

<form action="${flowExecutionUrl}" method="POST">

    <div>
        <div><fmt:message key="label.virtualSitesManagement"/></div>
        <input type="submit" name="_eventId_createSite"
               value="<fmt:message key='serverSettings.manageWebProjects.createWebProject' />" onclick=""/>
        <input type="submit" name="_eventId_exportSites"
               value="<fmt:message key='serverSettings.manageWebProjects.export' />" onclick=""/>
        <input type="submit" name="_eventId_exportStagingSites"
               value="<fmt:message key='serverSettings.manageWebProjects.exportStaging' />" onclick=""/>
        <input type="submit" name="_eventId_deleteSites"
               value="<fmt:message key='serverSettings.manageWebProjects.delete' />" onclick=""/>
    </div>

    <div>
        <div><fmt:message key="org.jahia.admin.site.ManageSites.virtualSitesListe.label"/></div>
        <table>

            <tr>
                <th>
                </th>
                <th>
                    <fmt:message key="serverSettings.manageWebProjects.webProject.title"/>
                </th>
                <th>
                    <fmt:message key="serverSettings.manageWebProjects.webProject.siteKey"/>
                </th>
                <th>
                    <fmt:message key="serverSettings.manageWebProjects.webProject.serverName"/>
                </th>
                <th>
                    <fmt:message key="serverSettings.manageWebProjects.webProject.selectTemplateSet"/>
                </th>
                <th>

                </th>
            </tr>

            <input name="_sites" type="hidden"/>
            <c:forEach items="${jcr:getChildrenOfType(sites,'jnt:virtualsite')}" var="site">
                <c:if test="${site.name ne 'systemsite'}">
                    <tr>
                        <td><input name="sites" type="checkbox" value="${site.name}"/></td>
                        <td>${site.title}</td>
                        <td>${site.name}</td>
                        <td>${site.serverName}</td>
                        <td>${site.templateFolder}</td>
                    </tr>
                </c:if>
            </c:forEach>

        </table>
    </div>
    <hr/>
    <div>
        <div>System site</div>

        <input type="submit" name="_eventId_exportSystemSite"
               value="<fmt:message key='serverSettings.manageWebProjects.export' />" onclick=""/>
        <input type="submit" name="_eventId_exportStagingSystemSite"
               value="<fmt:message key='serverSettings.manageWebProjects.exportStaging' />" onclick=""/>

    </div>
    <hr/>
    <div>
        <div><fmt:message key="org.jahia.admin.site.ManageSites.importprepackaged.label"/></div>
        <select name="selectedPrepackagedSite">
            <c:forEach items="${webprojectHandler.prepackagedSites}" var="file">
                <fmt:message key="org.jahia.admin.site.ManageSites.importprepackaged.${file.name}" var="label"/>
                <c:set var="label" value="${fn:contains(label, '???') ? file.name : label}"/>
                <option value="${file.name}">${fn:escapeXml(label)}</option>
            </c:forEach>
        </select>

        <input type="submit" name="_eventId_importPrepackaged"
               value="<fmt:message key='org.jahia.admin.site.ManageSites.importprepackaged.proceed' />" onclick=""/>

    </div>
    <hr/>
    <div>
        <div><fmt:message key="org.jahia.admin.site.ManageSites.multipleimport.label"/></div>
        <div>
            <fmt:message key="org.jahia.admin.site.ManageSites.multipleimport.fileselect"/> <input type="file" name="importFile"/>
        </div>
        <div>
            <fmt:message key="org.jahia.admin.site.ManageSites.multipleimport.fileinput"/> <input name="importPath"/>
        </div>

        <input type="submit" name="_eventId_import"
               value="<fmt:message key="org.jahia.admin.site.ManageSites.fileImport.label"/>" onclick=""/>
    </div>
    <hr/>

</form>