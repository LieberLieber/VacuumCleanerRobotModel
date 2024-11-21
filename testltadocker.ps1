# test

          Write-Output "Repo Path: $(Get-Location)"
        
          sudo docker stop ltacli
          sudo docker remove ltacli

          sudo docker run -id --name ltacli -v "$(Get-Location):/data" nexus.lieberlieber.com:5000/lieberlieber/lemontree.automation:latest
          sudo docker exec -i --user 10:10 ltacli ./lemontree.automation ConsistencyCheck --Model "/data/VacuumCleanerRobotModel.qeax" --license "/data/lta.lic"
          # sudo docker exec -i ltacli ls ./data/
          sudo docker exec -i --user 10:10 ltacli ./lemontree.automation diff --theirs /data/assets/empty.qeax --mine /data/VacuumCleanerRobotModel.qeax --DiffReportFilename "/tmp/DiffReport.xml" --license "/data/lta.lic"
          sudo docker cp ltacli:/tmp/DiffReport.xml /tmp/DiffReport.xml 

          cat /tmp/DiffReport.xml
          
          #ls 
          
          #ls
          #testcode for file writting
          # ls
          # docker exec -i ltacli mkdir ./app/data/svg  
          # ls
          # touch svg/writetest.txt
          # ls svg/*.*      
          # docker exec -i ltacli ./lemontree.automation svgexport --Model "/data/${{env.ModelName}}" --diagramdirectory="." --license "/data/lta.lic"