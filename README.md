# oyd-exercise-7-1 — Módulo Reutilizable de Colas SQS

**Curso:** Optimizaciones y Desempeño — Automatización de Despliegue en la Nube  
**Sesión:** 7 — 4 de junio de 2026

## Descripción

Módulo de Terraform reutilizable que provisiona una **cola SQS principal** y su **Cola de Mensajes Muertos (DLQ)** con una sola llamada. La configuración raíz apunta al entorno `dev` mediante un archivo `.tfvars`.

## Estructura del Repositorio

```
infra/
├── provider.tf                  # Proveedor AWS (us-east-1, ~> 5.0)
├── main.tf                      # Configuración raíz — llama al módulo queue
├── variables.tf                 # Variables de entrada raíz
├── envs/
│   └── dev/
│       └── dev.tfvars           # Valores para el entorno de desarrollo
└── modules/
    └── queue/                   # Módulo reutilizable de colas
        ├── main.tf              # Recursos DLQ + cola principal
        ├── variables.tf         # Variables de entrada del módulo
        └── outputs.tf           # queue_url, queue_arn, dlq_url, dlq_arn
evidence/
└── outputs.txt                  # Salida de terraform output capturada tras el apply
```

## Requisitos Previos

- Terraform >= 1.3 instalado
- Credenciales de AWS configuradas (`~/.aws/credentials` o variables de entorno)
- Cuenta de AWS con permisos para crear colas SQS

## Comandos

```bash
# 1. Entrar al directorio de infra
cd infra

# 2. Inicializar proveedores y módulos
terraform init

# 3. Ver el plan de ejecución
terraform plan -var-file=envs/dev/dev.tfvars

# 4. Aplicar (crea 2 colas SQS en AWS)
terraform apply -var-file=envs/dev/dev.tfvars

# 5. Capturar la salida como evidencia
terraform output > ../evidence/outputs.txt

# 6. Destruir los recursos cuando ya no sean necesarios
terraform destroy -var-file=envs/dev/dev.tfvars
```

## Variables del Módulo

| Variable | Tipo | Descripción |
|---|---|---|
| `queue_name` | string | Prefijo de nombre para la cola y su DLQ |
| `max_receive_count` | number | Número máximo de recepciones antes de mover el mensaje a la DLQ |
| `message_retention_seconds` | number | Tiempo (en segundos) que la DLQ retiene un mensaje |
| `visibility_timeout_seconds` | number | Tiempo de invisibilidad del mensaje en la cola principal |

## Salidas del Módulo

| Salida | Descripción |
|---|---|
| `queue_url` | URL de la cola SQS principal |
| `queue_arn` | ARN de la cola SQS principal |
| `dlq_url` | URL de la cola de mensajes muertos |
| `dlq_arn` | ARN de la cola de mensajes muertos |