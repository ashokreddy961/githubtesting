@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For Customer Address'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCustomerAddress as select from I_BusPartAddress as ba
left outer join I_Address_2 as addr on addr.AddressID = ba.AddressID

{
  key ba.BusinessPartner,
  ba.AddressID,
  addr.HouseNumber,
  addr.RoomNumber,
  addr.HouseNumberSupplementText,
  addr.StreetName,
  addr.Street,
  addr.CityName, 
  addr.Region, 
  addr.Country,
  addr.PostalCode,
  addr.PersonFamilyName,
  addr.PersonGivenName
}
