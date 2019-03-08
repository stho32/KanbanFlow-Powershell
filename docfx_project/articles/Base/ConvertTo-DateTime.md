# ConvertTo-DateTime

*Converts a string into a datetime*

If the InputObject is a string, it'll be converted into a DateTime.
But if it is a DateTime, it wont be touched. It just will be passed through.

This is needed to make this library compatible for Powershell 5.
Powershell 6 automatically recognizes DateTimes and converts them from the
kanbanflow format into normal DateTimes. But Powershell 5 does not.

## Example Nr. 1
"2019-02-28T00:00:00Z" | ConvertTo-DateTime


<small>To get the full information type PS> `Get-Help .`</small>
