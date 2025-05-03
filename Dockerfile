FROM alpinelinux/ansible:latest

RUN apk update && apk add vim tar python3-dev py3-pip 
RUN pip3 install boto3 botocore
# Install the required collection and role
RUN ansible-galaxy collection install community.general amazon.aws
RUN ansible-galaxy install christiangda.amazon_cloudwatch_agent

# Download and install aws_ssm connection plugin
#RUN wget https://raw.githubusercontent.com/ansible-collections/community.general/main/plugins/connection/aws_ssm.py -P /usr/lib/python3.8/site-packages/ansible/plugins/connection/


CMD ["sh"]
