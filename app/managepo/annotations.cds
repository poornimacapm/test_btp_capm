using CatalogService as service from '../../srv/CatalogService';

annotate  service.PurchaseOrderSet  with  @( 
//Add fielsd sto screen for filtering daya 
UI.SelectionFields  :

[ 
    po_id,partner_guid.company_name , partner_guid.address_guid.country ,
    gross_amount,overall_status

],

//Add columns to table data 
UI.LineItem :[

{
   $Type : 'UI.DataField',Value :po_id ,
} ,

 
{
   $Type : 'UI.DataField',Value :partner_guid.company_name,
} ,
{
   $Type : 'UI.DataField',Value :partner_guid.address_guid.country ,
} ,
{
   $Type : 'UI.DataField',Value :gross_amount ,
} ,

{   $Type :  'UI.DataFieldForAction',
    Action : 'CatalogService.boost',
    Label : 'boost' ,
    Inline : true // every line this column button to be shown 

},
{
   $Type : 'UI.DataField',Value :overall_status , Criticality : colorcode, }

] ,

UI.HeaderInfo : 
{
   //Main page title
TypeName  : 'Purchase Order',
TypeNamePlural : 'Purchase Orders ' ,

//sec screen 
Title : { Value : po_id},
Description :{Value : partner_guid.company_name},
ImageUrl :'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRHyMoHnBTCs2QixP1OV0kNIjJNBcsJjPwe6oVV6Lq4g&s'

},
UI.Facets :[
{
    $Type : 'UI.CollectionFacet',
    Label : 'General Information',
    Facets : [

      {  Label : 'Basic Info' ,$Type : 'UI.ReferenceFacet', Target : '@UI.Identification'} ,
      {Label : 'Pricing Details' ,$Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#FieldgroupId1'} ,
      { Label : 'Additional Info'  ,$Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#FieldgroupId2'} 
     

    ] ,
},

 { Label : 'Items' ,$Type : 'UI.ReferenceFacet', Target : 'Items/@UI.LineItem' }

] , 
UI.Identification :
[
  { $Type : 'UI.DataField' ,Value  : po_id ,  },
  { $Type : 'UI.DataField' ,Value  : partner_guid_node_key,  },
  { $Type : 'UI.DataField' ,Value  : lifecycle_status ,  }
] ,
UI.FieldGroup #FieldgroupId1 :{
Data : [
   { $type : UI.DataField ,Value : gross_amount } ,
    { $type : UI.DataField ,Value : net_amount } ,
     { $type : UI.DataField ,Value : tax_amount } ,
]
} , 
UI.FieldGroup #FieldgroupId2 :{
Data : [
   { $type : UI.DataField ,Value : currency_code } ,
    { $type : UI.DataField ,Value : overall_status } ,
     { $type : UI.DataField ,Value : lifecycle_status } ,

]
} , 

);


annotate service.PurchaseItemSet with  @(

UI.HeaderInfo :{
   //Main page title
TypeName  : 'PO Item',
TypeNamePlural : 'Purchase Order Items ' ,

//sec screen 
Title : { Value : po_item_pos},
Description :{Value :  product_guid.description},
 

},
UI.Facets :[
{
   $Type : 'UI.ReferenceFacet',
   Target : '@UI.Identification',
   Label : 'Item Details' ,
}

] ,

UI.Identification :
[
  {$Type : 'UI.DataField' ,Value : po_item_pos} ,
  {$Type : 'UI.DataField' ,Value : product_guid_node_key} ,
  {$Type : 'UI.DataField' ,Value : gross_amount} ,

],
UI.LineItem :[

{
   $Type : 'UI.DataField',Value :  po_item_pos,
} ,

{
   $Type : 'UI.DataField',Value : product_guid_node_key ,
} ,

{
   $Type : 'UI.DataField',Value :   gross_amount,
} ,

{
   $Type : 'UI.DataField',Value :   net_amount,
} ,

{
   $Type : 'UI.DataField',Value :   tax_amount,
} 
]


);

annotate service.PurchaseOrderSet with 
{
 @(
    Common.Text:OverallStatus,
    Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'StatusCode',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : overall_status,
                ValueListProperty : 'code',
            },
        ],
        Label : 'Status',
    },
    Common.ValueListWithFixedValues : true,
)
  overall_status ;
  @Common.Text:note
  po_id ;
  @Common.Text :  partner_guid.company_name
  @Common : {TextArrangement :   #TextOnly}
  @ValueList.entity : service.BusinessPartnerSet 
  
  partner_guid ;
} ;

annotate service.PurchaseItemSet with 
{
 @Common.Text: product_guid.description
 @ValueList.entity : service.ProductSet
  product_guid ;
} ;

//Value help
@cds.odata.valuelist
annotate  service.BusinessPartnerSet with @(
UI.Identification :[
   { $Type : 'UI.DataField' , Value : company_name }
]
);

@cds.odata.valuelist
annotate  service.ProductSet with @(
UI.Identification :[
   { $Type : 'UI.DataField' , Value :  description }
]
);




annotate service.StatusCode with {
    code @Common.Text : value
};

