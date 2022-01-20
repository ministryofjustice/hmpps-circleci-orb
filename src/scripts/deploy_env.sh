#!/usr/bin/env bash

if [[ ${RELEASE_NAME} == "PROJECT_NAME_ENV_NAME" ]]; then
  RELEASE_NAME="${CIRCLE_PROJECT_REPONAME}-${ENV_NAME}"
elif [[ ${RELEASE_NAME} == "PROJECT_NAME" ]]; then
  RELEASE_NAME="${CIRCLE_PROJECT_REPONAME}"
fi

if [[ ${CHART_NAME} == "PROJECT_NAME" ]]; then
  CHART_NAME="${CIRCLE_PROJECT_REPONAME}"
fi

if [[ ${HELM_REPO} != "local" ]]; then
  helm repo add remote "${HELM_REPO}"
  CHART_NAME="remote/${CHART_NAME}"
else
  # this is a hack to allow seeing the actual app version in the helm release metadata
  sed -i "s/appVersion:.*/appVersion: \"${APP_VERSION}\"/g" "${CHART_NAME}/Chart.yaml"
fi

# Install/update any chart dependencies.
helm dependency update "${CHART_NAME}"

HELM_ARGS=(--wait \
  --install \
  --reset-values \
  --timeout 5m \
  --history-max 10 \
  --values "values-${ENV_NAME}.yaml")

# Set the image tag for this deployment
if helm dependency list "${CHART_NAME}" | grep generic-service --silent; then
  HELM_ARGS+=("--set" "generic-service.image.tag=${APP_VERSION}")
else
  HELM_ARGS+=("--set" "image.tag=${APP_VERSION}")
fi

read -r -a extra_args <<< "${HELM_ADDITIONAL_ARGS}"

HELM_ARGS+=("${extra_args[@]}")

if [[ ${CHART_VERSION} != "latest" ]]; then
  HELM_ARGS+=("--version" "${CHART_VERSION}")
fi

helm upgrade "${RELEASE_NAME}" "${CHART_NAME}" "${HELM_ARGS[@]}"
