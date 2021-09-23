cd libraries/is_n
mkdir src
cd src

for i in {0..10}
do
    echo "return ((n: @number) => n == $i)" >> "$i.spwn"
    cd ..
    echo "f$i = import 'src/$i.spwn'" >> lib.spwn
    cd src
done

cd ..

echo "return {" >> lib.spwn

for i in {0..10}
do
    echo "  is_$i: f$i," >> lib.spwn
done

echo "}" >> lib.spwn