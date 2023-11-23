{{- define "share_netapp_ensure" -}}
{{$share := index . 1 -}}
{{with index . 0}}
kind: Deployment
apiVersion: apps/v1
metadata:
  name: {{ .Release.Name }}-share-netapp-{{$share.name}}-ensure
  labels:
    system: openstack
    component: manila
spec:
  replicas: {{ .Values.pod.replicas.ensure }}
  revisionHistoryLimit: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 0
      maxSurge: 1
  selector:
    matchLabels:
        name: {{ .Release.Name }}-share-netapp-{{$share.name}}-ensure
  template:
    metadata:
      labels:
        name: {{ .Release.Name }}-share-netapp-{{$share.name}}-ensure
        alert-tier: os
        alert-service: manila
      annotations:
        configmap-etc-hash: {{ include (print .Template.BasePath "/etc-configmap.yaml") . | sha256sum }}
        configmap-netapp-hash: {{ list . $share | include "share_netapp_configmap" | sha256sum }}
        netapp_deployment-hash: {{ list . $share | include "share_netapp" | sha256sum }}
    spec:
      affinity:
        podAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: name
                  operator: In
                  values:
                  - {{ .Release.Name }}-share-netapp-{{$share.name}}
              topologyKey: kubernetes.io/hostname
      initContainers:
      {{- tuple . (dict "service" (print .Release.Name "-mariadb")) | include "utils.snippets.kubernetes_entrypoint_init_container" | indent 8 }}
      containers:
        - name: reexport
          image: "{{.Values.global.registry}}/loci-manila:{{.Values.loci.imageVersion}}"
          imagePullPolicy: IfNotPresent
          command:
            - dumb-init
            {{- if .Values.pyreloader_enabled }}
            - pyreloader
            {{- end }}
            - manila-share
            - --config-file
            - /etc/manila/manila.conf
            - --config-file
            - /etc/manila/backend.conf
            - --reexport
          env:
            {{- if .Values.sentry.enabled }}
            - name: SENTRY_DSN_SSL
              valueFrom:
                secretKeyRef:
                  name: sentry
                  key: manila.DSN
            - name: SENTRY_DSN
              value: $(SENTRY_DSN_SSL)?verify_ssl=0
            {{- end }}
          volumeMounts:
            - mountPath: /manila-etc
              name: manila-etc
            - name: etcmanila
              mountPath: /etc/manila
            - name: manila-etc
              mountPath: /etc/manila/manila.conf
              subPath: manila.conf
              readOnly: true
            - name: manila-etc
              mountPath: /etc/manila/logging.ini
              subPath: logging.ini
              readOnly: true
            - name: backend-config
              mountPath: /etc/manila/backend.conf
              subPath: backend.conf
              readOnly: true
            {{- include "utils.proxysql.volume_mount" . | indent 12 }}
            {{- include "utils.trust_bundle.volume_mount" . | indent 12 }}
          {{- if .Values.pod.resources.share_ensure }}
          resources:
            {{ toYaml .Values.pod.resources.share_ensure | nindent 13 }}
          {{- end }}
          livenessProbe:
            exec:
              command:
              - cat
              - /etc/manila/probe
            timeoutSeconds: 3
            periodSeconds: 10
            initialDelaySeconds: 15
          readinessProbe:
            exec:
              command:
              - cat
              - /etc/manila/probe
            timeoutSeconds: 3
            periodSeconds: 5
            initialDelaySeconds: 5
        {{- include "jaeger_agent_sidecar" . | indent 8 }}
        {{- include "utils.proxysql.container" . | indent 8 }}
      volumes:
        - name: etcmanila
          emptyDir: {}
        - name: manila-etc
          configMap:
            name: manila-etc
        - name: backend-config
          configMap:
            name: {{ .Release.Name }}-share-netapp-{{$share.name}}
        {{- include "utils.proxysql.volumes" . | indent 8 }}
        {{- include "utils.trust_bundle.volumes" . | indent 8 }}
{{ end }}
{{- end -}}
