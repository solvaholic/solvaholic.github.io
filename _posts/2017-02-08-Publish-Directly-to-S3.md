---
layout: post
title: Publish Directly to S3
date: 2017-02-08 07:36:04
tags: notes
---

Author a static Web site locally in hexo, and publish directly to a Amazon Web Services' S3 bucket.  You'll use hexo, a text editor, and the AWS CLI.

## Prerequisites
* Node.js, npm, and hexo ([link to Node.js and npm](https://nodejs.org/en/download/), and [to hexo](https://www.npmjs.com/package/hexo))
* AWS S3 bucket, configured to serve a static site ([link to instructions](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html))
* AWS CLI, configured with valid credentials ([link to AWS CLI](https://aws.amazon.com/cli/))
  * ([How to create a user and keys](https://aws.amazon.com/developers/access-keys/))
  * ([List of regions](http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region))

``` bash
$ npm install -g hexo-cli
$ pip install awscli
$ aws configure
AWS Access Key ID [None]: <Valid Value>
AWS Secret Access Key [None]: <Valid Value>
Default region name [None]: <Valid Value>
Default output format [None]:
$ aws s3 ls
2015-03-09 00:34:31 yourfirstbucket
2015-03-09 03:41:21 bucket-for-logs
2015-03-09 15:03:30 yourwebsite.com
2015-03-09 14:55:14 www.yourwebsite.com
$ aws s3api get-bucket-website --bucket yourwebsite.com
{
    "IndexDocument": {
        "Suffix": "index.html"
    },
    "ErrorDocument": {
        "Key": "error.html"
    }
}
```

## Author a static site in hexo
### Initialize the local directory for your hexo site
``` bash
$ mkdir ~/yourwebsite.com
$ cd ~/yourwebsite.com
$ hexo init .
$ hexo new draft "My New Article"
INFO  Created: ~/yourwebsite.com/source/_drafts/My-New-Article.md
$ hexo server --drafts --open
```
### Edit the draft with your text editor, save, and refresh browser to view
### Publish the draft, and generate the site content with hexo
``` bash
<CTRL-C to stop the hexo server>
$ hexo publish 'My-New-Article'
$ hexo generate
$ ls public
2017		css		index.html
archives	fancybox	js
```

## Publish directly to S3
``` bash
$ aws s3 sync public/ s3://yourwebsite.com/ --delete --sse
```
