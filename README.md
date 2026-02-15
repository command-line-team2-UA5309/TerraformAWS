# Template

## How to set up pre-commit hooks

1. Install pre-commit from <https://pre-commit.com/#install>
2. Run `pre-commit install`
3. Auto-update the config to the latest version `pre-commit autoupdate`

## Getting Started with Terraform and AWS

### 1. Installing Terraform

Install Terraform using one of the methods following the instructions
from the official website:
<https://developer.hashicorp.com/terraform/install>

### 2. Installing AWS CLI

To interact with AWS, install AWS CLI:
<https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>

### 3. Configuring access

After installing the tools, configure access to your account.

**Configure credentials:**

```bash
aws configure
```

**Enter your data:**

- AWS Access Key ID: Your ID
- AWS Secret Access Key: Your Secret Key
- Default region name: eu-north-1
- Default output format: json

#### AWS profile activation

```bash
# Linux / macOS / Git Bash
export AWS_PROFILE=my-project-profile

# PowerShell (Windows)
$env:AWS_PROFILE = "my-project-profile"

# CMD (Windows)
set AWS_PROFILE=my-project-profile
```

**Check the connection to AWS:**

```bash
aws sts get-caller-identity
```

### 4. Starting the project

#### SSH Key Configuration

To run the terraform apply command and ensure the public key is
attached to your instances, you must specify the path to your
public key. To access these instances later via SSH, you will
need the corresponding private key.

Update the Configuration: In the file FlaskPictureAp-tf/main.tf,
locate the aws_key_pair resource and provide the path to your
public key file:

```terraform
resource "aws_key_pair" "bird_key" {
  key_name = "${var.project_name}-${var.env}-key"
  public_key = file("path/to/your/public_key.pub")
}
```

#### Accessing Keys

Please contact your Team Lead to receive both the private and
public keys.

#### Running Terraform

```bash
terraform init
terraform plan
terraform apply
```
