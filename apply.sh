#!/usr/bin/env bash

set -e

. .common

rm -rf ./k8s/*\.yaml

if [ ! -f k8s/.secret ]
then
  echo "Generating PyPi Secret..."
  PYPI_PASSWORD=$(openssl rand 32 | shasum -a 256 | cut -d ' ' -f 1)
  echo "export PYPI_USERNAME=stella" >> k8s/.secret
  echo "export PYPI_PASSWORD=$PYPI_PASSWORD" >> k8s/.secret
fi

source k8s/.secret

for f in t8s.*.yaml
do
  f_bust=$(echo "$f" | sed 's/^t8s\./k8s\//')
  echo "Creating $f_bust"
  envsubst < "$f" > "$f_bust"
done

kubectl apply -f k8s/

pod_name_expr='.items[] | select(.metadata.labels.app == "pypiserver").metadata.name'
POD_NAME="$(kubectl get pods --output=json | jq -rc "$pod_name_expr")"
echo "Deployed Pod: $POD_NAME"
echo "To forward $PYPI_IMAGE from k8s please run: kubectl port-forward pod/$POD_NAME 8080:80 --address 0.0.0.0"
