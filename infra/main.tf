module "orders_queue" {
  source = "./modules/queue"

  queue_name                 = var.queue_name
  max_receive_count          = var.max_receive_count
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
}

output "queue_url" { value = module.orders_queue.queue_url }
output "queue_arn" { value = module.orders_queue.queue_arn }
output "dlq_url"   { value = module.orders_queue.dlq_url   }
output "dlq_arn"   { value = module.orders_queue.dlq_arn   }
