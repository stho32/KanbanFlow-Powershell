# CLAUDE.md

## Projektbeschreibung

PowerShell-Modul als Interface fuer die KanbanFlow API (https://kanbanflow.com). Implementiert ca. 95% der API in leicht konsumierbarer Form.

## TechStack

- PowerShell

## Architektur-Vorlage

powershell-module

## Wichtige Befehle

```powershell
# Modul importieren
Import-Module ./Kanbanflow/Kanbanflow.psd1

# Tests ausfuehren
Invoke-Pester
```

## Konventionen

- CmdletBinding fuer alle oeffentlichen Funktionen
- Verb-Noun Naming (z.B. Get-KBFTask, New-KBFTask, Update-KBFTask)
- Alle Funktionen verwenden das Praefix "KBF"
