# Logstash

> 在现在的理解力，logstash 是一个主动收集的管道，去收集各种日志，和文件，并且经过管道中的过滤和处理，最后输出到 ElasticSearch 里，而Beats (是的B厕),更多的是去对logstash没有办法主动收集的地方做一个补充，例如 docker 容器中。Beats可以主动推送到Logstash或者直接推送给 ElasticSearch ，(这块了解的依然不多，需要深入了解)