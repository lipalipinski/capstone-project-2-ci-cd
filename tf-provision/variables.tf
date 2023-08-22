variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "gd-boundry-policy" {
  # set to meet GD AWS policy
  type = string
  default = "arn:aws:iam::113304117666:policy/DefaultBoundaryPolicy"
}