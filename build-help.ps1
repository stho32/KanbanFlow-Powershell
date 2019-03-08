. C:\Projekte\PSCore-Tools\PSCore-Tools.ps1

Set-Location $PSScriptRoot

#PS6: Export-HelpAsMarkdown -Path $PSScriptRoot\Source -TargetPath $PSScriptRoot\docfx_project\articles

Set-Location $PSScriptRoot\docfx_project\articles

$yml = Invoke-Command {
    "- name: Introduction"
    "  href: intro.md"

    $rootPfad = "C:\Projekte\KanbanFlow-Powershell\docfx_project\articles\"

    $aktuellerSubpfad = ""
    Get-ChildItem *.md -Recurse | 
        Sort-Object Fullname | 
        Where-Object Name -ne "index.md" | 
            ForEach-Object {
                $relativerPfad = ($_.FullName).Replace($rootPfad, "")
                $subpfad = $relativerPfad.Split("\")[0]
                if ( $aktuellerSubpfad -ne $subpfad ) {
                    $aktuellerSubpfad = $subpfad
                    Write-Output "- name: $aktuellerSubpfad"
                    Write-Output "  items:"
                }
                $dateiname = $subpfad = $relativerPfad.Split("\")[1]
                $cmdletName = $dateiname.Replace(".md", "")
                Write-Output "     - name: $cmdletName"
                Write-Output "       href: $aktuellerSubpfad/$dateiname"
            }
}

$yml | Out-File $PSScriptRoot\docfx_project\articles\toc.yml