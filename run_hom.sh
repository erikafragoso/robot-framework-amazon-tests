#!/bin/bash
echo "Executando testes de REGRESSÃO em ambiente de HOMOLOGAÇÃO..."
robot --outputdir results --timestampoutputs -v ENVIRONMENT:hom --include regressao tests/amazon_tests.robot 