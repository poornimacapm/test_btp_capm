sap.ui.define([
    "sap/m/MessageToast"
], function (MessageToast) {
    'use strict';

    return {
        /**
         * Generated event handler.
         *
         * @param oEvent the event object provided by the event provider.
         */
        onPress: function (oEvent) {
          //  MessageToast.show("Custom handler ui5 invoked.");

            var oView = this.getView();

            if (!this._oDialog) {
                this._oDialog = sap.ui.xmlfragment(
                    oView.getId(),
                    "pr.ui.managepo.ext.fragment.PR",
                    this
                );
                oView.addDependent(this._oDialog);
            }

            this._oDialog.open();
        },
        onTestAction: function (oEvent) {
              //var oView = this.base.getView();   // ✅ FE way
              debugger;
           // var oSource = oEvent.getSource();
             MessageToast.show("Custom handler ui5 invoked.");
            
        }
    };
});
