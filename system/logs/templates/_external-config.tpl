{{- define "external.receiver" }} # input
webhookevent/external-alerts:
  endpoint: "0.0.0.0:{{.Values.openTelemetryPlugin.openTelemetry.logsCollector.externalConfig.alertmanager_port}}"

tcplog/external-deployments:
  listen_address: "0.0.0.0:{{.Values.openTelemetryPlugin.openTelemetry.logsCollector.externalConfig.deployments_port}}"
  operators:
#  - id: type
#    type: add
#    field: attributes["log.type"]
#    value: "deployment"
{{- end }}

{{- define "external.transform" }}
transform/external-alerts:
  error_mode: ignore
  log_statements:
    - context: log
      statements:
        - merge_maps(attributes, ParseJSON(body), "upsert")
        - set(attributes["log.type"], "alert")
        - set(time_unix_nano, observed_time_unix_nano)

transform/external-deployments:
  error_mode: ignore
  log_statements:
    - context: log
      statements:
        - set(attributes["log.type"], "deployment")
        - set(time_unix_nano, observed_time_unix_nano)
{{- end }}


{{- define "external.exporter" }}
{{- range (list "alerts" "deployments") }}
opensearch/failover_a_external_{{ toString . }}:
  http:
    auth:
      authenticator: basicauth/failover_a
    endpoint: {{ $.Values.openTelemetryPlugin.openTelemetry.openSearchLogs.endpoint }}
  logs_index: {{ toString . }}-datastream
opensearch/failover_b_external_{{ toString . }}:
  http:
    auth:
      authenticator: basicauth/failover_b
    endpoint: {{ $.Values.openTelemetryPlugin.openTelemetry.openSearchLogs.endpoint }}
  logs_index: {{ toString . }}-datastream
{{- end }}
{{- end }}



{{- define "external.connectors" }}
{{- range (list "alerts" "deployments") }}
forward/external_{{ toString . }}: {}

failover/opensearch_external_{{ toString . }}:
  priority_levels:
    - [logs/failover_a_external_{{ toString . }}]
    - [logs/failover_b_external_{{ toString . }}]
  retry_interval: 1h
  retry_gap: 15m
  max_retries: 0
{{ end }}
{{- end }}

{{- define "external.pipeline" }}
{{- range (list "alerts" "deployments") }}
logs/forward_external_{{ toString . }}:
  receivers: [forward/external_{{ toString .}}]
  processors: [batch]
  exporters: [failover/opensearch_external_{{ toString . }}]

logs/failover_a_external_{{ toString . }}:
  receivers: [failover/opensearch_external_{{ toString . }}]
  processors: [attributes/failover_username_a]
  exporters: [opensearch/failover_a_external_{{ toString . }}]

logs/failover_b_external_{{ toString . }}:
  receivers: [failover/opensearch_external_{{ toString . }}]
  processors: [attributes/failover_username_b]
  exporters: [opensearch/failover_b_external_{{ toString . }}]

{{- end }}
logs/external-alerts:
  receivers: [webhookevent/external-alerts]
  processors: [transform/external-alerts]
  exporters: [debug,forward/external_alerts]

logs/external-deployments:
  receivers: [tcplog/external-deployments]
  processors: [transform/external-deployments]
  exporters: [debug,forward/external_deployments]
{{- end }}