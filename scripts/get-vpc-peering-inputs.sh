#!/bin/bash

# Set your regions here
REGIONS=("us-east-1" "us-west-2")  # Adjust as needed

# Output header
echo "=================================="
echo " AWS VPC Peering Configuration 🛠️"
echo "=================================="

for REGION in "${REGIONS[@]}"; do
  echo ""
  echo "🔎 Region: $REGION"
  echo "-----------------------------"

  # Get VPC details
  VPCS=$(aws ec2 describe-vpcs --region "$REGION" \
    --query "Vpcs[*].{VpcId:VpcId, Cidr:CidrBlock}" \
    --output json)

  echo "$VPCS" | jq -r '.[] | "VPC ID: \(.VpcId), CIDR: \(.Cidr)"'

  # Get route tables
  RTB=$(aws ec2 describe-route-tables --region "$REGION" \
    --query "RouteTables[*].{RouteTableId:RouteTableId, VPC:VpcId}" \
    --output json)

  echo ""
  echo "📘 Route Tables:"
  echo "$RTB" | jq -r '.[] | "Route Table: \(.RouteTableId), VPC: \(.VPC)"'

  # Account ID
  ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

  echo ""
  echo "👤 AWS Account ID: $ACCOUNT_ID"

  echo ""
  echo "💾 Example terraform.tfvars entries for region $REGION:"
  echo "---------------------------------------------"
  echo "peer_vpc_id             = \"<paste-VPC-ID-here>\""
  echo "peer_vpc_cidr_block     = \"<paste-CIDR-here>\""
  echo "peer_region             = \"$REGION\""
  echo "peer_account_id         = \"$ACCOUNT_ID\""
  echo "peer_route_table_id     = \"<paste-RouteTable-ID-here>\""
  echo ""
done

echo "🧩 Paste the corresponding values into terraform.tfvars for each peer."