import os
import asyncio
# from multiprocessing import Process
# 21 30
# 31 40
# 41 50

code = """
cd libraries

for epoch in $(seq %d %d) 
do
    end=$((10000 * $epoch))
    let start=$end-10000

    echo $start
    echo $end

    mkdir "is_n_$end"
    cd "is_n_$end"
    mkdir s
    cd s

    for i in $(seq $start $end)
    do
        echo -n "return((n: @number) => n==$i)" >> "$i.spwn"
        cd ..
        echo "f$i=import 's/$i.spwn'" >> lib.spwn
        cd s
    done

    cd ..

    echo "return {" >> lib.spwn

    for i in $(seq $start $end)
    do
        echo -n "is_$i:f$i," >> lib.spwn
    done

    echo -e "\n}" >> lib.spwn

    cd ..

    git add .
    git commit -m "added epoch $epoch"
    git push
done
"""

async def batch10(start, end):
    todo = code % (start, end)
    proc = await asyncio.create_subprocess_shell(
        todo, 
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE
    )

    stdout, stderr = await proc.communicate()

for intervals in [(21, 30), (31, 40), (41, 50)]:
    asyncio.run(batch10(*intervals))