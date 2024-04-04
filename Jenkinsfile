// 在一个Node上执行,Node是Jenkins中的一个执行器
node {
    // 定义一个Stage,名为"Pull Code"
    stage('Pull Code') {
        // 从源码管理中checkout最新代码
        checkout scm
    }
}

// 在一个Node上执行
node {
    // 定义一个Stage,名为"Build Backend"
    stage('Build Backend') {
        // 从源码管理中checkout最新代码
        checkout scm
        // 切换到backend目录
        dir('./') {
            // 执行Maven命令,进行清理和打包
            sh 'mvn clean package'
            // 使用Docker Pipeline步骤,基于当前目录的Dockerfile构建Docker镜像
            // 镜像名称为your-backend-image,标签为当前构建ID
            // your-backend-image 是您为要构建的后端应用镜像指定的自定义名称
            // ${env.BUILD_ID} 是一个Jenkins环境变量,代表当前构建的唯一ID,用作镜像标签
            // "." 表示使用当前目录下的Dockerfile文件来构建镜像
            def backendImage = docker.build("jenkins_java:${env.BUILD_ID}", ".")
        }
    }
}

// 在一个Node上执行
// node {
//     // 定义一个Stage,名为"Build Frontend"
//     stage('Build Frontend') {
//         // 从源码管理中checkout最新代码
//         checkout scm
//         // 切换到frontend目录
//         dir('frontend') {
//             // 执行npm命令,安装前端依赖
//             sh 'npm install'
//             // 执行npm命令,构建前端应用
//             sh 'npm run build'
//             // 使用Docker Pipeline步骤,基于当前目录的Dockerfile构建Docker镜像
//             // 镜像名称为your-frontend-image,标签为当前构建ID
//             def frontendImage = docker.build("your-frontend-image:${env.BUILD_ID}", ".")
//         }
//     }
// }

// 在一个Node上执行
node {
    // 定义一个Stage,名为"Push Images"
    stage('Push Images') {
        // 连接到你的Docker镜像仓库,需要使用acr-credentials凭据
        docker.withRegistry('https://hub.docker.com/r/crqyuee/oa_test1/tags', 'jenkins-demo') {
            // 'acr-credentials'只是一个凭据ID的字符串标识。
            // 这个ID需要在Jenkins的"凭据"管理界面中定义一个凭据,关联一个用于访问Docker镜像仓库的用户名和密码/访问令牌。
            // 定义凭据的流程是:
            // 进入Jenkins的"凭据"管理界面
            // 点击"系统"左侧链接,进入系统凭据界面
            // 点击"全局凭据"左侧链接,添加一个新的凭据
            // 选择凭据类型为"Username with password"
            // 输入您的Docker仓库的用户名和密码/访问令牌
            // 为该凭据设置一个ID,比如"acr-credentials"
            // 之后,Jenkins就可以使用这个ID'acr-credentials'来引用上面定义的凭据,用于向Docker镜像仓库进行身份验证。
            // 将之前构建的后端镜像推送到仓库
            backendImage.push()
            // 将之前构建的前端镜像推送到仓库
            // frontendImage.push()
        }
    }
}

// 在一个Node上执行
node {
    // 定义一个Stage,名为"Deploy Local"
    stage('Deploy Local') {
        // 停止并移除当前运行的Docker容器
        sh 'docker-compose down'
        // 基于docker-compose.yml文件,重新拉取镜像并启动容器
        sh 'docker-compose up -d'
    }
}
