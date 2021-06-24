#!/usr/bin/env bash
set -e

if [ "$K8S_DEPLOYMENT_NAME" == "PROJECT_NAME" ]; then
  K8S_DEPLOYMENT_NAME="$CIRCLE_PROJECT_REPONAME"
fi

if [ "$K8S_PREVIOUS_APP_VERSION" == "" ]; then
  K8S_PREVIOUS_APP_VERSION="$(kubectl get "deployment/$K8S_DEPLOYMENT_NAME" --namespace="$KUBE_ENV_NAMESPACE" -o=jsonpath='{.metadata.labels.app\.kubernetes\.io/version}')"
fi

previous_commit="$(echo "$K8S_PREVIOUS_APP_VERSION" | cut -d'.' -f3)"
current_commit="$(echo "$APP_VERSION" | cut -d'.' -f3)"

PAGER="cat" git log --oneline --no-decorate \
  --committer='noreply@github.com' --grep='#' \
  "$previous_commit..$current_commit" \
  > .deployment_changelog

cat .deployment_changelog
