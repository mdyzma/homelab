# Service Catalog

This document tracks the active services running in the Proxmox homelab, mapped to their IDs and static network configurations.

| ID | Hostname | IP Address | Purpose | Tags |
| :--- | :--- | :--- | :--- | :--- |
| 100 | **cloudflared** | 192.168.88.247 | Tunneling / Remote Access | platform, network |
| 102 | **n8n** | 192.168.88.246 | Workflow Automation | apps, automation |
| 103 | **postgresql** | 192.168.88.231 | Relational Database | platform, database |
| 105 | **minio** | 192.168.88.228 | S3 Object Storage | platform, storage |
| 106 | **prometheus** | 192.168.88.243 | Metrics Collection | platform, monitoring |
| 107 | **grafana** | 192.168.88.242 | Data Visualization | platform, monitoring |
| 108 | **paperless-ngx** | 192.168.88.241 | Document Management | apps, docs |
| 111 | **mongodb** | 192.168.88.227 | NoSQL Database | platform, database |
| 114 | **gitea** | 192.168.88.223 | Git Service | platform, devops |
| 115 | **jenkins** | 192.168.88.222 | CI/CD Automation | platform, devops |
| 116 | **ollama** | 192.168.88.216 | AI Model Backend (GPU) | apps, ai |
| 117 | **openwebui** | 192.168.88.206 | LLM Interface | apps, ai |
| 120 | **trilium** | 192.168.88.240 | Knowledge Base | apps, docs |

## Port Reference
- **OpenWebUI:** 8080
- **Ollama:** 11434
- **Gitea:** 3000
- **Grafana:** 3000
- **Prometheus:** 9090
