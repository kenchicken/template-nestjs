---
to: <%= rootDirectory %>/deployment/scripts/after_install.sh
force: true
---
#!/usr/bin/env bash

# Please Edit
region=ap-northeast-1
owner=undo-dev
group=undo-admin
pj_root=anyteam-api

# Please do not edit
pj_dir=/usr/src/${pj_root}
token=$(curl --request PUT "http://169.254.169.254/latest/api/token" --header "X-aws-ec2-metadata-token-ttl-seconds: 3600")
instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id --header "X-aws-ec2-metadata-token: $token")
environment=$(aws --region=${region} ec2 describe-tags \
  --filters="Name=resource-id,Values=${instance_id}" \
  --query='Tags[?Key==`Environment`].Value' --output=text)
role=$(aws --region=${region} ec2 describe-tags \
  --filters="Name=resource-id,Values=${instance_id}" \
  --query='Tags[?Key==`Role`].Value' --output=text)

# Function
## Error handling
function error_handler() {
  if [ "$?" != "0" ]; then
    echo 'Error!!'
    exit 1
  fi
}

## Generate .env file
##
## Arguments:
##   $1: application_type
##   $2: directory
function generate_env() {
  echo "---> current .env file is for $1"
  aws --region=${region} ssm get-parameter \
    --name=/anyteam-api/${environment}/env/$1 \
    --query=Parameter.Value \
    --output=text \
    --with-decryption | base64 --decode > ${pj_dir}/$2/.env
  error_handler
  echo -n -e "\n" >> ${pj_dir}/$2/.env
}


# Process
echo 'Change directory to pj_dir'
cd ${pj_dir} || exit

# generate .env
echo 'Generate api .env file'
generate_env api api

# yarn install & build for api
cd ${pj_dir}/api
echo 'Run `npm install` for api'
npm install
error_handlera
echo 'Run npm install for sharp'
npm install --include=optional sharp
error_handlera
npm install --os=linux --cpu=x64 sharp
error_handlera
echo 'Run `npm build` for api'
npm run build
error_handler
#echo 'Change log permission for api'
#chmod -R 777 ${pj_dir}/api/log
#error_handler
# migration
echo 'Run `typeorm:run-migrations`'
npm run typeorm:run-migrations
error_handler

cd ${pj_dir}/api
npm install -g pm2
error_handler
pm2 --version

echo 'Run `pm2 start` for cms'
pm2 start npm --name anyteam-api -- run start
error_handler

# set nginx config
echo 'Link to Nginx config'
ln -nfs ${pj_dir}/deployment/conf/nginx/${environment}/api.conf /etc/nginx/conf.d/api.conf
error_handler

echo 'Check nginx config'
sudo nginx -t
error_handler

echo 'Reload nginx Processes'
sudo nginx -s reload
error_handler
