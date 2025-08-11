#!/bin/bash
set -euo pipefail

echo "Executando apenas testes de REGRESSÃO..."
mkdir -p results
robot --outputdir results --timestampoutputs --include regressao tests/amazon_tests.robot