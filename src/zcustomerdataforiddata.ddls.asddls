@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For Id Data of Customer'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCUSTOMERDATAFORIDDATA as select from ZSupplierProofDetails as id
left outer join ZSupplierProofDetailsAadhar as ida on ida.BusinessPartner = id.BusinessPartner
{
    id.BusinessPartner,
    id.BPIdentificationNumber as pan,
    id.BPIdnNmbrIssuingInstitute as panname,
    id.BPIdentificationType as pantype,
    ida.BPIdentificationNumber as AadharNumber,
    ida.BPIdnNmbrIssuingInstitute as AadharName ,
    ida.BPIdentificationType as Aadhartype 
}
