{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-secret.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cluster-secret.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "cluster-secret.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cluster-secret.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-secret.labels" -}}
helm.sh/chart: {{ include "cluster-secret.chart" . }}
{{ include "cluster-secret.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-secret.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-secret.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cluster-secret.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cluster-secret.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Cluster Role Name
*/}}
{{- define "cluster-secret.cluster-role" -}}
{{ include "cluster-secret.serviceAccountName" . }}-cluster-role
{{- end }}

{{/*
Cluster Role Binding Name
*/}}
{{- define "cluster-secret.cluster-role-binding" -}}
{{ include "cluster-secret.serviceAccountName" . }}-cluster-role-binding
{{- end }}

{{/*
Namespaced Role Name
*/}}
{{- define "cluster-secret.namespaced-role" -}}
{{ include "cluster-secret.serviceAccountName" . }}-namespaced-role
{{- end }}

{{/*
Namespaced Role Binding Name
*/}}
{{- define "cluster-secret.namespaced-role-binding" -}}
{{ include "cluster-secret.serviceAccountName" . }}-namespaced-role-binding
{{- end }}
