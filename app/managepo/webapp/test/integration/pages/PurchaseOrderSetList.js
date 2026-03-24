sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'pr.ui.managepo',
            componentId: 'PurchaseOrderSetList',
            contextPath: '/PurchaseOrderSet'
        },
        CustomPageDefinitions
    );
});