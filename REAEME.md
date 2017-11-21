<!-- -*- mode: markdown -*- coding: utf-8 -*- -->
# Cowoll at Netlify

## Set Up

create a project

    $ lecktor quickstart

* Project Name: Cowoll at Netlify
* Directory: cowroll.netlify.com

## Github

create repository called "cowroll.netlify.com" by higebobo (not cowroll)[^1]

[^1]: netlifyがusername(not organization)でしかレポジトリを利用できないから
    
## Deploy

    $ echo "*~" >> .gitignore
    $ echo "*.bak" >> .gitignore
    $ echo "*.pyc" >> .gitignore
    $ echo "build" >> .gitignore
    $ mv Coroll\ in\ Netlify.lektorproject website.lektorproject
    $ git init
    $ git add .
    $ git commit -m 'First commit'
    $ git remote add origin git@github.com:higebobo/cowroll.netlify.com.git
    $ git remote -v
    $ git push origin master

## Netlify

### by tutorial[^2]

* githubのhigeboboアカウントでログイン
* Siteを作成
    - Site Name: cowroll
    - Conifgure Deploys and Repository
        + Dir: build
        + Build Command: lektor build --output-path ./build
* 結局 lektor comannd not foundになって断念

### lektor-netlify plugin

* [^2]: tutorial がうまくいかなかったので lektor-netlify plugin を使う
* higeboboアカウントでなくてもよくなったのでcowrollに移譲

#### netlify-cliのインストール

    $ npm install netlify-cli -g
    $ ndenv rehash

#### アクセスTOKENの生成

以下にアクセスしてTOKEN生成(App IDではない)

https://app.netlify.com/account/applications/personal

website.lektorproject

    [servers.production]
    name = Production
    target = netlify://cowroll.netlify.com
    key = <ACCESS_TOKEN>

#### デプロイ

deploy

	$ lektor deploy production

or

    $ lektor deploy production --key <ACCESS_TOKEN>
