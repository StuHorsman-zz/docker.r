FROM rocker/r-base

COPY hello.R /

CMD Rscript /hello.R
