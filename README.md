# Infrastructure

This repository contains the entire project IaC configuration in Terraform. Each module
represents infrastructure for every specific component of the project. Currently the following
modules are implemented:

* common &mdash Common infrastructure configuration. The module configures assers for the
  pipeline and the common runtime.

## Testing changes localy

Clone the repository and run the following

```bash
$ terraform init
$ terraform plan
```

## Applying changes

We aim to apply all changes automatically using GitHub workflows. If there is a good reason
to apply changes from your local environment run the following to create a plan

```bash
$ terraform init
$ terraform plan -out tf_plan
```

After carefuly reviewing the changes you may apply them by running

```bash
$ terraform apply tf_plan
```

## Code style

We aim to keep the IaC code style consistent and up to the high standards. To ensure the code
is properly formatted please run the following before you commit

```bash
$ terraform fmt --recursive
```

Afterwards make sure that the following naming conventions are followed:

* Terraform objects like resources, data sources and outputs are named snake case.
* AWS resources are named using kebab case.

All names must be descriptive and use proper English words.
