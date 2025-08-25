#!/bin/bash

echo >> ~/.bashrc
echo '# Set up cross-compilation environment' >> ~/.bashrc
echo >> ~/.bashrc
cat /usr/local/oecore-x86_64/environment-setup-core2-64-nilrt-linux >> ~/.bashrc

echo >> ~/.bashrc
echo 'export PATH=/opt/cmake/bin:$PATH' >> ~/.bashrc
echo 'export SDKROOT=/usr/local/oecore-x86_64' >> ~/.bashrc
