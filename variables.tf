variable "region" {
  type        = string
  description = "Região onde os recursos do AWS serão provisionados."
}

variable "service_name" {
  type        = string
  description = "Nome do serviço a ser utilizado no ECS ou identificador similar."
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ECS onde o serviço será implantado."
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde os recursos relacionados ao serviço serão provisionados."
}

variable "private_subnets" {
  type        = list(string)
  description = "Lista de IDs das subnets privadas onde o serviço será implantado."
}

variable "service_port" {
  type        = number
  description = "Porta na qual o serviço estará acessível."
}

variable "service_cpu" {
  type        = number
  description = "Quantidade de CPU alocada para o serviço, especificada em unidades de CPU do ECS."
}

variable "service_memory" {
  type        = number
  description = "Quantidade de memória alocada para o serviço, especificada em MB."
}

variable "service_listener" {
  type        = string
  description = "ARN do listener do Application Load Balancer que será usado pelo serviço."
}

variable "service_task_execution_role" {
  type        = string
  description = "ARN da role de execução de tarefas do ECS que o serviço usará para executar."
}

variable "service_launch_type" {
  type        = string
  description = "Tipo de lançamento para o serviço no ECS, como 'FARGATE' ou 'EC2'."
}

variable "service_task_count" {
  type        = number
  description = "Número de instâncias da tarefa a serem executadas simultaneamente no serviço."
}

variable "service_hosts" {
  type        = list(string)
  description = "Lista de hosts associados ao serviço, geralmente especificados para configurações DNS."
}

variable "service_healthcheck" {
  type        = map(any)
  description = "Configuração do health check do serviço, incluindo caminho e protocolo."
}

variable "environment_variables" {
  type        = list(map(string))
  description = "Lista de variáveis de ambiente que serão passadas para o serviço."
}

variable "capabilities" {
  type        = list(string)
  description = "Lista de capacidades necessárias para a execução do serviço, como 'CAP_SYS_ADMIN' para recursos Linux específicos."
}
