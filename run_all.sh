#!/bin/bash
set -euo pipefail

echo "Executando TODOS os testes..."
mkdir -p results
robot --outputdir results --timestampoutputs tests/amazon_tests.robot