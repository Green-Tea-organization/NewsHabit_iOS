#!/bin/bash

# Tuist 3.36.2 설치
bash <(curl -Ls https://install.tuist.io)
tuist install 3.36.2

# ci_scripts 디렉토리를 나와 프로젝트 경로인 NewsHabit로 진입
cd ..

# fetch를 통해 라이브러리 다운로드
tuist fetch 

# generate를 통해 .xcworkspace 받아오기
tuist generate
