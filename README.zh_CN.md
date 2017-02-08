# 使用 Swift语言进行 Hadoop 数据流应用程序开发[English](README.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="https://gitter.im/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_2_Git.jpg" alt="Chat on Gitter" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="https://gitter.im/PerfectlySoft/Perfect?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge" target="_blank">
        <img src="https://img.shields.io/badge/Gitter-Join%20Chat-brightgreen.svg" alt="Join the chat at https://gitter.im/PerfectlySoft/Perfect">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>


该项目展示了如何使用 Swift 语言开发 Hadoop 流处理应用程序。

该软件使用SPM进行编译和测试，本软件也是[Perfect](https://github.com/PerfectlySoft/Perfect)项目的一部分。本软件包可独立使用，因此使用时可以脱离PerfectLib等其他组件。

请确保您已经安装并激活了最新版本的 Swift 3.0 tool chain 工具链。

### 问题报告、内容贡献和客户支持

我们目前正在过渡到使用JIRA来处理所有源代码资源合并申请、修复漏洞以及其它有关问题。因此，GitHub 的“issues”问题报告功能已经被禁用了。

如果您发现了问题，或者希望为改进本文提供意见和建议，[请在这里指出](http://jira.perfect.org:8080/servicedesk/customer/portal/1).

在您开始之前，请参阅[目前待解决的问题清单](http://jira.perfect.org:8080/projects/ISS/issues).

## 简介

本项目包括两类 Hadoop 流处理应用程序：映射器 mapper 和 总结器 reducer。这两类程序都是标准的控制台终端程序，即从标准输入读数据`readLine()`后推送到标准输出`print()`。

映射器的范例程序 mapper 是将来自标准输入的文本拆分为一个一个的英语单词，然后采用下列格式进行打印（假设输入内容是`Hello, world! hello!`）:

```
hello 1
world 1
hello 1
```

而总结器 reducer 的目标是将这些输入进行统计，最后形成单词统计表：

```
hello 2
world 1
```

两个程序的结合使用即可提供单词统计的功能。

Hadoop 的 Map Reduce 正是为上述任务在大数据环境下而设计的，这里的大数据指的是单个文件输入达到 GB 甚至 TB。

## 编译

由于采用标准流程序开发，因此编译这些应用不需要任何其他依存关系。您只需打开一个终端窗口并运行`swift build`命令即可：

```
$ cd mapper
$ swift build
$ cd ../reducer
$ swift build
```

## 测试

在部署到Hadoop 集群之前，您可以尝试在普通的命令行环境下进行测试（testdata.txt 文件是一个常规的文本文件，采用ASCII或UTF-8编码即可）。本工程目录下包括了可以用于测试的数据文件和脚本。

```
$ cat testdata.txt | ./mapper/.build/release/mapper | sort | ./reducer/.build/release/reducer
```

## 在 Hadoop 上运行程序

和上面的管道操作类似，试验成功后您可以尝试在一个真正的 Hadoop 集群上跑一下新编写的程序了：

```
$ mapred streaming -input /user/rockywei/input -output /user/rockywei/output -mapper /usr/local/bin/mapper -reducer /usr/local/bin/reducer
```

如果任务成功，您可以用下列命令在集群上查看输出：

```
$ hadoop fs -cat /user/rockywei/output/part-00000
```

### 详细说明

上述映射-总结程序的细节解释参考如下：

- `mapred streaming`: 向 Hadoop 集群申请一个新的应用程序任务，采用流处理模式（即纯文本）。

- `-input /user/rockywei/input`: *在HADOOP HDFS文件系统上的* 输入文件夹。典型情况是您需要向Hadoop 管理员帮助您用`hadoop fs -mkdir`命令行建立文件，然后再通过命令将待处理数据上传到该文件夹：`hadoop fs -put [cluster folder] /local/pathto/data.txt`。

- `-output /user/rockywei/output`: *在HADOOP HDFS文件系统上的* 输出文件夹。*特别注意*最后一个子目录/output不应该创建，也就是说，只要您有/user/rockywei就好，mapreduce 会自动创建这个输出文件夹。

- `-mapper /usr/local/bin/mapper`: 我们刚编译好的映射器，您可以采用下列命令安装到服务器本地文件夹： `swift build; sudo mv ./.build/release/mapper /usr/local/bin`。

- `-reducer /usr/local/bin/reducer`: 我们刚编译好的总结器，您可以采用下列命令安装到服务器本地文件夹`swift build; sudo mv ./.build/release/reducer /usr/local/bin`。


## 下一步：Perfect Hadoop

Hadoop 是一个大数据生态系统 —— 包括 HDFS 高性能多冗余文件系统，Map-Reduce 文件处理程序和 YARN 集群资源管理系统 ——  构成了最基本的大数据系统。

如上所示，在 Hadoop 上编写流处理程序是一个很简单的工作，也不需要依赖于特定的软件体系。但是，除了编写流处理程序之外，您还可以使用 [Perfect Hadoop](http://perfect.org) 做更多更强大的事情——任务控制、大文件上下载、集群节点监控——现在所有这些工作都可以使用Swift 语言实现了！

## 更多信息
关于本项目更多内容，请参考[perfect.org](http://perfect.org).
