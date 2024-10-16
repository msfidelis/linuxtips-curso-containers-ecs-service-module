variable "region" {
  type        = string
  description = "Região onde os recursos do AWS serão provisionados."
}

variable "service_name" {
  type        = string
  description = "Nome do serviço a ser utilizado no ECS ou identificador similar."
}

variable "container_image" {
  type        = string
  description = "Imagem com tag para deployment da aplicação no ECS"
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

variable "use_lb" {
  type        = bool
  default     = true
  description = "Habilita a exposição do serviço via load balancer"
}

variable "service_protocol" {
  description = "Protocolo de serviço utilizado, como http, https, grpc ou tcp."
  type        = string
  default     = null
}

variable "protocol" {
  description = "Protocolo a ser usado nas comunicações, como tcp ou udp."
  type        = string
  default     = "tcp"
}

variable "use_service_connect" {
  description = "Habilita ou desabilita o uso do Service Connect."
  type        = bool
  default     = false
}

variable "deployment_controller" {
  type    = string
  default = "ECS"
  description = "Define o tipo de controlador de deployment. O padrão é ECS. Aceita os valores ECS e CODE_DEPLOY"
}

variable "codedeploy_strategy" {
  type    = string
  default = "CodeDeployDefault.ECSAllAtOnce"
  description = "Define a estratégia de deployment do CodeDeploy. O padrão é ECSAllAtOnce."
}

variable "codedeploy_deployment_option" {
  type    = string
  default = "WITH_TRAFFIC_CONTROL"
  description = "Define a opção de deployment para o CodeDeploy. O padrão é WITH_TRAFFIC_CONTROL."
}

variable "codedeploy_deployment_type" {
  type    = string
  default = "BLUE_GREEN"
  description = "Define o tipo de deployment do CodeDeploy. O padrão é BLUE_GREEN."
}

variable "codedeploy_termination_wait_time_in_minutes" {
  type    = number
  default = 5
  description = "Define o tempo de espera, em minutos, para a terminação das tasks antigas em um deployment BLUE/GREEN. O padrão é 5 minutos."
}

variable "codedeploy_rollback_alarm" {
  type = bool
  default = true
  description = "Define se o rollback será acionado com base em alarmes do CloudWatch. O padrão é true."
}

variable "codedeploy_rollback_error_threshold" {
  type    = number
  default = 10
  description = "Define o limite percentual de erros que aciona o rollback. O padrão é 10%."
}

variable "codedeploy_rollback_error_period" {
  type = number
  default = 60
  description = "Define o período de tempo, em segundos, para avaliar o erro durante o rollback. O padrão é 60 segundos."
}

variable "codedeploy_rollback_error_evaluation_period" {
  type    = number
  default = 1
  description = "Define o número de períodos de avaliação antes de acionar o rollback. O padrão é 1 período."
}

variable "service_connect_name" {
  description = "Nome do Service Connect."
  type        = string
  default     = null
}

variable "service_connect_arn" {
  description = "ARN do Service Connect."
  type        = string
  default     = null
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
  default     = null
  description = "ARN do listener do Application Load Balancer que será usado pelo serviço."
}

variable "service_task_execution_role" {
  type        = string
  description = "ARN da role de execução de tarefas do ECS que o serviço usará para executar."
}

variable "service_launch_type" {
  description = "Configuração dos Launch Types pelos capacity providers disponíveis no cluster"
  type = list(object({
    capacity_provider = string
    weight            = number
  }))
  default = [{
    capacity_provider = "SPOT"
    weight            = 100
  }]
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
  type = list(object({
    name : string
    value : string
  }))
  description = "Lista de variáveis de ambiente que serão passadas para o serviço."
  default     = []
}

variable "secrets" {
  type = list(object({
    name : string
    valueFrom : string
  }))
  description = "Lista de secrets do parameter store ou do secrets manager"
  default     = []
}

variable "capabilities" {
  type        = list(string)
  default     = []
  description = "Lista de capacidades, como EC2 ou FARGATE"
}

variable "scale_type" {
  type        = string
  description = "Tipo de escalabilidade, como 'cpu', 'cpu_tracking' ou 'requests_tracking'."
  default     = null
}

variable "task_minimum" {
  type        = number
  description = "Número mínimo de tarefas que devem ser executadas pelo serviço."
  default     = 3
}

variable "task_maximum" {
  type        = number
  description = "Número máximo de tarefas que podem ser executadas pelo serviço."
  default     = 10
}


variable "scale_out_cpu_threshold" {
  type        = number
  description = "Valor de limiar de utilização de CPU que, quando excedido, aciona uma ação de escala para cima, em percentual."
  default     = 80
}

variable "scale_out_adjustment" {
  type        = number
  description = "Quantidade de tarefas para aumentar durante uma ação de escala para cima."
  default     = 1
}

variable "scale_out_comparison_operator" {
  type        = string
  description = "Operador de comparação usado para a condição de escala para cima, como 'GreaterThanOrEqualToThreshold'."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "scale_out_statistic" {
  type        = string
  description = "Estatística usada para a condição de escala para cima, como 'Average' ou 'Sum'."
  default     = "Average"
}

variable "scale_out_period" {
  type        = number
  description = "Duração do período de avaliação para escala para cima, em segundos."
  default     = 60
}

variable "scale_out_evaluation_periods" {
  type        = number
  description = "Número de períodos de avaliação necessários para acionar uma escala para cima."
  default     = 2
}

variable "scale_out_cooldown" {
  type        = number
  description = "Período de cooldown após uma ação de escala para cima, em segundos."
  default     = 60
}

variable "scale_in_cpu_threshold" {
  type        = number
  description = "Valor de limiar de utilização de CPU que, quando abaixo, aciona uma ação de escala para baixo, em percentual."
  default     = 30
}

variable "scale_in_adjustment" {
  type        = number
  description = "Quantidade de tarefas para reduzir durante uma ação de escala para baixo."
  default     = -1
}

variable "scale_in_comparison_operator" {
  type        = string
  description = "Operador de comparação usado para a condição de escala para baixo, como 'LessThanOrEqualToThreshold'."
  default     = "LessThanOrEqualToThreshold"
}

variable "scale_in_statistic" {
  type        = string
  description = "Estatística usada para a condição de escala para baixo, como 'Average' ou 'Sum'."
  default     = "Average"
}

variable "scale_in_period" {
  type        = number
  description = "Duração do período de avaliação para escala para baixo, em segundos."
  default     = 120
}

variable "scale_in_evaluation_periods" {
  type        = number
  description = "Número de períodos de avaliação necessários para acionar uma escala para baixo."
  default     = 3
}

variable "scale_in_cooldown" {
  type        = number
  description = "Período de cooldown após uma ação de escala para baixo, em segundos."
  default     = 120
}

variable "scale_tracking_cpu" {
  type        = number
  description = "Valor de utilização de CPU alvo para o rastreamento de escala, em percentual."
  default     = 80
}

variable "alb_arn" {
  type        = string
  description = "ARN do Application Load Balancer usado para rastreamento de solicitações."
  default     = null
}

variable "scale_tracking_requests" {
  type        = number
  description = "Número alvo de solicitações por segundo (TPS) para o rastreamento de escala."
  default     = 0
}

variable "efs_volumes" {
  type = list(object({
    volume_name : string
    file_system_id : string
    file_system_root : string
    mount_point : string
    read_only : bool
  }))
  description = "Volumes EFS existentes para serem montados nas tasks do ECS"
  default     = []
}

variable "service_discovery_namespace" {
  description = "Namespace ID do Service Discovery"
  default     = null
}