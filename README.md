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
- 이슈 타이틀은 영어로 작성한다.
- 이슈 생성시 라벨을 단다.(main, develop, feature, release, hotfix)
```shell
git branch "feature/#32-fix maintitle View"
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
git commit -m "[Feat] Make SignIn, SignOut, [Chore] Add title Image in asset, [Fix] Fix func addBookMark, [Add] Add ToastView"
```

## 깃 조작방법
- 이슈 등록
- 이슈에서 라벨 등록, 어싸인, Development에서 create branch
- Local에서 pull 한다.
```shell
git pull
```
- 이슈 넘버를 포함하는 브랜치로 switch
```shell
git switch feat/#1~~~~~~
```
## 코드작성
- 변경 파일을 추가한다.
```shell
git add <file 명>: git add .
```
- 커밋 규칙에 맞춰서 커밋
- 커밋은 최대한 자주, 잘게 조게서 한다.
```shell
git commit -m "커밋메세지"
```
- 레포에 반영한다.
```shell
git push
```
- pr한다
