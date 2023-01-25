# jornada-do-cluster
Exercise from Jornada Devops Elite Jan/2023

In this repository you will find example of terraform file to provision a virtual machine and a cluster on Digital Ocean Cloud.

The files are located in the directory terraform.

On `terraform.tfvars` there are some variables used by resources:

- **do_main_region**: used to set the region of the resources
- **ssh_key_name**: used to set the default SSH key name used for authentication on virtual machines

There is another variable used by the provider to authenticate the user, **do_token**.

This variable is sensitive and must be set by the user that is running the terraform.

It can be set on variables file, but there is the risk to be updloaded to repository, can be set on environment variables or be set as a parameter.

- **Environment Variable**: export the variable `TF_VAR_do_token` with your token
- **Call parameter**: call terraform with `-var "do_token=<token value>"` parameter

## Steps to execute

1. Go to terraform directory: `cd terraform`
2. Initialize terraform: `terraform init`
3. Plan your provision: `terraform plan`
4. Apply the terraform file: `terraform apply`

Don't forget to review the variables described above.

## After applying the terraform

After applying the terraform, you will see the terraform control files and a file with IP address of the virtual machine provisioned and the kubeconfig to access the cluster created.

## TODO List

- Store terraform state on cloud
- Add more resources to provision a more complex cluster / infrastructure

Good luck on your jorney!