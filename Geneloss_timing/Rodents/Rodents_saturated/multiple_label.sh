for dir in mammals_multiple_labels Rodents_multiple_labels
do
cd $dir
rm codeml.ctl
./Tp_estimation_multiple_label.sh
cd ..
done

