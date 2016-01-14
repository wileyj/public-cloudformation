#!/bin/sh

clear
if [ "$1" == "" -o "$1" == "--help" -o "$1" == "-h" ]; then
echo "

Usage: $0 <update/create> <region> <Stack Name> <Cloudformation json> <cloudformation params file> <--debug?>

ex:
Create new stack: 
    $0 create us-east-1 App-slots-prod-1 vpc.json launch-params-app-us-east-1.json --debug

Update existing stack:
    $0 update us-west-1 VPC-Service vpc.json launch-params-vpc-service.json --debug

"
fi
if [ "$1" == "create" ]; then
    aws --region $2 cloudformation create-stack --stack-name $3 --template-body file://$4 --parameters file://$5 --capabilities CAPABILITY_IAM $6
    aws s3 cp $4 s3://netflix-cloudformation/$5
elif [ "$1" == "update "]; then
    echo "aws update stack $2"
else
    echo "default"
    read ans
    aws --region $1 cloudformation create-stack --stack-name $2 --template-body file://$3 --parameters file://$4 --capabilities CAPABILITY_IAM $5
    aws s3 cp $3 s3://netflix-cloudformation/$4
fi

# aws --region us-east-1 cloudformation create-stack --stack-name Slots-Puppet --template-body file:///Users/wileyj/git/ops-cloudformation/beanstalk.json --capabilities CAPABILITY_IAM --debug
# run.sh create us-east-1 VPC-us-east-1 vpc.json launch-params-vpc.json --debug
#
#
# sh run.sh create us-west-2 Staging-Stepper-App app-stepper-env.json launch-params-stepper-staging-env-us-west-2.json --debug
# sh run.sh create us-west-2 Staging-Stepper-1 app-stepper.json launch-params-stepper-staging-us-west-2.json --debug



