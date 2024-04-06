# 使用 Java 8 作为基础镜像
FROM java:8

# 如果容器实现没有准备docker,即docker命令找不到,就把这两名命令放出来
#RUN apt-get update && \
#    apt-get install -y docker.io

# 设置工作目录
#操作将在app目录下进行
WORKDIR /app

# 以 root 用户身份执行命令
USER root

# 将数据卷挂载到工作目录
VOLUME /app/data

# 将 JAR 文件复制到工作目录
COPY ./target/jenkins-demo-test-1.0-SNAPSHOT.jar .

# 暴露容器端口 6333
EXPOSE 6333

# 启动 JAR 文件
# 在/app这个目录下执行如下命令
# 自定义 CMD ["java", "-jar", "/app/data/oa.jar"]
# CMD ["java", "-Xms512m", "-Xmx1024m", "-jar", "oa.jar"]
CMD ["java", "-jar", "/app/data/jenkins-demo-test-1.0-SNAPSHOT.jar"]