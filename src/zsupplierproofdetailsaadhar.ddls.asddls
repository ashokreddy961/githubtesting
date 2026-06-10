@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For Aadhar Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSupplierProofDetailsAadhar as select from I_BuPaIdentification as Bup
{
    key Bup.BusinessPartner,
    Bup.BPIdentificationType,
    Bup.BPIdentificationNumber,
    Bup.BPIdnNmbrIssuingInstitute
}
where Bup.BPIdentificationType = 'AADHAR'
