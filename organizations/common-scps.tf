resource "aws_organizations_policy" "organizations_scp_account_protection" {
  name = "scp_account_protection"
  description = "Stops the organization from being left, and from payments/billing being messed with. Use the root account for these activities only."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Resource": "*",
      "Effect": "Deny",
      "Condition": {
        "StringLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:root"
          ]
        }
      }
    },
    {
      "Action": [
        "organizations:LeaveOrganization"
      ],
      "Resource": "*",
      "Effect": "Deny"
    },
    {
      "Action": [
        "aws-portal:ModifyAccount",
        "aws-portal:ModifyBilling",
        "aws-portal:ModifyPaymentMethods"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "organizations_scp_logging_protection" {
  name = "scp_logging_services_protection"
  description = "Stops cloudtrail being turned off, protects config rules and recording, keeps guardduty active, and securityhub from being disabled."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudtrail:StopLogging",
        "cloudtrail:DeleteTrail"
      ],
      "Resource": "*",
      "Effect": "Deny"
    },
    {
      "Action": [
        "config:DeleteConfigRule",
        "config:DeleteConfigurationRecorder",
        "config:DeleteDeliveryChannel",
        "config:StopConfigurationRecorder"
      ],
      "Resource": "*",
      "Effect": "Deny"
    },
    {
      "Action": [
        "guardduty:DeleteDetector",
        "guardduty:DeleteInvitations",
        "guardduty:DeleteIPSet",
        "guardduty:DeleteMembers",
        "guardduty:DeleteThreatIntelSet",
        "guardduty:DisassociateFromMasterAccount",
        "guardduty:DisassociateMembers",
        "guardduty:StopMonitoringMembers",
        "guardduty:UpdateDetector"
      ],
      "Resource": "*",
      "Effect": "Deny"
    },
    {
      "Action": [
        "securityhub:DeleteInvitations",
        "securityhub:DisableSecurityHub",
        "securityhub:DisassociateFromMasterAccount",
        "securityhub:DeleteMembers",
        "securityhub:DisassociateMembers"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "organizations_scp_iam_protection" {
  name = "scp_iam_protection"
  description = "Stops creation of IAM users and keys - use SSO for humans and roles for machines."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateUser",
        "iam:CreateAccessKey"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Deny"
    }
  ]
}
POLICY

}

resource "aws_organizations_policy" "organizations_scp_s3_protection" {
  name = "scp_s3_protection"
  description = "Stops people allowing public S3 buckets."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutAccountPublicAccessBlock"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}


resource "aws_organizations_policy" "organizations_lambda_functionurl_protection" {
  name = "scp_lambda_function_url_protection"
  description = "Stops lambda function URLs being created without authentication through IAM."
  content = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutAccountPublicAccessBlock"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
POLICY

}
