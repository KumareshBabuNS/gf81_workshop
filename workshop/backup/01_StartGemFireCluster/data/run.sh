export CUR_DIR=`pwd`

gfsh <<!
connect --locator=localhost[10334];
run --file=$CUR_DIR/dept-data
run --file=$CUR_DIR/emp-data
!

