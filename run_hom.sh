#!/bin/bash
set -euo pipefail

echo "Executando testes de REGRESSÃO em ambiente de HOMOLOGAÇÃO..."
mkdir -p results
robot --outputdir results --timestampoutputs -v ENVIRONMENT:hom --include regressao tests/amazon_tests.robot