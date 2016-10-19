#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import re
import boto3

bucket_name = 'hideyy-billingreport'
key_name = '640175474045-aws-billing-csv-2016-10.csv'

transfer = S3Transfer(boto3.client('s3'))
transfer.download_file(bucket_name, key_name)
