#!/usr/bin/env bash

set -euo pipefail

if [[ ${CHART_NAME} == "PROJECT_NAME" ]]; then
  CHART_NAME="${CIRCLE_PROJECT_REPONAME}"
fi

helm dependency update "${CHART_NAME}"

HELM_ARGS=(--values "values-${ENV_NAME}.yaml")

if [[ -f "secrets-${ENV_NAME}.yaml" ]]; then
  HELM_ARGS+=("--values" "secrets-${ENV_NAME}.yaml")
fi

read -r -a extra_args <<<"${HELM_ADDITIONAL_ARGS}"

HELM_ARGS+=("${extra_args[@]}")

helm lint "${CHART_NAME}" "${HELM_ARGS[@]}"
