param($TriggerMetadata,[string] $mySbMsg)
Import-Module .\Module\Mdbc\6.5.6\Mdbc.dll
Write-Host "PowerShell ServiceBus topic trigger function processed message: $($TriggerMetadata.MessageId)"
$returnFromTopic=[PSCustomObject]@{
    Codigo = $TriggerMetadata.Codigo
    Valor = $TriggerMetadata.valor
    MessageID = $TriggerMetadata.MessageId
    data = $(get-date -Format "MM/dd/yyyy HH:mm:ss K")
}
$returnFromTopic2=[PSCustomObject]@{
    Codigo = $mySbMsg.Codigo
    Valor = $mySbMsg.valor
    MessageID = $mySbMsg.MessageId
    data = $(get-date -Format "MM/dd/yyyy HH:mm:ss K")
}

Write-Host $returnFromTopic 
write-host $returnFromTopic2 

Write-Host "Conectando ao CosmosDB - api MongoDB"
Connect-Mdbc -ConnectionString  $env:MongoConnection -DatabaseName $env:MongoDatabase -CollectionName $env:MongoCollection
Write-Host "Persistindo o Documento"
$returnFromTopic | Add-MdbcData