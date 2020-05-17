# Intellij 단축키 모음!  

| **설명**                                   | **Window**              | **Mac**                      | **Key map**                                                  |
|--------------------------------------------|-------------------------|------------------------------|--------------------------------------------------------------|
| **코드 Edit**                              |                         |                              |                                                              |
| 디렉터리, 패키지, 클래스 등 생성 목록 보기 |                         | Cmd + N                      | Main menu > Code > Generate...                               |
| 실행환경 실행 (현재 포커스)                | Shift + Ctrl + F10      | Ctrl + Shift + R             | Other > Run context configuration                            |
| 실행환경 실행(이전 실행)                   | Shift + F10             | Ctrl + R                     | Main menu > Run > Run                                        |
| 라인 복제하기                              | Ctrl + D                | Cmd + D                      | Main menu > Edit > Duplicate Line or Selection               |
| 라인 삭제 하기                             | Ctrl + Y                | Cmd + 백스페이스             | Main menu > Edit > Delete                                    |
| 문자열 라인 합치기                         | Ctrl + Shift + J        | Ctrl + Shift + J             | Main menu > Edit > Join Lines                                |
| 특정 라인 이동                             | Ctrl + L                | Cmd + L                      | Main menu -> Navigate→ Line/Column…                          |
| 라인 단위로 옮기기 (구문 이동)             | Shift + Ctrl + Up/Down  | Shift + Cmd + Up/Down        | Main menu > Code > Move Satement Up                          |
| 라인 단위로 옮기기 (라인 이동)             | Shift + Alt + Up/Down   | Shift + Option + Up/Down     | Main menu > Code > Move Line Up                              |
| 인자값 즉시 보기                           | Ctrl + P                | Cmd + P                      | Main menu > View > Parameter Info                            |
| 코드 구현부 즉시 보디                      | Shift + Ctrl + I        | Option + Space               | Main menu > View > Quick Definition                          |
| Doc 즉시 보기                              | Ctrl + Q                | F1                           | Main menu > View > Quick Documentation                       |
| **포커스**                                 |                         |                              |                                                              |
| 단어별 이동                                |                         | Option + Left, Right         | Editor Actions -> Move Caret to Previous Word                |
| 단어별 이동 + 선택                         |                         | Option + Shift + Left, Right | Editor Actions -> Move Caret to Previous Word with Selection |
| 라인 끝으로 이동                           |                         | Cmd + Left, Right            | Editor Actions -> Move Caret to line start /                 |
| 라인 복사                                  |                         | Fn + Shift + Left, Right     | Editor Actions -> Move Caret to line Start with selection /  |
| Page up / down                             |                         | Fn + Up, Down                | Editor actions -> Page up, down                              |
| 포커스 범위 한 단계씩 늘리기               |                         | Option + Up, Down            | Editor Actions > Extend Selection                            |
| 포커스 뒤로/앞으로 가기                    | Ctrl + Alt + Left/Right | Cmd + [, ]                   | Editor Actions + Move Caret to Line Start                    |
| 멀티 포커스                                |                         | Option *2 +  Up, Down        |                                                              |
| 오류 라인으로 자동 포커스                  |                         | F2                           | Main menu > Navigate > Next Highlighted Error                |
| **검색**                                   |                         |                              |                                                              |
| 현재 파일에서 검색                         | Ctrl + F                | Cmd + F                      |                                                              |
| 현재 파일에서 교체                         |                         | Cmd + R                      |                                                              |
| 전체에서 검색                              | Ctrl + Shift + F        | Cmd + Shift + F              | Main menu -> Edit -> Find -> Find in Path …                  |
| 전체에서 교체                              | Ctrl + Shift + R        | Cmd + Shift + R              | * \/path1\/[A-Za-z]*\/app.js   \/newPath1\/$1\/app.js        |
| 파일 검색                                  | Shift + Ctrl + N        | Cmd + Shift + O              |                                                              |
| 메소드 검색                                | Shift + Ctrl + Alt + N  | Cmd + Option + O             |                                                              |
| Action 검색                                | Shift + Ctrl + A        | Cmd + Shift + A              |                                                              |
| 최근 열었던 파일 목록 보기                 | Ctrl + E                | Cmd + E                      |                                                              |
| 최근 수정한 파일 목록 보기                 | Ctrl + Shift + E        | Cmd + Shift + E              |                                                              |
| (변수, 메소드 등) 사용하는 부분 찾기       | Ctrl + G                | Option + F7                  | Main menu -> Edit -> Find -> Find Usages                     |
| **자동완성**                               |                         |                              |                                                              |
| Action 보이기                              | Alt + Enter             | Option + Enter               | Other -> Show Context Actions                                |
| 리턴값 추출                                | Alt + Shift + L         | Option + Cmd + V             | Main menu -> Refactor -> Extract -> Introduce Variable …     |
| 스마트 자동 완성                           |                         | Cmd + Shift + Space          |                                                              |
| 스태틱 메소드 자동 완성                    | Ctrl + Space * 2        | Cmd + Space * 2              |                                                              |
| Getter/Setter/생성자 자동완성              | Alt + Insert            | Cmd + N                      | Main menu -> Code -> Generate…                               |
| Override 메소드 자동완성                   |                         | Ctrl + I                     |                                                              |
| **LiveTemplate**                           |                         |                              |                                                              |
| 목록 보기                                  |                         | Cmd + J                      |                                                              |
| **리택토링**                               |                         |                              |                                                              |
| 변수 추출하기                              | Ctrl + Alt + V          | Cmd + Option + V             |                                                              |
| 파라미터 추출하기                          | Ctrl + Alt + P          | Cmd + Option + P             |                                                              |
| 메소드 추출하기                            | Ctrl + Alt + M          | Option + Cmd + M             |                                                              |
| 이너클래스 추출하기                        | F6                      | F6                           |                                                              |
| 이름 일괄 변경하기                         | Shift + F6              | Shift + F6                   |                                                              |
| 타입 일괄 변경하기                         | Shift + Ctrl + F6       | Cmd + Shift + F6             |                                                              |
| Import 정리하기                            | Ctrl + Alt + O          | Ctrl + Option + O            |                                                              |
| 코드 자동 정렬하기                         | Ctrl + Alt + L          | Cmd + Option + L             |                                                              |


---  

# References  

- https://www.inflearn.com/course/intellij-guide/dashboard
