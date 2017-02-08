# Swift Application for Hadoop Streaming [简体中文](README.zh_CN.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
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
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

This project demonstrates how to build a Hadoop Map Reduce application in Swift language.

This package builds with Swift Package Manager and is part of the [Perfect](https://github.com/PerfectlySoft/Perfect) project. It was written to be stand-alone and so does not require PerfectLib or any other components.

Ensure you have installed and activated the latest Swift 3.0 tool chain.

## Issues

We are transitioning to using JIRA for all bugs and support related issues, therefore the GitHub issues has been disabled.

If you find a mistake, bug, or any other helpful suggestion you'd like to make on the docs please head over to [http://jira.perfect.org:8080/servicedesk/customer/portal/1](http://jira.perfect.org:8080/servicedesk/customer/portal/1) and raise it.

A comprehensive list of open issues can be found at [http://jira.perfect.org:8080/projects/ISS/issues](http://jira.perfect.org:8080/projects/ISS/issues)

## Introduction

This project contains two kinds of Hadoop Streaming applications: mapper and reducer. Both applications are standard console programs which read from standard input stream `readLine()` and generate results into output stream `print()`.

The mapper sample application is to read words one by one from the input and print them out int such a format, given the input content as `Hello, world! hello!`:

```
hello 1
world 1
hello 1
```

And the objective of this sample reducer is to count every word and generate out text like:

```
hello 2
world 1
```

The combination of the both applications can provide the function of counting words in a text.

Hadoop Map Reduce is design to do these tasks for large date input, in giga bytes or tera bytes.

## Build

As standard streaming application, there is no special requirement for building these apps. Simply open the terminal console and run swift build command, as demo below:

```
$ cd mapper
$ swift build
$ cd ../reducer
$ swift build
```

## Test

Before deploying to Hadoop, you can test the both apps in such a command line (the testdata.txt is just a regular text file coded in asc-ii or UTF-8). All test examples and test scripts are available in this repo.

```
$ cat testdata.txt | ./mapper/.build/release/mapper | sort | ./reducer/.build/release/reducer
```

## Run On Hadoop

Equivalent to the above pipeline operations, you can try a similar command line on a Hadoop cluster:

```
$ mapred streaming -input /user/rockywei/input -output /user/rockywei/output -mapper /usr/local/bin/mapper -reducer /usr/local/bin/reducer
```

If success, you can check the output result on Hadoop Cluster:

```
$ hadoop fs -cat /user/rockywei/output/part-00000
```

### Walkthrough

Details of the map reduce command line above are explained here:

- `mapred streaming`: Submit a new map reduce application, in streaming mode, i.e., text only.

- `-input /user/rockywei/input`: the data input folder on *HADOOP HDFS* system. Typically you should ask the hadoop administrator to help you create such as folder by using command line of `hadoop fs -mkdir` and then upload the input source text file by command line `hadoop fs -put [cluster folder] /local/pathto/data.txt`.

- `-output /user/rockywei/output`: the data output folder on *HADOOP HDFS* system. *NOTE* this folder should not be created, i.e, what you need to do should only create the `/user/rockywei` folder and let map reduce programs to create the full path by themselves.

- `-mapper /usr/local/bin/mapper`: the swift mapper app we just build. You can install it into the local file system by command of `swift build; sudo mv ./.build/release/mapper /usr/local/bin`.

- `-reducer /usr/local/bin/reducer`: the swift reducer app we just build. You can install it into the local file system by command of `swift build; sudo mv ./.build/release/reducer /usr/local/bin`.

## Next Step with Perfect Hadoop

Hadoop is an eco-system for large file processing - HDFS, Map-Reduce and YARN as the most fundamental components.

As the demo above, building an app for Hadoop Streaming in Swift is easy and framework independent. However, beside building apps for Hadoop, you can even go further in Swift by the power of [Perfect Hadoop](http://perfect.org)  - Submit the app, upload and download data, monitor all the jobs, control all nodes in cluster - all these service side activities can be manipulated in Swift language now!

## Further Information
For more information on the Perfect project, please visit [perfect.org](http://perfect.org).
