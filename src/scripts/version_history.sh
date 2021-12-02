#!/usr/bin/env bash

# ensure consequences still work if this script blows up
touch .deployment_changelog

if [ "${K8S_DEPLOYMENT_NAME}" == "PROJECT_NAME" ]; then
  K8S_DEPLOYMENT_NAME="${CIRCLE_PROJECT_REPONAME}"
fi

current_commit="$(echo "${APP_VERSION}" | cut -d'.' -f3)"

# Try and get the currently deployed version
K8S_PREVIOUS_APP_VERSION="$(kubectl get "deployment/${K8S_DEPLOYMENT_NAME}" --namespace="${KUBE_ENV_NAMESPACE}" -o=jsonpath='{.metadata.labels.app\.kubernetes\.io/version}' || true)"

if [ "$K8S_PREVIOUS_APP_VERSION" == "" ]; then
  # if no previous version was found, set to current commit minus 1
  echo "Previous deployment not found, showing current commit only." >> .deployment_changelog
  previous_commit="${current_commit}^1"
else
  previous_commit="$(echo "${K8S_PREVIOUS_APP_VERSION}" | cut -d'.' -f3)"
fi

# Some apps may not have set the correct k8s label with a valid app version containing a sha1
# Check $previous_commit sha1 is valid
if git rev-parse --quiet --verify "${previous_commit}" &>/dev/null; then
  PAGER="cat" git log --oneline --no-decorate \
    --pretty=format:'%h %s (%cr)' --committer='noreply@github.com' --grep='#' \
    "${previous_commit}..${current_commit}" \
    | sed 's/Merge pull request /PR /g; s|from ministryofjustice/dependabot/|:dependabot:|g; s|from ministryofjustice/||g' \
    >> .deployment_changelog
else
  echo "Changelog not available." > .deployment_changelog
fi

cat .deployment_changelog
