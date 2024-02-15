# WITT

`WITT`는 기발함을 의미하는 단어 **Wit**와 **What is that**의 합성어로, 딥러닝 기술을 활용하여 다양한 사용자들에게 편의를 제공하는 서비스를 구현하자는 취지를 담고 있습니다. WITT의 핵심 기능은 `안드로이드 모바일 카메라`를 통한 `실시간 객체 탐지 및 이미지 탐색`으로서, 사용자가 자율적으로 주변 환경과 객체를 탐색할 수 있도록 서비스를 지원합니다. 더불어, 탐색한 객체에 대한 정보를 제공받을 수 있도록 `GPT`,`번역(한국어, 영어, 중국어, 일본어)`, `OCR(Optical Character Recognition)` 및 `STT(Speech to Text)` 서비스를 지원합니다.  

## Why you need WITT

* 혁신적 기술과 시각화를 통한 교육적 접근성 향상
* 사전 학습이 필요없는 환경 및 물체 탐색
* 개별화된 교육환경으로의 변화

## WITT Goal

* 바운딩 박스를 통한 실시간 객체 탐지 서비스 지원
* 사용자 주도적 환경 탐색 및 학습 경험 제공
* 다차원적 도구로서의 활용

## WITT Screen composition and functions

| **Welcome** |  **Sign-in**  |  **Home** |
| :---:|:---:|:---:|
| <img align="center" alt="WITT Application welcome screen image" src="./pics/welcome.png" width="240px" /> | <img align="center" alt="WITT Application sign-in screen image" src="./pics/signin.png" width="240px" /> |<img align="center" alt="WITT Application home screen image" src="./pics/home.png" width="240px" /> |

| **Live Detection** | **Image Detection A** (YOLO v8n) | **Image Detection B** (YOLO v5l)  |
| :---:|:---:|:---:|
| <img align="center" alt="WITT Application object detection with camera screen image" src="./pics/camera1.png" width="240px" /> | <img align="center" alt="WITT Application object detection with gallery screen image" src="./pics/gallery.png" width="240px" /> |<img align="center" alt="WITT Application object detection results as label screen image" src="./pics/gallery_image.png" width="240px" /> |

| **Translator / OCR / STT** | **GPT with Kor** | **GPT with Eng**  |
| :---:|:---:|:---:|
| <img align="center" alt="WITT Application translator, ocr, stt service screen image" src="./pics/ocr_stt_translate.png" width="240px" /> | <img align="center" alt="WITT Application gpt with Korean screen image" src="./pics/gpt_kor.png" width="240px" /> |<img align="center" alt="WITT Application gpt with English screen image" src="./pics/gpt_en.png" width="240px" /> |

## Development environment and technology stack

* **IDE**: VS Code  
* **Version Control**: Git & Github  
* **Models**: YOLO v5l, YOLO v8n  
* **Technology Stack**: Flutter Framework, Dart, Flutter Packages, Firebase, HTTP  
