output "RdsSecretPasswordArn" {
  value = module.rds.db_instance_master_user_secret_arn
}

output "RdsEndpoint" {
  value = module.rds.db_instance_address
}

output "RdsInstanceIdentifier" {
  value = module.rds.db_instance_identifier
}