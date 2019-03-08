# KanbanFlow-Powershell

## What is kanbanflow?

Kanbanflow is a commercial kanban tool you can find here: https://kanbanflow.com

At work we needed a fast and lean digital kanban board. Kanbanflow gives us exactly the features we need.
In its paid version it offers web API access which enables an additional big variety of possibilities.

## What is Kanbanflow-Powershell?

Kanbanflow is a Powershell module compatible to PS5 and PS6 which gives
you a simple access to that api, including some additional analytics.

Since Powershell is available on windows by default, because it is the "new shell" and with Powershell Core (PS6) 
being available cross platform, there is nothing in your way to instantly start automating and integrating your kanban boards.

[Get the api documentation here.](https://stho32.github.io/KanbanFlow-Powershell/docfx_project/site/articles/index.html)

### Example 1: Add a task to the first column of the board

(You can set every attribute possible with the ui. See `help New-KBFTask` for all parameters.)

```powershell
Import-Module "C:\Projekte\KanbanFlow-Powershell\Source\Kanbanflow.psm1"

$column = (Get-KBFBoard -ApiToken $testBoardApiToken).columns[0].uniqueId
New-KBFTask -ApiToken $testBoardApiToken -Name "A new Task!" -ColumnId $column 
```

### Example 2: Get a report of the current day

```powershell
Import-Module "C:\Projekte\KanbanFlow-Powershell\Source\Kanbanflow.psm1"

$result = Get-KBFDayOverview -ApiToken "<YOUR API TOKEN>" -Day (Get-Date).Date 

$result | Format-Table -AutoSize
```

May output something like that (all Ids have been modified for security reasons): 
```
entryId type      userId      taskId   startTimestamp           endTimestamp             partIndex taskName        durationInMinutes color  
------- ----      ------      ------   --------------           ------------             --------- --------        ----------------- -----  
9G1Z3G  stopwatch dkfonIOcneo 2twe7ckj 2019-03-07T07:17:34Z     2019-03-07T07:21:31Z             0 Some Tasks name                 4 white  
F5255R  stopwatch dkfonIOcneo J5wekNov 2019-03-07T07:21:35Z     2019-03-07T08:32:00Z             0 Some Tasks name                70 magenta
Em3MDx  stopwatch Ijfiewfniiw Nnwe7MyF 2019-03-07T08:06:35Z     2019-03-07T08:27:42Z             0 Some Tasks name                21 yellow 
Wb4e7N  stopwatch LciwBicw98w sLRdf7u4 2019-03-07T08:27:17Z     2019-03-07T09:00:08Z             0 Some Tasks name                33 yellow 
Gf5uHl  stopwatch dkfonIOcneo 2ta7dckj 2019-03-07T08:32:04Z     2019-03-07T08:45:29Z             0 Some Tasks name                13 white  
I46Shi  stopwatch dkfonIOcneo n53a7Drt 2019-03-07T08:45:32Z     2019-03-07T08:59:38Z             0 Some Tasks name                14 white  
L275sy  manual    Ijfiewfniiw Nna77MyF 2019-03-07T09:00:00.000Z 2019-03-07T09:21:00.000Z           Some Tasks name                21 yellow 
L18PCC  stopwatch dkfonIOcneo nX7a7SLK 2019-03-07T09:00:07Z     2019-03-07T09:21:16Z             0 Some Tasks name                21 yellow 
Wb9e7N  stopwatch LciwBicw98w Zdiia78Q 2019-03-07T09:00:08Z     2019-03-07T09:22:23Z             1 Some Tasks name                22 yellow 
Lt16E7  manual    dkfonIOcneo a7hKJkH2 2019-03-07T09:21:00.000Z 2019-03-07T09:30:00.000Z           Some Tasks name                 9 white  
X22o5p  stopwatch Ijfiewfniiw Ma7saTwF 2019-03-07T09:21:18Z     2019-03-07T11:03:20Z             0 Some Tasks name               102 yellow 
Wb3e7N  stopwatch LciwBicw98w sLa7R7u4 2019-03-07T09:22:23Z     2019-03-07T11:00:18Z             2 Some Tasks name                98 yellow 
OB4Yya  stopwatch dkfonIOcneo hKJa7kH2 2019-03-07T09:30:17Z     2019-03-07T09:59:29Z             0 Some Tasks name                29 white  
WS5j4U  stopwatch dkfonIOcneo a7hKJkH2 2019-03-07T10:03:21Z     2019-03-07T10:59:31Z             0 Some Tasks name                56 white  
d26ggJ  stopwatch dkfonIOcneo ha7KJkH2 2019-03-07T11:43:04Z     2019-03-07T12:01:42Z             0 Some Tasks name                19 white  
PC7g1J  stopwatch LciwBicw98w sLa7R7u4 2019-03-07T11:45:22Z     2019-03-07T17:08:42Z             0 Some Tasks name               323 yellow 
3l8oqG  stopwatch Ijfiewfniiw MsaTwFfw 2019-03-07T11:50:05Z     2019-03-07T14:21:15Z             0 Some Tasks name               151 yellow 
g69ins  stopwatch dkfonIOcneo a7sLR7u4 2019-03-07T12:02:10Z     2019-03-07T12:21:47Z             0 Some Tasks name                20 yellow 
2H0vBS  stopwatch dkfonIOcneo a7sLR7u4 2019-03-07T12:33:29Z     2019-03-07T14:02:26Z             0 Some Tasks name                89 yellow 
7O2wKs  stopwatch dkfonIOcneo a7sLR7u4 2019-03-07T14:26:48Z     2019-03-07T15:03:25Z             0 Some Tasks name                37 yellow 
642Eon  manual    Ijfiewfniiw Msa7aTwF 2019-03-07T14:38:00.000Z 2019-03-07T14:46:00.000Z           Some Tasks name                 8 yellow 
E12MT6  stopwatch Ijfiewfniiw ksaa7TwF 2019-03-07T14:46:59Z     2019-03-07T15:53:09Z             0 Some Tasks name                66 yellow 
7r3g29  stopwatch dkfonIOcneo nXa77SLK 2019-03-07T15:07:45Z     2019-03-07T15:08:11Z             0 Some Tasks name                 0 yellow 
8fd3so  stopwatch dkfonIOcneo nXa77SLK 2019-03-07T15:08:20Z     2019-03-07T15:14:00Z             0 Some Tasks name                 6 yellow 
9A3feJ  stopwatch dkfonIOcneo hKJa7kH2 2019-03-07T15:14:03Z     2019-03-07T15:20:01Z             0 Some Tasks name                 6 white  
9eissi  stopwatch dkfonIOcneo hKa7JkH2 2019-03-07T15:20:02Z     2019-03-07T15:24:25Z             0 Some Tasks name                 4 white  
NBQadn  stopwatch dkfonIOcneo HZa78qwD 2019-03-07T15:24:30Z     2019-03-07T16:45:25Z             0 Some Tasks name                81 white  
U13qey  stopwatch LciwBicw98w sLa7R7u4 2019-03-07T17:08:44Z     2019-03-07T18:01:19Z             0 Some Tasks name                53 yellow 
```

### For more examples and cmdlets

For more examples have a look at the documentation and the unit tests.

[Get the api documentation here.](https://stho32.github.io/KanbanFlow-Powershell/docfx_project/site/articles/index.html)

