#!/bin/bash
set -euo pipefail

echo "Executando testes de SMOKE em ambiente de DESENVOLVIMENTO..."
mkdir -p results
robot --outputdir results --timestampoutputs -v ENVIRONMENT:dev --include smoke tests/amazon_tests.robot