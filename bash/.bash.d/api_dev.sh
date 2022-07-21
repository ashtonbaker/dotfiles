# Script that exports functions for talking to our microservices' APIs
# Remember: you must have an sshuttle connection running for these to work!
# Replace value for TOKEN_DEV_API (and, optionally, ACTING_PERSON) as necessary
export HTTP_CLIENT_TIMEOUT=300

hit_api() {
    baseurl=$1;
    path=${2:-'health'};
    method=$3;
    http --timeout $HTTP_CLIENT_TIMEOUT \
        ${method} http://${baseurl}/${path} \
        "x-blu-acting-person:$ACTING_PERSON" \
        "Authorization:Bearer $TOKEN_DEV_API" ;
}

api_local () { hit_api '0.0.0.0:8080/v1.0' $1 $2; }
fea_local() { hit_api '0.0.0.0:8090' $1 $2; }
fea_local_docker() { hit_api '0.0.0.0:8080' $1 $2; }

account_d () { hit_api 'account/v1.0' $1 $2; }
config_d () { hit_api 'config/v1.0' $1 $2; }
finding_d () { hit_api 'finding/v1.0' $1 $2; }
kb_d () { hit_api 'kb/v1.0' $1 $2; }
report_d () { hit_api 'report/v1.0' $1 $2; }
sensor_d () { hit_api 'sensor/v1.0' $1 $2; }
tag_d () { hit_api 'tag/v1.0' $1 $2; }
