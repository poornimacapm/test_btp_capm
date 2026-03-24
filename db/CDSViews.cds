namespace pr.cds;

using {
    pr.db.master      as master,
    pr.db.transaction as transaction
} from './datamodel';

context CDSViews {

    define view ![POWorkList] as
        select from transaction.purchaseorder

        {
            key po_id                             as ![PurchaseOrderId],
            key Items.po_item_pos                 as ![ItemPosition],
                partner_guid.bp_id                as ![PartnerId],
                partner_guid.company_name         as ![CompanyName],
                gross_amount                      as ![GrossAmount],
                net_amount                        as ![NetAmount],
                tax_amount                        as ![TaxAmount],
                currency                          as ![Currencycode],
                overall_status                    as ![OverallStatus],
                Items.product_guid.product_id     as ![ProductId],
                Items.product_guid.description    as ![Description],
                partner_guid.address_guid.city    as ![City],
                partner_guid.address_guid.country as ![Country]

        };

    define view ![ProductValueHelp] as
        select from master.product {
            @EndUserText.Label: [

                {
                    language: 'EN',
                    text    : ' Product Id'
                },
                {
                    language: 'DE',
                    text    : 'Prodkt Id'

                }

            ]
            product_id  as ![ProductId],
            @EndUserText.Label: [

                {
                    language: 'EN',
                    text    : ' Product Description'
                },
                {
                    language: 'DE',
                    text    : 'Prodkt Descripion'

                }

            ]
            description as ![Description]

        };

    define view ![ItemView] as
        select from transaction.poitems {
           key parent_key.partner_guid.node_key as ![CustomerId],
            key product_guid.node_key            as ![ProductId],
            currency                         as ![CurrencyCode],
            gross_amount                     as ![GrossAmount],
            net_amount                       as ![NetAmount],
            tax_amount                       as ![TaxAmount],
            parent_key.overall_status        as ![OverallStatus]

        };

    define view ![ProductView] as
        select from master.product
        mixin {
            PO_ORDER : Association to many ItemView
                           on PO_ORDER.ProductId = $projection.ProductId

        }
        into {
            node_key                           as ![ProductId],
            description                        as ![Description],
            category                           as ![Category],
            price                              as ![Price],
            supplier_guid.bp_id                as ![SupplierId],
            supplier_guid.company_name         as ![CompanyName],
            supplier_guid.address_guid.country as ![Country],

            //Exposed associations on demand at run time
            PO_ORDER                           as ![ToItems]

        };

        define view ![CProductValuesView] as 
        select from ProductView {
          ProductId ,
          Country ,
          round( sum ( ToItems.GrossAmount ) , 2 ) as ![TotalAmount],
          ToItems.CurrencyCode as ![CurrencyCode]

        } group by ProductId,Country,ToItems.CurrencyCode 


}
