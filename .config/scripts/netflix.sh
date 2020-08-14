#!/bin/sh

chromium --enable-webgl2-compute-context --renderer-process-limit=100 --max-active-webgl-contexts=100 --disable-frame-rate-limit --app=https://netflix.com
