sqs terraform module
===========

A terraform module to provide Simple Queue Service (SQS) in AWS.

Module Input Variables
----------------------

* \[`name`\]: String (required): SQS Queue Name
* \[`delay_seconds`\]: Int (optional): The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds. 
* \[`max_message_size`\]: Int (optional): The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).
* \[`visibility_timeout_seconds`\]: Int (optional): The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see [AWS docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html).
* \[`message_retention_seconds`\]: Int (optional): The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days). 
* \[`receive_wait_time_seconds`\]: Int (optional): The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately.
* \[`redrive_policy`\]: String (optional): The JSON policy to set up the Dead Letter Queue, see [AWS docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html). **Note**: when specifying _maxReceiveCount_, you must specify it as an integer (5), and not a string ("5"). 
* \[`policy`\]: String (optional): The JSON policy for the SQS queue

* \[`fifo_queue`\]: Boolean (optional): Boolean designating a FIFO queue. If not set, it defaults to _false_ making it standard.
* \[`content_based_deduplication`\]: Boolean (optional): Enables content-based deduplication for FIFO queues. For more information, see the [related documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing). Default is _false_.
* \[`kms_master_key_id`\]: String (optional): The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. For more information, see [Key Terms](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-server-side-encryption.html#sqs-sse-key-terms).
* \[`kms_data_key_reuse_period_seconds`\]: Int (optional): The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes).
* \[`tags`\]: Map (optional): A mapping of tags to assign to the queue. 

Usage
-----

```hcl
module "sqs" {
  source = "github.com/pvicol/tf_aws_sqs"
  name                       = "my-sqs"
  
  delay_seconds              = "20"
  max_message_size           = "262144"
  visibility_timeout_seconds = "43200"
  message_retention_seconds  = "1209600"
  receive_wait_time_seconds  = "0"
  
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.terraform_queue_deadletter.arn}\",\"maxReceiveCount\":4}"
  policy                     = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.my-sqs.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.my-sqs.arn}"
        }
      }
    }
  ]
}
POLICY
}
```

Outputs
=======

 - `url` - URL of the SQS endpoint
 - `arn` - ARN or the SQS instance