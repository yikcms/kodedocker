FROM baiyuetribe/kodexplorer

# 设置容器启动时的参数
CMD ["-i", "-t", "-d", "--restart=always", "--privileged=true", "--name", "kodexplorer"]

# CMD 指定容器启动后要执行的命令
CMD ["bash"]
