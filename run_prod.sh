#!/bin/bash
echo "Executando TODOS os testes em ambiente de PRODUÇÃO..."
robot --outputdir results --timestampoutputs -v ENVIRONMENT:prod tests/amazon_tests.robot 