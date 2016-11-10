#!/bin/bash
# Global variable for Log files

SRC_DIR=$(cd `dirname $0` && pwd)
. /misscripts/mis/scripts/param.par


TODAYHHMISS=`date   "+%Y%m%d%H%M%S"`
YDAY=`TZ=GMT+24 date +%d-%m-%Y`


CHK_STATUS='CHK_STATUS'
BUSINESS_PROCESS='ADHOC_REQUEST'
OUTPUT_FILE=$OUTPUT_PATH/$BUSINESS_PROCESS/"$BUSINESS_PROCESS"_"$TODAYHHMISS".csv
LOG_FILE=$LOG_PATH/$BUSINESS_PROCESS/"$BUSINESS_PROCESS"_$TODAYHHMISS.log
FTP_LOG_FILE=$LOG_PATH/$BUSINESS_PROCESS/FTP_"$BUSINESS_PROCESS"_$TODAYHHMISS.log

BLOG_PATH=$LOG_PATH/$BUSINESS_PROCESS
BOUTPUT_PATH=$OUTPUT_PATH/$BUSINESS_PROCESS
##################################################################
  
  mv -f "$BLOG_PATH"/*.log "$BLOG_PATH"/BACKUP_LOG/
  
  mv -f "$BOUTPUT_PATH"/*.csv "$BOUTPUT_PATH"/BACKUP_OUTPUT/

  gzip -9 -f "$BOUTPUT_PATH"/BACKUP_OUTPUT/*.csv  
  gzip -9 -f "$BLOG_PATH"/BACKUP_LOG/*.log

echo '#########################################################' > $LOG_FILE
echo '   Process Name       : DB PROCESS for ICMS_DATA List ' >> $LOG_FILE
echo "   Process Started On : `date +%d-%m-%Y`" >> $LOG_FILE
echo "   P_DATE        : $YDAY  " >> $LOG_FILE

         
           sql_str=` sqlplus -s $UID_PRD/$PWD_PRD <<END >$OUTPUT_FILE
                      set pagesize 0
                      set linesize 800
                      set echo off;
                      set term off;
                      set feed off;
select 'RECORD_SEQUENCE_NUMBER' || '|' || 'CDR_TYPE'  || '|' || 'CHARGED_PARTY_NUMBER'  || '|' || 'ORIGINAL_CALLING_NUMBER' || '|' || 'ORIGINALCALLEDNUMBER' || '|' || 'OTHER_PARTY_NUMBER' || '|' ||'CHARGED_SUBSCRIBER_IMSI' || '|' || 'CHARGED_SUBSCRIBER_IMEI' || '|' || 'OTHER_PARTY_SUBSCRIBER_IMSI' || '|' || 'OTHER_PARTY_SUBSCRIBER_IMEI' || '|' || 'DATE_FOR_START' || '|' || 'TIME_FOR_START' || '|' ||'TIME_FOR_STOP' || '|' || 'CALL_DURATION' || '|' || 'MSRN' || '|' || 'ORIGINATING_LOCATION_NUMBER' || '|' || 'TERMINATING_LOCATION_NUMBER' || '|' || 'FIRST_CELL_ID' || '|' || 'SMS_CENTER_NUMBER' || '|' ||'SERVICE' || '|' || 'SENDERS_MSISDN' || '|' || 'CUGINDICATOR' || '|' || 'CHARGEDPARTY' || '|' || 'SETUPTIME' || '|' || 'SEIZURETIME' || '|' || 'ROAMINGTYPE' || '|' || 'ROAMER_COUNTRY_TYPE' || '|' || 'PREPAIDFLAG' || '|' ||'CALLTYPE' || '|' || 'DISTANCEBAND' || '|' || 'ONNET_OFFNET' from DUAL;
select RECORD_SEQUENCE_NUMBER || '|' || CDR_TYPE || '|' || CHARGED_PARTY_NUMBER || '|' || ORIGINAL_CALLING_NUMBER || '|' || ORIGINALCALLEDNUMBER || '|' || OTHER_PARTY_NUMBER || '|' ||CHARGED_SUBSCRIBER_IMSI || '|' || CHARGED_SUBSCRIBER_IMEI || '|' || OTHER_PARTY_SUBSCRIBER_IMSI || '|' || OTHER_PARTY_SUBSCRIBER_IMEI || '|' || DATE_FOR_START || '|' || TIME_FOR_START || '|' ||TIME_FOR_STOP || '|' || CALL_DURATION || '|' || MSRN || '|' || ORIGINATING_LOCATION_NUMBER || '|' || TERMINATING_LOCATION_NUMBER || '|' || FIRST_CELL_ID || '|' || SMS_CENTER_NUMBER || '|' ||SERVICE || '|' || SENDERS_MSISDN || '|' || CUGINDICATOR || '|' || CHARGEDPARTY || '|' || SETUPTIME || '|' || SEIZURETIME || '|' || ROAMINGTYPE || '|' || ROAMER_COUNTRY_TYPE || '|' || PREPAIDFLAG || '|' ||CALLTYPE || '|' || DISTANCEBAND || '|' || ONNET_OFFNET from msc_mpt_sush;

                   exit;
                     END ` 

		gzip -9 $OUTPUT_PATH/$BUSINESS_PROCESS/"$BUSINESS_PROCESS"_"$TODAYHHMISS".csv

#### FTP FILE TO REMOTE LOCATION ######
               target_dir="Adhoc_Report"
              . /misscripts/mis/scripts/ftp_files.sh $target_dir $OUTPUT_PATH/$BUSINESS_PROCESS "$BUSINESS_PROCESS"_"$TODAYHHMISS".csv.gz $FTP_LOG_FILE

#######################################

echo "   Process finished On : `date +%Y-%m-%d`" >> $LOG_FILE
echo "   Process finished At : `date +%H:%M:%S`  " >> $LOG_FILE
echo '#########################################################' >> $LOG_FILE

