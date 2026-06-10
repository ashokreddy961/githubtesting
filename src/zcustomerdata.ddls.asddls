@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For Customer Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}@ObjectModel: {
modelingPattern: #ANALYTICAL_DIMENSION,
    supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE]
    }
define view entity ZCUSTOMERDATA as select from I_Customer as Cu
left outer join I_BusinessPartner as BP on BP.BusinessPartner = Cu.Customer
left outer join I_BusinessUserBasic as User on User.UserID = BP.CreatedByUser
left outer join I_BusinessPartnerBank as Bank on Bank.BusinessPartner = BP.BusinessPartner
left outer join I_BusinessPartnerGroupingText as bpt on bpt.BusinessPartnerGrouping = BP.BusinessPartnerGrouping
and bpt.Language ='E'
left outer join I_BusinessPartnerLegalFormText as lf on lf.LegalForm = BP.LegalForm
and lf.Language ='E'
left outer join I_CustomerCompany as CC on CC.Customer = Cu.Customer
left outer join I_CustomerSalesArea as csa on csa.Customer = Cu.Customer
left outer join I_CustomerGroupText as cag on cag.CustomerGroup = csa.CustomerGroup
and cag.Language = 'E'
left outer join I_AddrCurDefaultEmailAddress as Email on Email.AddressID = Cu.AddressID
left outer join ZCUSTOMERDATAFORIDDATA  as Bup on Bup.BusinessPartner = Cu.Customer
left outer join I_Address_2 as Addr on Addr.AddressID = Cu.AddressID
left outer join ZCustomerAddress as ca on ca.BusinessPartner = Cu.Customer

{
  key Cu.Customer,
    key ca.AddressID as address,
  concat( concat( Cu.BusinessPartnerName1, ' ' ), Cu.BusinessPartnerName2 ) as Customername,
  bpt.BusinessPartnerGroupingText as BusinessPartnerGroupingText,
cag.CustomerGroupName as CustomerGroupText,
Cu.AddressSearchTerm1,
Cu.AddressSearchTerm2,
concat(
  concat(
    concat(
      case
        when Cu.StreetName <> ''
          then concat( Cu.StreetName, ', ' )
        else ''
      end,
      concat( Cu.PostalCode, ', ' )
    ),
    concat( Cu.CityName, ', ' )
  ),
  concat(
    Cu.Region,
    concat( ', ', Cu.Country )
  )
) as StandardAddress,
concat(
  concat(
    concat(
      case
        when ca.HouseNumber <> '' and ca.StreetName <> ''
          then concat( ca.HouseNumber, concat( ', ', ca.StreetName ) )
        when ca.HouseNumber <> ''
          then ca.HouseNumber
        when ca.StreetName <> ''
          then ca.StreetName
        else ''
      end,
      concat( ca.PostalCode, ', ' )
    ),
    concat( ca.CityName, ', ' )
  ),
  concat(
    ca.Region,
    concat( ', ', ca.Country )
  )
) as AdditionalAddress,
Cu.AddressID,
Bank.BankAccountHolderName,
  Bank.BankAccountName,
    Bank.BankNumber as BankKey,
    Bank.BankAccount,
    Cu.CityName,
    case Cu.Region
  when 'AN' then 'Andaman and Nicobar Islands'
  when 'AP' then 'Andhra Pradesh'
  when 'AR' then 'Arunachal Pradesh'
  when 'AS' then 'Assam'
  when 'BR' then 'Bihar'
  when 'CG' then 'Chhattisgarh'
  when 'CH' then 'Chandigarh'
  when 'DH' then 'Dadra and Nagar Haveli and Daman and Diu'
  when 'DL' then 'Delhi'
  when 'GA' then 'Goa'
  when 'GJ' then 'Gujarat'
  when 'HP' then 'Himachal Pradesh'
  when 'HR' then 'Haryana'
  when 'JH' then 'Jharkhand'
  when 'JK' then 'Jammu and Kashmir'
  when 'KA' then 'Karnataka'
  when 'KL' then 'Kerala'
  when 'LA' then 'Ladakh'
  when 'LD' then 'Lakshadweep'
  when 'MH' then 'Maharashtra'
  when 'ML' then 'Meghalaya'
  when 'MN' then 'Manipur'
  when 'MP' then 'Madhya Pradesh'
  when 'MZ' then 'Mizoram'
  when 'NL' then 'Nagaland'
  when 'OD' then 'Odisha'
  when 'PB' then 'Punjab'
  when 'PY' then 'Puducherry'
  when 'RJ' then 'Rajasthan'
  when 'SK' then 'Sikkim'
  when 'TN' then 'Tamil Nadu'
  when 'TR' then 'Tripura'
  when 'TS' then 'Telangana'
  when 'UK' then 'Uttarakhand'
  when 'UP' then 'Uttar Pradesh'
  when 'WB' then 'West Bengal'
  else ''
end as State, 
    Cu.Country,
    Email.EmailAddress,
    case
  when Cu.TelephoneNumber2 <> '' then Cu.TelephoneNumber2
  else Cu.TelephoneNumber1
end as PhoneNumber,
    CC.PaymentTerms,
    Bup.AadharNumber,
    Bup.AadharName,
    Bup.pan,
    Bup.panname,
    CC.HouseBank,
    CC.ReconciliationAccount,
    Cu.TaxNumber3,
    BP.BusinessPartnerIDByExtSystem,
    csa.Currency,
     case 
     when BP.IsMarkedForArchiving <> '' 
     then 'Block'
     else 'Active'
     end as ActiveStatus,
     lf.LegalFormDescription,
     BP.CreationDate,
     BP.LastChangeDate,
     case 
      when BP.CreatedByUser = User.UserID 
    then User.PersonFullName
    end as CreatedByUserName,
    case 
  when BP.LastChangedByUser = User.UserID
    then User.PersonFullName
end as LastChangedByUserName,
BP.YY1_DashBoardID_bus as DashBoardID,
    cast('1' as abap.int1) as numfield
}
