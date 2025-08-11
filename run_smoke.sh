#!/bin/bash
set -euo pipefail

echo "Executando apenas testes de SMOKE..."
mkdir -p results
robot --outputdir results --timestampoutputs --include smoke tests/amazon_tests.robot