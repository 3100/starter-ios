#!/bin/bash
PROJECT_NAME=AwesomeApp
CORDOVA_DIR=ios

reapp build ios

if ! builtin command -v cordova > /dev/null; then
  npm install -g cordova
fi

if [ ! -d ${CORDOVA_DIR} ]; then
  cordova create ${CORDOVA_DIR} ${PROJECT_NAME} ${PROJECT_NAME}
  (
  cd ${CORDOVA_DIR}
  rm -r www
  ln -s ../build/ios www
  cordova plugin add https://github.com/apache/cordova-plugin-statusbar.git
  cordova platform add ios && cordova prepare
  )
else
  (
  cd ${CORDOVA_DIR}
  cordova prepare
  )
fi

(
cd ${CORDOVA_DIR}/platforms/ios/${PROJECT_NAME}
if [ ! -f "config.xml.origin" ]; then
  mv config.xml config.xml.origin
fi
)
cp config/config-ios.xml ${CORDOVA_DIR}/platforms/ios/${PROJECT_NAME}/config.xml
exit 0
