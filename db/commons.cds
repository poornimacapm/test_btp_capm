namespace pr.common; 
using {Currency} from '@sap/cds/common';

type Guid:  String(32);


type Gender:String(1) enum {

    male = 'M';
    female = 'F';
    undisclosed ='U';
}

type AmountT : Decimal(10,2) @(
Semantic.amount.currencyCode :'CURRENCY_code'
);

//custom aspect 
aspect Amount{
currency: Currency @(title: '{i18n>currency}');
gross_amount : AmountT @(title: '{i18n>grossamount}');
net_amount : AmountT @(title: '{i18n>netamount}');
tax_amount :AmountT @(title: '{i18n>taxamount}');

}

type PhoneNumber : String(30)@assert.format : '^[6-9]\d{9}$';
type Email : String(250) 
    @assert.format: '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';