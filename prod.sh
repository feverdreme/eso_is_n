cd libraries

function doepoch {
    start=$1
    end=$2

    mkdir "is_n_$end"
    cd "is_n_$end"
    mkdir s
    cd s

    for i in $(seq $start $end)
    do
        echo -n "return((n: @number) => n==$i)" >> "$i.spwn"
    done

    cd ..

    echo "return {" >> lib.spwn

    for i in $(seq $start $end)
    do
        echo -n "is_$i:import's/$i.spwn'," >> lib.spwn
    done

    echo -e "\n}" >> lib.spwn

    cd ..
}

execstring="echo 'starting...'"

for epoch in $(seq 1 5) 
do
    end=$((10000 * $epoch))
    let start=$end-10000

    execstring="$execstring & doepoch $start $end"
done

eval $execstring

for epoch in $(seq 1 5)
do
    git add "is_n_$end"
    git commit -m "added epoch $epoch"
    git push

    echo "libraries/is_n_$end/*" >> ../.gitignore
    rm -rf "is_n_$end"
done