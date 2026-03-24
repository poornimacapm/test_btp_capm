sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'pr.ui.managepo',
            componentId: 'PurchaseOrderSetObjectPage',
            contextPath: '/PurchaseOrderSet'
        },
        CustomPageDefinitions
    );
});