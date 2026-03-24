const cds = require('@sap/cds')

module.exports = class CatalogService extends cds.ApplicationService { init() {

  const { EmployeeSet, ProductSet, BusinessPartnerSet, AddressSet, PurchaseOrderSet, PurchaseItemSet } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], EmployeeSet, async (req) => {

    let sal = parseFloat(req.data.salaryAmount);
    if (sal > 1000000)

      {
        req.error(500,"No one get salary greater tha one million!");
        
      }
    
    console.log('Before CREATE/UPDATE EmployeeSet', req.data)
  })
  this.after ('READ', EmployeeSet, async (employeeSet, req) => {
    console.log('After READ EmployeeSet', employeeSet)
  })
  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
   
    //console.log('After READ ProductSet', productSet)
  })
  this.before (['CREATE', 'UPDATE'], BusinessPartnerSet, async (req) => {
    console.log('Before CREATE/UPDATE BusinessPartnerSet', req.data)
  })
  this.after ('READ', BusinessPartnerSet, async (businessPartnerSet, req) => {
    console.log('After READ BusinessPartnerSet', businessPartnerSet)
  })
  this.before (['CREATE', 'UPDATE'], AddressSet, async (req) => {
    console.log('Before CREATE/UPDATE AddressSet', req.data)
  })
  this.after ('READ', AddressSet, async (addressSet, req) => {
    console.log('After READ AddressSet', addressSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
  })
  this.after ('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {
   
    console.log('After READ PurchaseOrderSet', purchaseOrderSet)
    for( let index = 0 ; index < purchaseOrderSet.length ; index++)
    {
      const element = purchaseOrderSet[index];
      if(!element.note)
      { element.note  =   'Not Found';   }
      
    }

  })
  this.before (['CREATE', 'UPDATE'], PurchaseItemSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseItemSet', req.data)
  })
  this.after ('READ', PurchaseItemSet, async (purchaseItemSet, req) => {
    console.log('After READ PurchaseItemSet', purchaseItemSet)
  })


  this.on('getDefault', async (req,res) =>
  {
  return { 
    overall_status: 'N',
    lifecycle_status: 'N'    
  } 
  });


  this.on('getLargestOrder',async(req,res) =>
  {
  try{
     
     const tx = cds.tx(req);
     const reply = await tx.read(PurchaseOrderSet).orderBy(

      { 'gross_amount' : 'desc' }
     ).limit(3);

     return reply ; 
   }


  catch (error) {

     req.error(500,"Some error occured :",error,toString());
  }

  });

 this.on('boost',async(req) =>
  
    {

      try{
        const PRIMARYKEY = req.params[0];
        const tx = cds.tx(req);
        await tx.update(PurchaseOrderSet).with(
         {
          gross_amount : { '+=' : 2000},
          note: 'Boosted!!'

         }

        ).where(PRIMARYKEY);
      
      return await tx.read(PurchaseOrderSet).where(PRIMARYKEY);

       }
  
    catch(error)
    {

    }



    }   
  );
  return super.init()
}}
