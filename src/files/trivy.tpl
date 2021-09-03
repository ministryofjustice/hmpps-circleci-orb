-------
{{- range . }}
{{- $location := .Target }}
  {{- range .Vulnerabilities }}
Severity: {{ .Severity }}
CVE: {{ .VulnerabilityID }}
Title: "{{ .Title }}"
PkgName: {{ .PkgName }}
InstalledVersion: {{ .InstalledVersion }}
FixedVersion: {{ .FixedVersion }}
Location: {{ $location }}
-------
  {{- end }}
{{- end }}
