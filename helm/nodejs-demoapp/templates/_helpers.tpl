{{- define "nodejs-demoapp.app_name" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}
