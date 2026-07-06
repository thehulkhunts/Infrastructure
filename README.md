# Infrastructure
Terraform Infrastructure for AWS Cloud 


terraform-infra/
├── README.md
├── .gitignore
├── .terraform-version                  # tfenv version pinning
├── Makefile                            # wrapper commands (init/plan/apply per env)
│
├── modules/                            # Reusable, versioned building blocks
│   ├── networking/
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   ├── versions.tf
│   │   │   └── README.md
│   │   ├── subnets/
│   │   ├── nat-gateway/
│   │   ├── transit-gateway/
│   │   └── vpn/
│   │
│   ├── compute/
│   │   ├── ec2/
│   │   ├── asg/
│   │   ├── eks/
│   │   └── lambda/
│   │
│   ├── database/
│   │   ├── rds/
│   │   ├── dynamodb/
│   │   └── elasticache/
│   │
│   ├── security/
│   │   ├── iam-roles/
│   │   ├── iam-policies/
│   │   ├── kms/
│   │   ├── security-groups/
│   │   └── waf/
│   │
│   ├── storage/
│   │   ├── s3/
│   │   └── efs/
│   │
│   ├── monitoring/
│   │   ├── cloudwatch/
│   │   ├── sns-alerts/
│   │   └── datadog/
│   │
│   └── dns/
│       └── route53/
│
├── environments/                       # Root modules per env/region/account
│   ├── global/                         # Account-wide resources (IAM, Org, billing)
│   │   ├── iam/
│   │   ├── organizations/
│   │   └── backend.tf
│   │
│   ├── dev/
│   │   ├── us-east-1/
│   │   │   ├── networking/
│   │   │   │   ├── main.tf
│   │   │   │   ├── variables.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── terraform.tfvars
│   │   │   │   └── backend.tf
│   │   │   ├── compute/
│   │   │   ├── database/
│   │   │   └── security/
│   │   └── us-west-2/
│   │
│   ├── staging/
│   │   └── us-east-1/
│   │       ├── networking/
│   │       ├── compute/
│   │       ├── database/
│   │       └── security/
│   │
│   └── prod/
│       ├── us-east-1/
│       │   ├── networking/
│       │   ├── compute/
│       │   ├── database/
│       │   └── security/
│       └── eu-west-1/               # DR region
│
├── shared/                             # Cross-env shared configs
│   ├── providers.tf
│   ├── versions.tf
│   └── locals.tf
│
├── policies/                           # OPA / Sentinel / Checkov rules
│   ├── sentinel/
│   └── opa/
│
├── scripts/                            # Automation helpers
│   ├── init-backend.sh
│   ├── validate.sh
│   ├── plan-all.sh
│   └── cost-estimate.sh
│
├── tests/                              # Terratest / native tf test
│   ├── networking_test.go
│   └── compute_test.go
│
└── .github/                            # or .gitlab-ci, azure-pipelines
    └── workflows/
        ├── terraform-plan.yml
        ├── terraform-apply.yml
        └── terraform-drift-check.yml

Terraaform Directory Structure 

How industry standards takes place while deploying infra:-

Pull Request opened  →  terraform fmt + validate + plan  →  plan posted as PR comment
                                                              (humans review the plan)
PR merged to main     →  terraform apply  →  infra changes go live


Please find the following link for CI/CD using github Actions:
1) https://claude.ai/share/6e241848-1040-4281-a5b3-cbfe7e91c801

You cant use AWS credentials in github actions, instead use OIDC and Roles for it..
please find the rference link in the below:

2) https://claude.ai/share/6e241848-1040-4281-a5b3-cbfe7e91c801