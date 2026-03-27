
using{ pr.db.master ,pr.db.transaction} from '../db/datamodel' ; //added changes 

service CatalogService @(path : 'CatalogService', requires : 'authenticated-user')
{
  entity EmployeeSet @( 
                       odata.draft.enabled : true ,
                        restrict :[  { grant : ['READ']  , to : 'Viewer' , where : 'bankName = $user.spiderman' },
                                           { grant : ['WRITE', 'DELETE']  , to : 'Editor'}      

                                        ],
                                          ) as projection on master.employee ;
  entity ProductSet as projection on master.product ;
  entity BusinessPartnerSet  as projection on master.businesspartner;
  entity AddressSet as projection on master.address ; 
  @readonly
  entity StatusCode as projection on master.statusCode;

  entity  PurchaseOrderSet @( 
    restrict :[  { grant : ['READ']  , to : 'Viewer'} ,
                                           { grant : ['WRITE', 'DELETE']  , to : 'Editor'}      
  
                                        ],
                              Common.DefaultValuesFunction : 'getDefault' )   as projection on transaction.purchaseorder
  { *,
    // CDS expression language 
  
    case overall_status 
      when 'P' then 'Pending'
      when 'A' then 'Approved'
      when  'X' then 'Rejected'
      when 'D' then 'Delivered'
      else 'Unknown' 

       end as OverallStatus : String(30) ,

       case overall_status 
      when 'P' then 2
      when 'A' then 3
      when  'X' then 1
      when 'D' then 3
      
      else 0

       end as colorcode : Integer 


  }
  actions{
    //side effects 
    //store the record in a privste variable 
    @cds.odata.bindingparameter.name: '_bindvar' 
    @Common.SideEffects :{

      TargetProperties :['_bindvar/gross_amount']
    }
     action boost() returns PurchaseOrderSet ;

  };
  entity PurchaseItemSet as projection on transaction.poitems;

  function getLargestOrder() returns array of  PurchaseOrderSet;
  function getDefault() returns PurchaseOrderSet ;

}