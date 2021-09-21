resource "aws_instance" "recruit_web_server" {
  ami                         = "ami-09ebacdc178ae23b7" # Amazon Linux 2
  instance_type               = "t2.micro"
  associate_public_ip_address = "true" # IPアドレスを割り当てる
  vpc_security_group_ids      = [aws_security_group.sg_for_public_subnet.id]
  subnet_id                   = aws_subnet.recruit_web_1c.id
  key_name                    = aws_key_pair.auth.id # 利用する鍵

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y

    # デフォルトのmariadbを削除
    sudo yum uninstall mariadb-libs

    # mysql
    sudo yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
    sudo yum-config-manager --disable mysql80-community
    sudo yum-config-manager --enable mysql57-community
    sudo yum install -y mysql-community-client # mysqlクライアント


    # 必要なパッケージをインストール(アルファベット順)
    # curl                # データを送信できる
    # gcc-c++ \           # c++のコンパイラ
    # git \               # バージョン管理ができる
    # ImageMagick-devel \ # 画像を操作したり表示できる
    # libcurl-devel       # curlを扱える
    # libffi-devel \      # FFIの機能を扱える
    # libicu-devel \      # Unicodeを扱える
    # libxml2 \           # XMLを解析できる
    # libxml2-devel \     # XMLを解析できる
    # libxslt \           # XMLにXSLを適用させる
    # libxslt-devel \     # XMLにXSLを適用させる
    # libyaml-devel \     # yamlファイルを扱える
    # make \              # ソースコードからビルドできる
    # openssl-devel \     # 通信を暗号化する
    # patch \             # ファイルの修正や生成ができる
    # readline-devel \    # CUIで行入力を支援してくれる
    # zlib-devel \        # データの圧縮や伸張ができる

    sudo yum install -y \
    curl \
    gcc-c++ \
    git \
    ImageMagick-devel \
    libcurl-devel \
    libffi-devel \
    libicu-devel \
    libxml2 \
    libxml2-devel \
    libxslt \
    libxslt-devel \
    libyaml-devel \
    make \
    openssl-devel \
    patch \
    readline-devel \
    zlib-devel

    # Node.jsをインストール
    curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
    sudo yum install -y nodejs
  EOF

  tags = {
    Name = "recruit_web_server"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# 割り当てられたIPアドレスを出力
output "public_ip" {
  value       = aws_instance.recruit_web_server.public_ip
  description = "The public IP address of the main server instance."
}
