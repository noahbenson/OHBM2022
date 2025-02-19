#! /bin/bash

for worker in $(seq 1 4)
do { for round in $(seq 1 11)
     do job=$(( $worker + ($round - 1)*4 ))
        ./render.wls $job 44 &> /data/nyuretinotopy_morph/logs/render${job}.log
     done
   } &
   pids[${job}]=$!
done

