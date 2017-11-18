variable "name" {
  description = "SQS Queue Name"
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
  default     = "0"
}

variable "max_message_size" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
  default     = "262144"
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue."
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message."
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning."
  default     = 0
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue"
  default     = ""
}

variable "policy" {
  description = "The JSON policy for the SQS queue"
  default     = ""
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = ""
}

variable "fifo_queue" {
  description = "Enable First-In-First-Out"
  default     = false
}

variable "content_based_deduplication" {
  description = "Enabled Content Based Deduplication"
  default     = false
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  default     = ""
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
  default     = 300
}

variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the queue."
  default     = {}
}
