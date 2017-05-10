#!/bin/bash

envconsul -config="/app/consul/envconsul.hcl" python -u /app/run.py
