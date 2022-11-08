{{/* Thanos image. */}}
{{- define "thanosimage" -}}
{{- required ".Values.spec.baseImage missing" .Values.spec.baseImage -}}:{{- required ".Chart.appVersion missing" .Chart.AppVersion -}}
{{- end -}}

{{/* Thanos combined name */}}
{{- define "thanos.name" -}}
{{- $name := index . 0 -}}
{{- $root := index . 1 -}}
{{- if and (not $root.Values.names) (not $root.Values.global.targets) (not $root.Values.name) -}}
{{- fail "Connot create any Thanos resource. Please define a name or at least one list element to names or global.targets" -}}
{{- end -}}
{{- if $root.Values.vmware -}}
{{- $vropshostname := split "." $name -}}
vmware-{{ $vropshostname._0 | trimPrefix "vrops-" }}
{{- else -}}
{{- $name -}}
{{- end -}}
{{- end -}}

{{/* Thanos combined name */}}
{{- define "thanos.fullName" -}}
{{- $name := index . 0 -}}
{{- $root := index . 1 -}}
{{- if $root.Values.vmware -}}
{{- $vropshostname := split "." $name -}}
thanos-vmware-{{ $vropshostname._0 | trimPrefix "vrops-" }}
{{- else -}}
thanos-{{- $name -}}
{{- end -}}
{{- end -}}

{{/* External URL of this Thanos. */}}
{{- define "thanos.externalURL" -}}
{{- $name := index . 0 -}}
{{- $root := index . 1 -}}
{{- $name -}}.{{- required "$root.Values.global.region missing" $root.Values.global.region -}}.{{- required "$root.Values.global.domain missing" $root.Values.global.domain -}}
{{- end -}}

{{/* External gRPC URL of this Thanos. */}}
{{- define "thanos.externalGrpcURL" -}}
{{- $name := index . 0 -}}
{{- $root := index . 1 -}}
{{- $name -}}-grpc.{{- required "$root.Values.global.region missing" $root.Values.global.region -}}.{{- required "$root.Values.global.domain missing" $root.Values.global.domain -}}
{{- end -}}

{{- define "fqdnHelper" -}}
{{- $host := index . 0 -}}
{{- $root := index . 1 -}}
{{- if not $root.Values.ingress.hosts -}}
thanos-{{- $host -}}.{{- required ".Values.global.region missing" $root.Values.global.region -}}.{{- required ".Values.global.domain missing" $root.Values.global.domain -}}
{{- else -}}
{{- $host -}}.{{- required ".Values.global.region missing" $root.Values.global.region -}}.{{- required ".Values.global.domain missing" $root.Values.global.domain -}}
{{- end -}}
{{- end -}}


{{- define "thanos.objectStorageConfig.name" -}}
{{- $name := index . 0 -}}
{{- $root := index . 1 -}}
prometheus-{{- include "thanos.name" . -}}-thanos-storage-config
{{- end -}}