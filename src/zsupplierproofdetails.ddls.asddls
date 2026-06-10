@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For ID data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSupplierProofDetails as select from I_BuPaIdentification as Bup
{
    key Bup.BusinessPartner,
    Bup.BPIdentificationType,
    Bup.BPIdentificationNumber,
    Bup.BPIdnNmbrIssuingInstitute
}
where Bup.BPIdentificationType = 'PAN'
