class KanbanflowTaskNumber {
    [string]$prefix
    [int]$number

    KanbanflowTaskNumber([int]$number) {
        $this.prefix = $null
        $this.number = $number
    }

    KanbanflowTaskNumber([string]$prefix, [int]$number) {
        $this.prefix = $prefix
        $this.number = $number
    }
}