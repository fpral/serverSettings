import React from 'react';
import {registry} from '@jahia/ui-extender';
import Groups from '@jahia/moonstone/dist/icons/Group';

export const registerRoutes = function () {
    registry.add('adminRoute', 'usersAndRoles', {
        targets: ['administration-server:4'],
        icon: <Groups/>,
        label: 'serverSettings:usersAndRoles.label',
        isSelectable: false
    });

    registry.add('adminRoute', 'adminProperties', {
        targets: ['administration-server-usersAndRoles:0'],
        requiredPermission: 'adminRootUser',
        icon: null,
        label: 'serverSettings:usersAndRoles.adminProperties',
        isSelectable: true,
        iframeUrl: window.contextJsParameters.contextPath + '/cms/adminframe/default/en/settings.adminProperties.html?redirect=false'
    });

    registry.add('adminRoute', 'passwordPolicy', {
        targets: ['administration-server-usersAndRoles:5'],
        requiredPermission: 'adminPasswordPolicy',
        icon: null,
        label: 'serverSettings:usersAndRoles.passwordPolicy',
        isSelectable: true,
        iframeUrl: window.contextJsParameters.contextPath + '/cms/adminframe/default/en/settings.passwordPolicy.html?redirect=false'
    });

    registry.add('adminRoute', 'manageServerRoles', {
        targets: ['administration-server-usersAndRoles:2'],
        requiredPermission: 'adminServerRoles',
        icon: null,
        label: 'serverSettings:usersAndRoles.serverRoles',
        isSelectable: true,
        iframeUrl: window.contextJsParameters.contextPath + '/cms/adminframe/default/en/settings.manageServerRoles.html?redirect=false'
    });
};
