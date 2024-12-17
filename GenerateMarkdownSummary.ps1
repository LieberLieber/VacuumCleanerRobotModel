# Define the input XML file and output Markdown file
$xmlFile = "DiffReport.xml"
$outputMarkdown = "DiffReportSummary.md"

# Load the XML file
[xml]$xmlData = Get-Content $xmlFile

Write-Output "XML DiffReport Loaded"

# Extract report metadata
$report = $xmlData.report
$creator = $report.creatorName
$version = $report.creatorVersion
$date = $report.date

# Start Markdown content
$markdown = @"
# Diff Report Summary

**Creator:** $creator  
**Version:** $version  
**Date:** $date
"@

# Add changes section
$markdown += "`n## Changes`n"

# Extract and summarize classifiers
foreach ($package in $report.changes.package) {
    $packageName = $package.qualifiedName
    Write-Output "$packageName"
    if ($packageName.StartsWith("VacuumCleanerRobot")) {
        $markdown += "# $packageName`n"
        $changes = $package.classifier
        foreach ($classifier in $changes) {
            $name = $classifier.name
            $umlType = $classifier.umlType
            $guid = $classifier.guid

            $markdown += "### $name ($umlType)`n"
            $markdown += "- **GUID:** $guid`n"

            # Summarize changed properties
            $elements = $classifier.element
            foreach ($element in $elements) {
                $elementName = $element.name
                $markdown += "#### Element: $elementName`n"
            
                # List changed properties
                $changedProperties = $element.changedProperties.property
                foreach ($property in $changedProperties) {
                    $propertyName = $property.name  
                    $Value = $property.newValue #.newValue is the Value for us as we compared with empty.

                    $markdown += "**Property:** $propertyName"            
                    $markdown += " **Value:** $Value`n"
                }
    }
    }
}
}

Write-Output "Markdowncreated!"
Write-Output $markdow

# Save the Markdown content to a file
$markdown | Out-File -FilePath $outputMarkdown -Encoding utf8

Write-Host "Markdown summary generated: $outputMarkdown"
