# linuxtips-curso-containers-ecs-service-module
Repositorio de modulo para criação de services no ECS

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener_rule.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_alb_listener_rule.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_alb_target_group.blue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_alb_target_group.green](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_alb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_appautoscaling_policy.cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.target_tracking_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.target_tracking_requests](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.rollback_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_codedeploy_app.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.service_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.service_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_service_discovery_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [local_file.appspec](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.deploy_codedeploy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.deploy_ecs](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_alb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/alb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | ARN do Application Load Balancer usado para rastreamento de solicitações. | `string` | `null` | no |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | Lista de capacidades, como EC2 ou FARGATE | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Nome do cluster ECS onde o serviço será implantado. | `string` | n/a | yes |
| <a name="input_codedeploy_deployment_option"></a> [codedeploy\_deployment\_option](#input\_codedeploy\_deployment\_option) | Define a opção de deployment para o CodeDeploy. O padrão é WITH\_TRAFFIC\_CONTROL. | `string` | `"WITH_TRAFFIC_CONTROL"` | no |
| <a name="input_codedeploy_deployment_type"></a> [codedeploy\_deployment\_type](#input\_codedeploy\_deployment\_type) | Define o tipo de deployment do CodeDeploy. O padrão é BLUE\_GREEN. | `string` | `"BLUE_GREEN"` | no |
| <a name="input_codedeploy_rollback_alarm"></a> [codedeploy\_rollback\_alarm](#input\_codedeploy\_rollback\_alarm) | Define se o rollback será acionado com base em alarmes do CloudWatch. O padrão é true. | `bool` | `true` | no |
| <a name="input_codedeploy_rollback_error_evaluation_period"></a> [codedeploy\_rollback\_error\_evaluation\_period](#input\_codedeploy\_rollback\_error\_evaluation\_period) | Define o número de períodos de avaliação antes de acionar o rollback. O padrão é 1 período. | `number` | `1` | no |
| <a name="input_codedeploy_rollback_error_period"></a> [codedeploy\_rollback\_error\_period](#input\_codedeploy\_rollback\_error\_period) | Define o período de tempo, em segundos, para avaliar o erro durante o rollback. O padrão é 60 segundos. | `number` | `60` | no |
| <a name="input_codedeploy_rollback_error_threshold"></a> [codedeploy\_rollback\_error\_threshold](#input\_codedeploy\_rollback\_error\_threshold) | Define o limite percentual de erros que aciona o rollback. O padrão é 10%. | `number` | `10` | no |
| <a name="input_codedeploy_strategy"></a> [codedeploy\_strategy](#input\_codedeploy\_strategy) | Define a estratégia de deployment do CodeDeploy. O padrão é ECSAllAtOnce. | `string` | `"CodeDeployDefault.ECSAllAtOnce"` | no |
| <a name="input_codedeploy_termination_wait_time_in_minutes"></a> [codedeploy\_termination\_wait\_time\_in\_minutes](#input\_codedeploy\_termination\_wait\_time\_in\_minutes) | Define o tempo de espera, em minutos, para a terminação das tasks antigas em um deployment BLUE/GREEN. O padrão é 5 minutos. | `number` | `5` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Imagem com tag para deployment da aplicação no ECS | `string` | n/a | yes |
| <a name="input_deployment_controller"></a> [deployment\_controller](#input\_deployment\_controller) | Define o tipo de controlador de deployment. O padrão é ECS. Aceita os valores ECS e CODE\_DEPLOY | `string` | `"ECS"` | no |
| <a name="input_efs_volumes"></a> [efs\_volumes](#input\_efs\_volumes) | Volumes EFS existentes para serem montados nas tasks do ECS | <pre>list(object({<br>    volume_name : string<br>    file_system_id : string<br>    file_system_root : string<br>    mount_point : string<br>    read_only : bool<br>  }))</pre> | `[]` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Lista de variáveis de ambiente que serão passadas para o serviço. | <pre>list(object({<br>    name : string<br>    value : string<br>  }))</pre> | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Lista de IDs das subnets privadas onde o serviço será implantado. | `list(string)` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Protocolo a ser usado nas comunicações, como tcp ou udp. | `string` | `"tcp"` | no |
| <a name="input_region"></a> [region](#input\_region) | Região onde os recursos do AWS serão provisionados. | `string` | n/a | yes |
| <a name="input_scale_in_adjustment"></a> [scale\_in\_adjustment](#input\_scale\_in\_adjustment) | Quantidade de tarefas para reduzir durante uma ação de escala para baixo. | `number` | `-1` | no |
| <a name="input_scale_in_comparison_operator"></a> [scale\_in\_comparison\_operator](#input\_scale\_in\_comparison\_operator) | Operador de comparação usado para a condição de escala para baixo, como 'LessThanOrEqualToThreshold'. | `string` | `"LessThanOrEqualToThreshold"` | no |
| <a name="input_scale_in_cooldown"></a> [scale\_in\_cooldown](#input\_scale\_in\_cooldown) | Período de cooldown após uma ação de escala para baixo, em segundos. | `number` | `120` | no |
| <a name="input_scale_in_cpu_threshold"></a> [scale\_in\_cpu\_threshold](#input\_scale\_in\_cpu\_threshold) | Valor de limiar de utilização de CPU que, quando abaixo, aciona uma ação de escala para baixo, em percentual. | `number` | `30` | no |
| <a name="input_scale_in_evaluation_periods"></a> [scale\_in\_evaluation\_periods](#input\_scale\_in\_evaluation\_periods) | Número de períodos de avaliação necessários para acionar uma escala para baixo. | `number` | `3` | no |
| <a name="input_scale_in_period"></a> [scale\_in\_period](#input\_scale\_in\_period) | Duração do período de avaliação para escala para baixo, em segundos. | `number` | `120` | no |
| <a name="input_scale_in_statistic"></a> [scale\_in\_statistic](#input\_scale\_in\_statistic) | Estatística usada para a condição de escala para baixo, como 'Average' ou 'Sum'. | `string` | `"Average"` | no |
| <a name="input_scale_out_adjustment"></a> [scale\_out\_adjustment](#input\_scale\_out\_adjustment) | Quantidade de tarefas para aumentar durante uma ação de escala para cima. | `number` | `1` | no |
| <a name="input_scale_out_comparison_operator"></a> [scale\_out\_comparison\_operator](#input\_scale\_out\_comparison\_operator) | Operador de comparação usado para a condição de escala para cima, como 'GreaterThanOrEqualToThreshold'. | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| <a name="input_scale_out_cooldown"></a> [scale\_out\_cooldown](#input\_scale\_out\_cooldown) | Período de cooldown após uma ação de escala para cima, em segundos. | `number` | `60` | no |
| <a name="input_scale_out_cpu_threshold"></a> [scale\_out\_cpu\_threshold](#input\_scale\_out\_cpu\_threshold) | Valor de limiar de utilização de CPU que, quando excedido, aciona uma ação de escala para cima, em percentual. | `number` | `80` | no |
| <a name="input_scale_out_evaluation_periods"></a> [scale\_out\_evaluation\_periods](#input\_scale\_out\_evaluation\_periods) | Número de períodos de avaliação necessários para acionar uma escala para cima. | `number` | `2` | no |
| <a name="input_scale_out_period"></a> [scale\_out\_period](#input\_scale\_out\_period) | Duração do período de avaliação para escala para cima, em segundos. | `number` | `60` | no |
| <a name="input_scale_out_statistic"></a> [scale\_out\_statistic](#input\_scale\_out\_statistic) | Estatística usada para a condição de escala para cima, como 'Average' ou 'Sum'. | `string` | `"Average"` | no |
| <a name="input_scale_tracking_cpu"></a> [scale\_tracking\_cpu](#input\_scale\_tracking\_cpu) | Valor de utilização de CPU alvo para o rastreamento de escala, em percentual. | `number` | `80` | no |
| <a name="input_scale_tracking_requests"></a> [scale\_tracking\_requests](#input\_scale\_tracking\_requests) | Número alvo de solicitações por segundo (TPS) para o rastreamento de escala. | `number` | `0` | no |
| <a name="input_scale_type"></a> [scale\_type](#input\_scale\_type) | Tipo de escalabilidade, como 'cpu', 'cpu\_tracking' ou 'requests\_tracking'. | `string` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Lista de secrets do parameter store ou do secrets manager | <pre>list(object({<br>    name : string<br>    valueFrom : string<br>  }))</pre> | `[]` | no |
| <a name="input_service_connect_arn"></a> [service\_connect\_arn](#input\_service\_connect\_arn) | ARN do Service Connect. | `string` | `null` | no |
| <a name="input_service_connect_name"></a> [service\_connect\_name](#input\_service\_connect\_name) | Nome do Service Connect. | `string` | `null` | no |
| <a name="input_service_cpu"></a> [service\_cpu](#input\_service\_cpu) | Quantidade de CPU alocada para o serviço, especificada em unidades de CPU do ECS. | `number` | n/a | yes |
| <a name="input_service_discovery_namespace"></a> [service\_discovery\_namespace](#input\_service\_discovery\_namespace) | Namespace ID do Service Discovery | `any` | `null` | no |
| <a name="input_service_healthcheck"></a> [service\_healthcheck](#input\_service\_healthcheck) | Configuração do health check do serviço, incluindo caminho e protocolo. | `map(any)` | n/a | yes |
| <a name="input_service_hosts"></a> [service\_hosts](#input\_service\_hosts) | Lista de hosts associados ao serviço, geralmente especificados para configurações DNS. | `list(string)` | n/a | yes |
| <a name="input_service_launch_type"></a> [service\_launch\_type](#input\_service\_launch\_type) | Configuração dos Launch Types pelos capacity providers disponíveis no cluster | <pre>list(object({<br>    capacity_provider = string<br>    weight            = number<br>  }))</pre> | <pre>[<br>  {<br>    "capacity_provider": "SPOT",<br>    "weight": 100<br>  }<br>]</pre> | no |
| <a name="input_service_listener"></a> [service\_listener](#input\_service\_listener) | ARN do listener do Application Load Balancer que será usado pelo serviço. | `string` | `null` | no |
| <a name="input_service_memory"></a> [service\_memory](#input\_service\_memory) | Quantidade de memória alocada para o serviço, especificada em MB. | `number` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Nome do serviço a ser utilizado no ECS ou identificador similar. | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Porta na qual o serviço estará acessível. | `number` | n/a | yes |
| <a name="input_service_protocol"></a> [service\_protocol](#input\_service\_protocol) | Protocolo de serviço utilizado, como http, https, grpc ou tcp. | `string` | `null` | no |
| <a name="input_service_task_count"></a> [service\_task\_count](#input\_service\_task\_count) | Número de instâncias da tarefa a serem executadas simultaneamente no serviço. | `number` | n/a | yes |
| <a name="input_service_task_execution_role"></a> [service\_task\_execution\_role](#input\_service\_task\_execution\_role) | ARN da role de execução de tarefas do ECS que o serviço usará para executar. | `string` | n/a | yes |
| <a name="input_task_maximum"></a> [task\_maximum](#input\_task\_maximum) | Número máximo de tarefas que podem ser executadas pelo serviço. | `number` | `10` | no |
| <a name="input_task_minimum"></a> [task\_minimum](#input\_task\_minimum) | Número mínimo de tarefas que devem ser executadas pelo serviço. | `number` | `3` | no |
| <a name="input_use_lb"></a> [use\_lb](#input\_use\_lb) | Habilita a exposição do serviço via load balancer | `bool` | `true` | no |
| <a name="input_use_service_connect"></a> [use\_service\_connect](#input\_use\_service\_connect) | Habilita ou desabilita o uso do Service Connect. | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID da VPC onde os recursos relacionados ao serviço serão provisionados. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->