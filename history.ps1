#!/bin/bash
# Set variables
$Days = 1095
$CommitsPerDay = 3
$Branch = "main" # Change to 'master' if needed
$AuthorName = "Madanpatel21" # <--- REPLACE WITH YOUR GITHUB NAME
$AuthorEmail = "Madanpatel3169@gmail.com" # <--- REPLACE WITH YOUR GITHUB EMAIL

Write-Host "🚀 Starting history generation..."

# Calculate start date (3 years ago)
$StartDate = (Get-Date).AddYears(-3)

for ($i = 1; $i -le $Days; $i++) {
    $CurrentDate = $StartDate.AddDays($i).ToString("yyyy-MM-dd")
    Write-Host "Processing date: $CurrentDate"
    
    for ($j = 1; $j -le $CommitsPerDay; $j++) {
        $FileName = "data_${CurrentDate}_${j}.txt"
        
        # Create dummy content
        echo "Commit data for $CurrentDate - Run $j" > $FileName
        
        # Add and Commit
        git add $FileName
        git commit --author="$AuthorName <$AuthorEmail>" --date="$CurrentDateT12:00:00+0000" -m "Auto-generated commit on $CurrentDate ($j/3)" --no-verify
        
        # Remove file to keep repo clean
        del $FileName
    }
    
    if ($i % 100 -eq 0) {
        Write-Host "✅ Completed $i days..."
    }
}

Write-Host "✅ History generated! Pushing to remote..."
git push origin $Branch