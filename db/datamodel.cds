namespace pr.db ; 

using { pr.common as common } from './commons';
using{ Currency,cuid } from '@sap/cds/common';


context master { 
    
    entity businesspartner { 

        key node_key : common.Guid @(title: '{i18n>partnerkey}');
        bp_role :String(2);
        email_address:String(125);
        phone_number: String(32); 
        fax_number : String(32);
        web_address:String(44);
        company_name:String(250) @(title: '{i18n>company}');
        bp_id:String(32)@(title: '{i18n>partnerid}');
        address_guid : Association to one address ; 
    }

    entity address { 

        key node_key:common.Guid;
        city: String(44);
        postal_code : String(8);
        street: String(44);
        building:String(128);
        country:String(44) @(title: '{i18n>country}');
        address_type:String(44);  
        val_start_date : Date;
        val_end_date : Date;
        latitude : Decimal ; 
        longitude : Decimal ; 
        businesspartner : Association to  businesspartner on businesspartner.address_guid = $self;
        
      }
    entity employee : cuid {
        
            nameFirst : String(256);
            nameMiddle : String(256);
            nameLast : String(256);
            nameInitials : String(44);            
            sex: common.Gender;
            language : String(1);
            phoneNumber:common.PhoneNumber;
            email:common.Email;
            loginName:String(12);
            Currency: Currency ;
            salaryAmount: common.AmountT ;
            accountNumber:String(16);
            bankId:String(40);
            bankName:String(64); 

    }

    entity product {
        key node_key:common.Guid @(title: '{i18n>productkey}');
        product_id:String(28)@(title: '{i18n>productid}');
        type_code: String(2);
        category:String(32);
        description: localized String(255)@(title: '{i18n>desc}');
        supplier_guid:Association to one master.businesspartner ;
        tax_tarif_code: Integer;
        measure_unit:String(2);
        weight_measure:  Decimal(5,2);
        weight_unit:String(2);
        currency_code:String(4);
        price:Decimal(15,2);
        width : Decimal(15,2);
        depth:Decimal(15,2);
        height:Decimal(15,2);
        dim_unit:String(2); 

    }

    entity statusCode{

        key code:String(1);
        value : String(10);
    }

}

context transaction {
    
    entity purchaseorder : common.Amount , cuid
    {
       // key node_key :common.Guid @(title: '{i18n>pokey}');
        po_id :String(32)@(title: '{i18n>po_id}');
        partner_guid: Association to one master.businesspartner @(title: '{i18n>partnerid}');
        currency: Currency @(title: '{i18n>currency}');
        lifecycle_status : String(1)@(title: '{i18n>overallstatus}'); 
        overall_status:String(1)@(title: '{i18n>overallstatus}');
        note: String(100) @(title: '{i18n>note}');
        Items: Composition of   many poitems on Items.parent_key = $self;
    }

     entity poitems : common.Amount, cuid
    {
        //key node_key :common.Guid @(title: '{i18n>poitemkey}');
        parent_key : Association to purchaseorder @(title: '{i18n>productkey}');
        product_guid: Association to master.product @(title: '{i18n>productid}');
        po_item_pos : Integer @(title: '{i18n>poitempos}'); 
       
    }

     
}