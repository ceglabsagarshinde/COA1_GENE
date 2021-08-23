

cp -r mapnh_phastBias_groupwise mapnh_phastBias_groupwise_rooted_WBL
cd mapnh_phastBias_groupwise_rooted_WBL
cp ../mapnh_phastBias_groupwise/scripts/phast_wrapper_rooted_WBL.sh .
cp ../mapnh_phastBias_groupwise/scripts/mapnh_common.sh .
chmod 777 phast_wrapper_rooted_WBL.sh mapnh_common.sh
./phast_wrapper_rooted_WBL.sh
./mapnh_common.sh
cd ..

cp -r mapnh_phastBias_groupwise mapnh_phastBias_groupwise_rooted_NBL
cd mapnh_phastBias_groupwise_rooted_NBL
cp ../mapnh_phastBias_groupwise/scripts/phast_wrapper_rooted_NBL.sh .
cp ../mapnh_phastBias_groupwise/scripts/mapnh_common.sh .
chmod 777 phast_wrapper_rooted_NBL.sh mapnh_common.sh
./phast_wrapper_rooted_NBL.sh
./mapnh_common.sh
cd ..

cp -r mapnh_phastBias_groupwise mapnh_phastBias_groupwise_unrooted_WBL
cd mapnh_phastBias_groupwise_unrooted_WBL
cp ../mapnh_phastBias_groupwise/scripts/phast_wrapper_unrooted_WBL.sh .
cp ../mapnh_phastBias_groupwise/scripts/mapnh_common.sh .
chmod 777 phast_wrapper_unrooted_WBL.sh mapnh_common.sh
./phast_wrapper_unrooted_WBL.sh
./mapnh_common.sh
cd ..

cp -r mapnh_phastBias_groupwise mapnh_phastBias_groupwise_unrooted_NBL
cd mapnh_phastBias_groupwise_unrooted_NBL
cp ../mapnh_phastBias_groupwise/scripts/phast_wrapper_unrooted_NBL.sh .
cp ../mapnh_phastBias_groupwise/scripts/mapnh_common.sh .
chmod 777 phast_wrapper_unrooted_NBL.sh mapnh_common.sh
./phast_wrapper_rooted_NBL.sh
./mapnh_common.sh
cd ..

cp -r mapnh_phastBias_groupwise mapnh_phastBias_groupwise_midrooted_WBL
cd mapnh_phastBias_groupwise_midrooted_WBL
cp ../mapnh_phastBias_groupwise/scripts/phast_wrapper_midrooted_WBL.sh .
cp ../mapnh_phastBias_groupwise/scripts/mapnh_common.sh .
chmod 777 phast_wrapper_midrooted_WBL.sh mapnh_common.sh
./phast_wrapper_midrooted_WBL.sh
./mapnh_common.sh
cd ..

cp -r mapnh_phastBias_groupwise mapnh_phastBias_groupwise_midrooted_NBL
cd mapnh_phastBias_groupwise_midrooted_NBL
cp ../mapnh_phastBias_groupwise/scripts/phast_wrapper_midrooted_NBL.sh .
cp ../mapnh_phastBias_groupwise/scripts/mapnh_common.sh .
chmod 777 phast_wrapper_midrooted_NBL.sh mapnh_common.sh
./phast_wrapper_midrooted_NBL.sh
./mapnh_common.sh
cd ..



