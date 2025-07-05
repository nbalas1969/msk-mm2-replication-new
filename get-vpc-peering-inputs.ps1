# get-vpc-peering-inputs.ps1

$regions = @("us-east-1", "us-west-2")  # Adjust as needed

foreach ($region in $regions) {
    Write-Host "🔎 Region: $region" -ForegroundColor Cyan

    aws ec2 describe-vpcs --region $region `
        --query "Vpcs[*].{ID:VpcId, CIDR:CidrBlock}" `
        --output table

    Write-Host "`n📦 Route Tables:"
    aws ec2 describe-route-tables --region $region `
        --query "RouteTables[*].{ID:RouteTableId, VPC:VpcId}" `
        --output table

    Write-Host "`n👤 AWS Account ID:"
    aws sts get-caller-identity --query "Account" --output text

    Write-Host "`n-----------------------------`n"
}