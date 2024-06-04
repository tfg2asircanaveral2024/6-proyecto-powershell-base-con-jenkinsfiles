$PropiedadesScriptAnalyzer=@()
get-content ./Reglas-ScriptAnalyzer/* | 
    where { -not ($_ -match '^#') } | 
    ForEach-Object { $PropiedadesScriptAnalyzer += $_ }

$TestsScriptAnalyzer=Invoke-ScriptAnalyzer -Path ./Gestionar-Datos.ps1 -IncludeRule $PropiedadesScriptAnalyzer

if (($TestsScriptAnalyzer | measure).count -gt 0) {
    Throw "Ha habido $(($TestsScriptAnalyzer | measure).count) errores de PSScriptAnalyzer.$($TestsScriptAnalyzer | select Line,RuleName,Message,Severity)"
} else {
    Write-Output "Se han superado los tests de PSScriptAnalyzer."
}