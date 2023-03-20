#!/bin/bash

if [ -f "$HOME/.kube/config" ]; then
  namespace="$(kubectl config view --minify --output 'jsonpath={..namespace}'; echo)"

  if [ -n "${namespace}" ]; then
      echo -e "\nUsing namespace $(kubectl config view --minify --output 'jsonpath={..namespace}'; echo)"
  fi
fi
