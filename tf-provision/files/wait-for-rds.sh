#!/bin/bash

# wait for rds status passed in arg
# $1 RDS instance identifier
# $2 expected status

interval=5
tout=600

rds_id="$1"
status="$2"

for (( i=0; i<$tout; i+=$interval ))
do 
  resp=$(aws rds describe-db-instances \
    --db-instance-identifier "$rds_id" --output text --query='DBInstances[*].DBInstanceStatus')
  if [[ "$resp" == "$status" ]]
  then
    echo "RDS state: $resp"
    exit 0
  fi
  echo "RDS state: $resp - waiting... $(( $i + $interval ))s"
  sleep $interval
done

echo "RDS state: $resp"
echo "Timeout!"
exit 62