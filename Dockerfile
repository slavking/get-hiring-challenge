FROM hashicorp/terraform:1.0.3

ENV AWS_CLI_VER=2.0.30
RUN apk update && apk add --no-cache curl gcompat zip &&  \
    curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VER}.zip -o awscliv2.zip && \
    unzip awscliv2.zip && ./aws/install

COPY aws-lambda-cron/ ./aws-lambda-cron/
COPY lambda/ ./lambda/
COPY pubkey/ ./pubkey/
COPY user_data/ ./user_data/
COPY *.tf ./
COPY terraform.tfvars ./
COPY run.sh ./
COPY README.md ./

ENTRYPOINT ["./run.sh"]