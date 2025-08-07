#!/bin/bash
echo "Executando apenas testes de SMOKE..."
robot --outputdir results --timestampoutputs --include smoke tests/amazon_tests.robot 