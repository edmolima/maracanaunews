# Terraform Module Documentation

This documentation is auto-generated using [terraform-docs](https://terraform-docs.io/).


## Usage
Run the following command in the `infra/` directory to update this file:

```sh
terraform-docs markdown . > terraform-docs.md
```

## Lambda Source
- Lambda source code is in `packages/`
- Zipped artifacts are in `lambdas/` (built by CI/CD or composite action)
- See `.github/workflows/` and `.github/actions/` for build/zip automation

## Modules
- sqs
- dynamodb
- cloudwatch
- eventbridge
- lambda
- iam

See each module's `variables.tf` and `outputs.tf` for details.
