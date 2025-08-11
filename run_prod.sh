#!/bin/bash
set -euo pipefail

echo "Executando TODOS os testes em ambiente de PRODUÇÃO..."
mkdir -p results
robot --outputdir results --timestampoutputs -v ENVIRONMENT:prod tests/amazon_tests.robot