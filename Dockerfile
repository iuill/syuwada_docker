# ベースイメージとしてNginxを使用
FROM nginx:alpine

# 必要なツールをインストール
RUN apk add --no-cache git

# GitHubリポジトリをクローン
RUN git clone https://github.com/syuwadaTeam/syuwada.git /tmp/syuwada

# syuwada_webAppフォルダの内容をNginxのデフォルトディレクトリにコピー
RUN cp -r /tmp/syuwada/syuwada_webApp/* /usr/share/nginx/html/

# 不要なファイルを削除
RUN rm -rf /tmp/syuwada

# カスタムnginx.confをコピー
COPY nginx.conf /etc/nginx/nginx.conf

# サービス定義ファイルをコピー
COPY nginx.service /etc/systemd/system/nginx.service

# Nginxのポートを46080に変更
EXPOSE 46080

# Nginxをサービスとして起動
CMD ["systemctl", "start", "nginx"]
