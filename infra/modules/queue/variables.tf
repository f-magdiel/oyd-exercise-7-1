variable "queue_name" {
  description = "Name prefix for the main queue and its dead-letter queue"
  type        = string
}

variable "max_receive_count" {
  description = "Number of times a message can be received before being moved to the DLQ"
  type        = number
}

variable "message_retention_seconds" {
  description = "How long (in seconds) the DLQ retains a message before deleting it"
  type        = number
}

variable "visibility_timeout_seconds" {
  description = "Duration (in seconds) that a received message is hidden from other consumers"
  type        = number
}
