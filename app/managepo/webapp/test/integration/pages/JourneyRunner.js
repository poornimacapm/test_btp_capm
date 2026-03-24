sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"pr/ui/managepo/test/integration/pages/PurchaseOrderSetList",
	"pr/ui/managepo/test/integration/pages/PurchaseOrderSetObjectPage",
	"pr/ui/managepo/test/integration/pages/PurchaseItemSetObjectPage"
], function (JourneyRunner, PurchaseOrderSetList, PurchaseOrderSetObjectPage, PurchaseItemSetObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('pr/ui/managepo') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetList: PurchaseOrderSetList,
			onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
			onThePurchaseItemSetObjectPage: PurchaseItemSetObjectPage
        },
        async: true
    });

    return runner;
});

