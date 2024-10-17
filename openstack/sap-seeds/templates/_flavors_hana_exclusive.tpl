# Cascade-Lake HANA Flavors
- name: "hana_c24_m365"
  id: "300"
  vcpus: 24
  ram: 373352
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "24"  # used in nova-vmware as cores-per-socket (12pCPU = 24vCPU)
    "reservation:cpu": "22"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c48_m729"
  id: "301"
  vcpus: 48
  ram: 746720
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "48"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "45"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c96_m1458"
  id: "302"
  vcpus: 96
  ram: 1493460
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "48"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "91"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c144_m2188"
  id: "303"
  vcpus: 144
  ram: 2240196
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "48"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "136"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c192_m2917"
  id: "304"
  vcpus: 192
  ram: 2986936
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "48"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "182"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c384_m5835"
  id: "305"
  vcpus: 384
  ram: 5975024
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "48"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "364"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c288_m4377"
  id: "311"
  vcpus: 288
  ram: 4481528
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C48_M729": "required"
    "hw:cpu_cores": "48"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "273"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c448_m11671"
  id: "313"
  vcpus: 448
  ram: 11950772
  disk: 64
  extra_specs:
    {{- tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C56_M1459": "required"
    "hw:cpu_cores": "56"  # used in nova-vmware as cores-per-socket (24pCPU = 48vCPU)
    "reservation:cpu": "425"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}

# Sapphire-Rapids HANA Flavors
- name: "hana_c30_m240_v2"
  id: "320"
  vcpus: 30
  ram: 245760
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M480": "required"
    "hw:cpu_cores": "30"   # used in nova-vmware as cores-per-socket (15pCPU = 30vCPU)
    "reservation:cpu": "28"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c60_m480_v2"
  id: "321"
  vcpus: 60
  ram: 491520
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M480": "required"
    "hw:cpu_cores": "60"   # used in nova-vmware as cores-per-socket (30pCPU = 60vCPU)
    "reservation:cpu": "57"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c120_m960_v2"
  id: "322"
  vcpus: 120
  ram: 983040
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M480": "required"
    "hw:cpu_cores": "60"   # used in nova-vmware as cores-per-socket (30pCPU = 60vCPU)
    "reservation:cpu": "114"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c30_m480_v2"
  id: "323"
  vcpus: 30
  ram: 491520
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M960": "required"
    "hw:cpu_cores": "30"   # used in nova-vmware as cores-per-socket (15pCPU = 30vCPU)
    "reservation:cpu": "28"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c60_m960_v2"
  id: "324"
  vcpus: 60
  ram: 983040
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M960": "required"
    "hw:cpu_cores": "60"   # used in nova-vmware as cores-per-socket (30pCPU = 60vCPU)
    "reservation:cpu": "57"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c120_m1920_v2"
  id: "325"
  vcpus: 120
  ram: 1966080
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M960": "required"
    "hw:cpu_cores": "60"   # used in nova-vmware as cores-per-socket (30pCPU = 60vCPU)
    "reservation:cpu": "114"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c180_m2880_v2"
  id: "326"
  vcpus: 180
  ram: 2949120
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M960": "required"
    "hw:cpu_cores": "60"   # used in nova-vmware as cores-per-socket (30pCPU = 60vCPU)
    "reservation:cpu": "171"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
- name: "hana_c240_m3840_v2"
  id: "327"
  vcpus: 240
  ram: 3932160
  disk: 64
  extra_specs:
    {{ tuple . "vmware_hana_exclusive" | include "sap_seeds.helpers.extra_specs" | indent 4 }}
    "trait:CUSTOM_NUMASIZE_C60_M960": "required"
    "hw:cpu_cores": "60"   # used in nova-vmware as cores-per-socket (30pCPU = 60vCPU)
    "reservation:cpu": "228"
    {{- if ( .Values.hana_flavors_quota_separate ) }}
    "quota:instance_only": "true"
    "quota:separate": "true"
    {{- end }}
