# Getting Started with AWS SDK (boto3) and Rapid7 Products

1. Create [AWS free-tier account](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc) 

2. Install [brew](https://brew.sh/)
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

3. Install python SDK [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html)
```bash
brew install python3
python3 -m pip install --upgrade pip
python3 -m pip install boto3
python3 -m pip install boto3 botostubs
```

4. Set Up Access in [IAM](https://console.aws.amazon.com/iam/)
    - Delete your root access keys
    - Activate MFA on your root account (Okta works great)
    - Create and Apply IAM password policy
    - Create Individual IAM User
        - Provide username 
        - Grant programmatic access and AWS Management Conosle Access
        - Set password
        - Uncheck require password reset.
    - Create Group
        - Provide Group Name
        - Grant full AdministratorAccess 
    - Take note of and or securely store:
        - Access key ID
        - Secret

5. Set up Dev Env
- Install [VS Code](https://code.visualstudio.com/)
- Install the [Python extension for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- At the top of your Python script file: 
```python
import botostubs, boto3
```
- When declaring a boto3 client object, add a type hint comment: 
```python
iam = boto3.client('iam') # type: botostubs.IAM
```
- Disbale the default Jedi python engine in VS Code settings.json
```json
"python.jediEnabled": false
```

Write up of the steps can be found below:
[Enable Intellisense for AWS Boto3 Type Hints in Microsoft Visual Studio Code](https://trevorsullivan.net/2019/06/11/intellisense-microsoft-vscode-aws-boto3-python/)

6. Create AWS Credential File
```bash
mkdir -p ~/.aws/ 
cd ~/.aws/ 
touch credentials
code credentials
```
Add the following lines to credentials file (Make sure you save it!!!):
```bash
[default]
aws_access_key_id=MYACCESSKEYHERE
aws_secret_access_key=MYSUPERSECRETACCESSKEYHERE
```

7. Kicking the Tires

Create new .py file containing the following code
```python
import botostubs, boto3

s3 = boto3.client('s3') # type: botostubs.S3
s3.create_bucket(Bucket="myboto3createdbucket")
response = s3.list_buckets()
print("Existing S3 buckets....")

# Repsonse is of type dict
for bucket in response['Buckets']:
    print(f'{bucket["Name"]}')
```
Execute your code:
```bash
python3 MYCODESNIPPET.py
```
#### Expected Output
```bash
Existing S3 buckets....
myboto3createdbucket
```

## Rapid7 trials Getting Started 
1. [InsightVM](./DeployIVM.py)
    * Ensure you have followed the steps above
    * Are running code from MAC management laptop
    * Ensure you have internet access (I have to state this :|)