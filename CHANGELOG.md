# PHP change log

## 0.5.8

update to Alpine 3.23 / php 8.4.15

## 0.5.7

update to php 8.4.8

## 0.5.6

update to Alpine 3.22 / php 8.3.22

## 0.5.5

update to Alpine 3.21 / php 8.3.14

## 0.5.4

fix nginx unit configuration: load php 8.3 default config, disable asserts

## 0.5.3

update to Alpine 3.20 / php 8.3.7

## 0.5.2

update to php 8.3.0

## 0.5.1

update to Alpine 3.19 / php 8.2.13

## 0.5.0

switching from php-fpm & nginx webserver to nginx unit 1.31.1 application
server, removing s6

## 0.4.1

update to Alpine 3.18 / php 8.2.6 / nginx 1.24.0 / s6 2.11.3.2

## 0.4.0

do expose nginx + version to `$_SERVER['SERVER_SOFTWARE']`

## 0.3.2

update to Alpine 3.17 / php 8.1.13 / nginx 1.22.1 / s6 2.11.1.2 / openssl 3.0.7

## 0.3.1

update to Alpine 3.16 / php 8.1.6 / nginx 1.22.0 / s6 2.11.1.0

## 0.3.0

update to Alpine 3.15 / php 8.0.14 / nginx 1.20.2 / s6 2.11.0.0
switching from s6-overlay to s6-svscan for service management

## 0.2.1

update to Alpine 3.14 / php 8.0.7 / nginx 1.20.1 / s6 2.10.0.3

## 0.2.0

update to php 8.0.2

## 0.1.8

update to Alpine 3.13 / php 7.4.15 / nginx 1.18.0 / s6 2.10.0.0

## 0.1.7
adding multi-arch image support via github action and buildx

## 0.1.6

update to Alpine 3.12.1 / php 7.3.24 / s6 2.1.0.2 - minor cleanup

## 0.1.5

update to Alpine 3.12 / php 7.3.21 / s6 2.0.0.1

## 0.1.4

update to openssl 1.1.1g / php 7.3.17

## 0.1.3

fixing nginx tmp volume path in Alpine 3.11

## 0.1.2

update to Alpine 3.11 / php 7.3.13 - avoiding curl by using busybox' wget

## 0.1.1

allow for read-only root and correcting logging

## 0.1.0

creating stack on alpine with s6-overlay
