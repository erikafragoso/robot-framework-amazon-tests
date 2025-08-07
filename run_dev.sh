#!/bin/bash
echo "Executando testes de SMOKE em ambiente de DESENVOLVIMENTO..."
robot --outputdir results --timestampoutputs --include smoke tests/amazon_tests.robot 