FROM nginx:alpine AS base

# 必要なツールをインストール
RUN apk add --no-cache git
RUN git clone https://github.com/syuwadaTeam/syuwada.git /tmp/syuwada


# ----------------------------------------------------------------------------------
# サービス1
FROM base AS service1

RUN cp -r /tmp/syuwada/createCSVdata_program/* /usr/share/nginx/html/

# 不要なファイルを削除
RUN rm -rf /tmp/syuwada

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]


# ----------------------------------------------------------------------------------
# サービス2（手話打本体）
FROM base AS service2

RUN cp -r /tmp/syuwada/syuwada_webApp/* /usr/share/nginx/html/

# アクセスできなくなっているjsファイルのURLを修正
# ref: 参考⇒ https://quinton-ashley.github.io/p5play-web-archive/v2/
RUN sed -i 's|<script src="https://p5play.org/v2/p5.play.js"></script>|<script src="https://quinton-ashley.github.io/p5play-web-archive/v2/p5.play.js"></script>|g' /usr/share/nginx/html/index.html

# 不要なファイルを削除
RUN rm -rf /tmp/syuwada

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]


# ----------------------------------------------------------------------------------
# サービス3
FROM base AS service3

RUN cp -r /tmp/syuwada/visualizeData_Programs/* /usr/share/nginx/html/
RUN mv /usr/share/nginx/html/visualizeData_Programs.html /usr/share/nginx/html/index.html

# 不要なファイルを削除
RUN rm -rf /tmp/syuwada

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]


# ----------------------------------------------------------------------------------
# サービス4
FROM base AS service4

RUN cp -r /tmp/syuwada/yubimojiPrediction_program/* /usr/share/nginx/html/

# 不要なファイルを削除
RUN rm -rf /tmp/syuwada

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
