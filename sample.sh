#!/bin/bash

BILLING_FILE='s3://hideyy-billingreport/640175474045-aws-billing-detailed-line-items-2016-10.csv.zip'
OUTPUT_BUCKET='hideyy-billingreport'

# S3のキー名からファイル名を抽出
INPUT_TEMP_ZIP_FILE=`echo $BILLING_FILE | cut -d "/" -f 4`
INPUT_TEMP_FILE=`echo $INPUT_TEMP_ZIP_FILE | sed -e s/\.zip$//g`

# S3から請求レポートをダウンロード
aws s3 cp $BILLING_FILE $INPUT_TEMP_ZIP_FILE
unzip $INPUT_TEMP_ZIP_FILE

# 解凍済のファイルを読み込む
cat $INPUT_TEMP_FILE | while read line
do
  LINKED_ACCOUNT_ID=`echo $line | cut -d ',' -f 2 | sed -e 's/"//g'`
  echo $LINKED_ACCOUNT_ID
  if [[ $LINKED_ACCOUNT_ID =~ "[0-9]{12}" ]]; then
    echo $line >> ${LINKED_ACCOUNT_ID}_billing.csv
  fi
done

# ダウンロードファイルを削除
rm $INPUT_TEMP_ZIP_FILE
rm $INPUT_TEMP_FILE
