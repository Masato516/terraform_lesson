# terraformは直下のファイルを参照するため、ファイル名は何でも良い
# 実行する際は、AWS_PROFILE=sh0162vi_terraform を付ける必要あり
terraform {
  required_version = "1.0.5"
  backend "s3" {
    profile = "sh0162vi_terraform"
    bucket = "terraform-masa-test-tfstate" # バケット名
    key    = "terraform.tfstate"           # バケット内のキーのパス
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
