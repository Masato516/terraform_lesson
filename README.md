公式ドキュメント: "https://registry.terraform.io/"
公式チュートリアル: "https://learn.hashicorp.com/"

Terraform v1.0.5

## tfenv
terraform のバージョン管理ツール
v2.2.2

## tfファイル
カレントディレクトリの直下のファイルしか読み込まれない！！！
全ての直下のファイルが読み込まれるため、
ファイル名は何でも良い

## resource
リソース（インフラ）を作るための文

## data
リソースを取得するための文
すでに作成済みのリソースの情報を取得する

## tfstateファイル
terraformで管理しているインフラリソースを
全て記載したjsonファイル

## 設定ファイルと認証情報ファイルの設定
AWS CLI コマンドに適用できる設定と認証情報の集まり
コマンドを実行するプロファイルを指定すると、
設定と認証情報を使用してそのコマンドが実行される。
プロファイルが明示的に参照されない場合に使用される、
default プロファイルを 1 つ指定できる

$ aws configure で簡単に設定できる 
(~/.aws/credentials と ~/.aws/configure に保存される)

例--------------------------------------------
~/.aws/credentials
[プロファイル名]
aws_access_key_id = ~~~~~~~~~~~~~~~~~
aws_secret_access_key = ~~~~~~~~~~~~~~~~~~~~~

~/.aws/config
[profile プロファイル名]
region = ap-northeast-1
output = json
----------------------------------------------


(~/backend.tf)
tfstateファイルをS3で管理

## terraform apply
.tf ファイルに記載された情報を元にリソースを作成するコマンド。
リソースが作成されると terraform.state というファイルに、
作成されたリソースに関連する情報が保存される
また、2度目以降の実行後には、1世代前のものが terraform.tfstate.backup に保存される形となる
Terraform において、この状態を管理する terraform.state ファイルが非常に重要になってくる。

使用例.
AWS_PROFILE=<プロファイル名> terraform apply


## terraform validate
terraformの構文チェック
あんまり使わない（planで大体わかる！）


## terraform plan (dry-run)
Terraform による実行計画を参照するコマンド
.tf ファイルに記載された情報を元に、
どのようなリソースが 作成/修正/削除 されるかを参照することが可能

使用例
AWS_PROFILE=プロファイル名 terraform plan


## terraform show
terraform.state ファイルを元に現在のリソースの状態を参照するコマンド


## terraform destroy
.tf ファイルに記載された情報を元にリソースを削除するコマンド
なお、実行すると terraform.tfstate のリソース情報がスカスカになり、
削除直前のものは terraform.tfstate.backup に保存される形となる

使用例.
# 全てのリソースを削除
AWS_PROFILE=プロファイル名 terraform destroy
# 特定のリソースを削除
AWS_PROFILE=プロファイル名 terraform destroy -target=aws_subnet.recruit_web_1c


### workspace
本番環境やステージング環境などに分けられる
(https://www.terraform.io/docs/language/state/workspaces.html)

$ terraform workspace list
workspace（作業空間）の一覧を出力
* default <- 現在のworkspace


$ terraform workspace new <workspace名>
workspaceを作成

例.
terraform workspace new production


## output

EC2インスタンスのパブリックIPなど、
環境を構築した結果リソースに割り当てられた属性値を知りたい場合がある
その時に役立つのがoutput


# 書式
output "<アウトプットする属性の説明>" {
  value = "<アウトプットする属性値>"
}

output "public ip of cm-test" {
  value = "${aws_instance.cm-test.public_ip}"
}