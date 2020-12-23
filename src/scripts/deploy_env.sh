#!/usr/bin/env bash

if [[ ${CHART_VERSION} != "latest" ]]; then
  CHART_VERSION_ARG="--version ${CHART_VERSION}"
fi

if [[ ${HELM_REPO} != "local" ]]; then
  helm repo add remote "${HELM_REPO}"
  CHART_NAME="remote/${CHART_NAME}"
else
  sed -i "s/appVersion: \".*\"/appVersion: \"${APP_VERSION}\"/g" "${CHART_NAME}/Chart.yaml"
fi

# Install/update any chart dependencies.
helm dependency update "${CHART_NAME}"

HELM_ARGS=("${CHART_VERSION_ARG}" \
  --wait \
  --install \
  --reset-values \
  --timeout 5m \
  --history-max 10 \
  --values "values-${ENV_NAME}.yaml" \
  --set image.tag="${APP_VERSION}" \
  "${HELM_ADDITIONAL_ARGS}")

if [[ "${RETRIEVE_SECRETS}" == 'aws' ]]; then
  # Load secrets from AWS secrets manager and have helm read values from stdin
  aws secretsmanager get-secret-value --secret-id "${AWS_SECRET_NAME}" | jq -r .SecretString | \
  helm upgrade "${RELEASE_NAME}" "${CHART_NAME}" --values - "${HELM_ARGS[@]}"
else
  helm upgrade "${RELEASE_NAME}" "${CHART_NAME}" "${HELM_ARGS[@]}"
fi