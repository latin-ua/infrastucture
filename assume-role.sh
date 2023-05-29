#! /bin/bash
set -uex


ASSUME_ROLE="$(aws sts assume-role --role-arn arn:aws:iam::991225504892:role/tf-pipeline-role --role-session-name session10)"
export AWS_ACCESS_KEY_ID="$(echo $ASSUME_ROLE | jq .Credentials.AccessKeyId)"
export AWS_SECRET_ACCESS_KEY="$(echo $ASSUME_ROLE | jq .Credentials.SecretAccessKey)"
export AWS_SESSION_TOKEN="$(echo $ASSUME_ROLE | jq .Credentials.SessionToken)"
