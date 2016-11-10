#!/bin/bash
vard=`gdate -d "-1 day" +%Y%m%d`
vard2=`gdate -d "-2 day" +%Y%m%d`
BASHPATH=/misscripts/mis/backup/IN/
BASHPATH2=/misscripts/mis/processed/IN/
DATA=$BASHPATH/DATA_CDR
DATA2=$BASHPATH2/DATA_CDR2
DATA3=$BASHPATH2/DATA_CDR3
DATA4=$BASHPATH2/DATA_CDR4
DATA5=$BASHPATH2/DATA_CDR5
REC=$BASHPATH/REC_CDR
MSC="/misscripts/mis/backup/NETWORK/MSC"
MON=$BASHPATH/MON_CDR
GFT=$BASHPATH/GFT_CDR
SMS=$BASHPATH/SMS_CDR
MGR=$BASHPATH/MGR_CDR
VOU=$BASHPATH/VOU_CDR
SUB=$BASHPATH/SUBSCRIBER_DUMP
VOUCHER=$BASHPATH/VOUCHER_DUMP
SUBCHG=$BASHPATH/SUBCHG_CDR
RETURN=$BASHPATH/RETURN_CDR
CLR=$BASHPATH/CLR_CDR
MMS=$BASHPATH/MMS_CDR
RBT=$BASHPATH/RBT_CDR
OFFER=$BASHPATH/OFFER_DUMP


	cd $DATA
	#mdelete ./$vard
	rm -rf $vard

	cd $REC
	rm -rf $vard

	cd $MSC
	rm -rf $vard

	cd $MON
	rm -rf $vard2

	cd $GFT
	rm -rf $vard2
	
 	cd $SMS
	rm -rf $vard2

	cd $MGR
	rm -rf $vard2
	
	cd $VOU
	rm -rf $vard2

	cd $SUB
	rm -rf $vard2

	cd $VOUCHER
	rm -rf $vard2

	cd $SUBCHG
	rm -rf $vard2

	cd $RETURN
	rm -rf $vard2

	cd $MMS
 	rm -rf $vard2

	cd $CLR
	rm -rf $vard2
	
	cd $RBT
	rm -rf $vard2

       cd $OFFER
	rm -rf $vard2

cd $DATA2
rm -rf $vard
cd $DATA3
rm -rf $vard
cd $DATA4
rm -rf $vard
cd $DATA5
rm -rf $vard

exit;




