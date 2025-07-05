#!/bin/bash

echo "🔍 Checking MSK Connect connector status..."
aws kafka-connect list-connectors \
  --query "connectors[?name=='mm2-cluster-link'].connectorArn" \
  --output text

aws kafka-connect describe-connector \
  --connector-arn <your-connector-arn> \
  --query "connectorState"

echo "📡 Verifying mirrored topics in target MSK..."
aws kafka list-topics \
  --cluster-arn <target-cluster-arn> \
  --query "topics[?contains(@, 'us-east-1.')]" \
  --output text

echo "📊 (Optional) Run kafka-consumer-groups.sh to check replication lag across clusters."