# music-player-sample-programmers
>프로그래머스 과제 테스트 연습란의 뮤직 플레이어 앱 연습 과제  
https://school.programmers.co.kr/skill_check_assignments/2

<img src="https://img.shields.io/badge/Swift-5.6-informational"> <img src="https://img.shields.io/badge/Xcode-13.4.1-9cf">  
<img src="https://img.shields.io/badge/pod-1.11.3-lightgrey"> <img src="https://img.shields.io/badge/Alamofire-5.6.1-critical"> <img src="https://img.shields.io/badge/SnapKit-5.6.0-green"> <img src="https://img.shields.io/badge/MarqueeLabel-4.3.0-orange">


## Screenshot

<img width="250" alt="image" src="https://user-images.githubusercontent.com/81426024/179179170-d6a9bbb0-89d0-4fc7-be01-457ec10e93c9.png"><img width="250" alt="image" src="https://user-images.githubusercontent.com/81426024/179179115-f863e1a8-f757-4d52-90f2-ec5f70de321a.png"><img width="250" alt="image" src="https://user-images.githubusercontent.com/81426024/179179261-10920ac7-abf8-45ef-8134-b4538e6ee610.png">

## Demo

<img width="250" src="https://user-images.githubusercontent.com/81426024/179355428-888350c7-8192-4422-bcc3-556a88850620.gif">

## Features
- 현재 재생중인 구간 가사 하이라이팅
- 조작 가능한 seek bar
- 전체 가사 화면에서 선택한 가사로 이동
- Background 음악 재생

## Tech

- UIKit
- MVVM-C
- Combine
- AVFAudio
- Programmality UI config(without Storyboard)

## Library

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SnapKit](https://github.com/SnapKit/SnapKit)
- [MarqueeLabel](https://github.com/cbpowell/MarqueeLabel)

## 아쉬운 점
- MVVM 기반에서 명확하게 View 와 ViewModel 의 역할을 나누지 못한 점
- 공통적으로 쓰이는 footer section 을 모듈화하지 못한 점
- 네트워크 통신에서 발생할 수 있는 예외 상황에 대한 방어 코드가 미흡한 점
