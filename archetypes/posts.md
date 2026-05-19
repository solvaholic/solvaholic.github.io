---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ .Date }}
slug: "{{ .File.ContentBaseName }}"
tags: []
draft: true
---
