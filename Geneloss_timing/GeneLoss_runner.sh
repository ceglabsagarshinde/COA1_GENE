mkdir Geneloss_runs
cp nwk.list Geneloss_timing
mv Geneloss_timing Geneloss_runs
cd Geneloss_runs
#######################################################
cp -r Geneloss_timing/ Geneloss_timing_midrooted_NBL
cd Geneloss_timing_midrooted_NBL

for i in `cat nwk.list`
do
echo $i
gotree reroot midpoint -i $i -o temp.nwk
rm "$i"
mv temp.nwk "$i"
gotree brlen clear -i "$i" -o temp.nwk
rm "$i"
mv temp.nwk "$i"
done
./overall_wrapper.sh
cd ..

#######################################################
cp -r Geneloss_timing/ Geneloss_timing_midrooted_WBL
cd Geneloss_timing_midrooted_WBL
for i in `cat nwk.list`
do
echo $i
gotree reroot midpoint -i $i -o temp.nwk
rm "$i"
mv temp.nwk "$i"
gotree brlen clear -i "$i" -o temp.nwk
rm "$i"
mv temp.nwk "$i"
done
./overall_wrapper.sh
cd ..
#######################################################
cp -r Geneloss_timing/ Geneloss_timing_rooted_WBL
cd Geneloss_timing_rooted_WBL
./overall_wrapper.sh 
cd ..
#######################################################
cp -r Geneloss_timing/ Geneloss_timing_rooted_NBL
cd Geneloss_timing_rooted_NBL
for i in `cat nwk.list`
do
echo $i
gotree brlen clear -i "$i" -o temp.nwk
rm "$i"
mv temp.nwk "$i"
done
./overall_wrapper.sh
cd ..
#######################################################
cp -r Geneloss_timing/ Geneloss_timing_unrooted_NBL
cd Geneloss_timing_unrooted_NBL
for i in `cat nwk.list`
do
echo $i
gotree unroot -i $i -o temp.nwk
rm "$i"
mv temp.nwk "$i"
gotree brlen clear -i "$i" -o temp.nwk
rm "$i"
mv temp.nwk "$i"
done
./overall_wrapper.sh
cd ..
#######################################################
cp -r Geneloss_timing/ Geneloss_timing_unrooted_WBL
cd Geneloss_timing_unrooted_WBL
for i in `cat nwk.list`
do
echo $i
gotree unroot -i $i -o temp.nwk
rm "$i"
mv temp.nwk "$i"
gotree brlen clear -i "$i" -o temp.nwk
rm "$i"
mv temp.nwk "$i"
done
./overall_wrapper.sh 
cd ..
#######################################################

