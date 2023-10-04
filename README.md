# ARTX-PoliceScience
![ex_screenshot](./img/artx_logo_gray.svg)
## ARTX Git Workflow
### 브랜치카테고리
- main: 제품으로 출시될 수 있는 브랜치 (사용)
- develop : 다음 출시 버전을 개발하는 브랜치 (사용)
- feature : 기능을 개발하는 브랜치 (사용)
- release : 이번 출시 버전을 준비하는 브랜치 (미사용)
- hotfix : 출시 버전에서 발생한 버그를 수정 하는 브랜치 (미사용)

## 브랜치명 규칙
- 브랜치는 "브랜치카테고리/#이슈넘버-이슈타이틀"
```shell
git branch "feature/#32-logout"
```

## 커밋 메시지 규칙 (대문자)
- 🍱 Add: Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 에셋 추가
- 🐛 Bug: 버그, 오류 해결
- 🔥 Delete: 쓸모없는 코드 삭제
- 🎨 Design: 디자인 수정
- 📝 Docs: README나 WIKI 등의 문서 개정
- ✨ Feat: 새로운 기능 구현
- 🔨 Chore: 새로운 파일 생성 시, 코드 수정, 내부 파일 수정, 주석
- ♻️ Refact: 전면 수정이 있을 때 사용합니다
- 💬 Rename: 파일 이름 변경이 있을 때 사용합니다
- 🎉 Init: 프로젝트 생성
- 🚚 Move: 프로젝트 내 파일이나 코드의 이동
- 커밋메세지는 한글로 작성한다.
```shell
git commit -m "[Feat] 로그아웃 및 회원탈퇴 구현, [Chore] 코드리뷰 반영, [Fix] 초대코드 복사 토스트가 계속 내려오는 문제 해결, [Add] ToastView 컴포넌트화"
```

## 깃 조작방법
- 새로운 feature 개발: 최신 develop의 변경사항을 local에 반영시킨다.
- 이슈를 열어서 이슈번호를 확인한다. 라벨로 표기하면 더욱 보기에 좋다. ex) [FEAT] 팀 관리 모달 api 연결
- $ git checkout develop : develop 브랜치로 checkout
- $ git pull : develop 브랜치의 최신 변경사항을 로컬로 가져온다.
- $ git checkout -b <닉네임_branch명/이슈번호> :명령어를 통해 브랜치 생성 후 checkout한다 ex) puppy_feat/#320
- 코드작성
- $ git add <file 명>: git add . 를 통해 모든 파일을 staging area에 추가할 수 있다.
- $ git commit -m "커밋메세지" ex) 커밋 규칙 확인
- $ git push origin : origin(원격 저장소)의 feature branch로 로컬 변경 내역을 push
- github에서 develop branch <- feature branch 방향으로 Pull Request 진행
- 리뷰가 종료되고 모두 Approve 된다면 Merge한다.
