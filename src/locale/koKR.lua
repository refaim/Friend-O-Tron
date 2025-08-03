setfenv(1, FriendOTron)

if GetLocale() ~= "koKR" then return end

---@type LocaleStrings
LOCALE_STRINGS = {
    addon_loaded_message = "친구 복제 코어 활성화! 작동 매개변수는 '/fot help'를 통해 제어 인터페이스를 참조하세요",
    addon_help_message = "노움 인증 사용자 가이드: '/fot quiet' (스텔스 모드) 또는 '/fot noisy' (최대 열정)로 알림 설정",
    quiet_mode_enabled_message = "스텔스 모드 활성화! 친구 동기화 작업이 이제 조용히 실행됩니다. (사회적 탐지 시스템 우회)",
    noisy_mode_enabled_message = "최대 열정 모드 활성화! 모든 사회적 프로토콜이 이제 110%% 알림 용량으로 작동합니다! (재액적 친구 조화 임박)",
    add_friend_message_template_1 = "%s를 집단에 흡수했습니다! (우정 효율성 +12.7%%)",
    add_friend_message_template_2 = "%s를 소셜 배열에 강제 추가! (준수: 선택사항)",
    add_friend_message_template_3 = "%s와 자발적 동맹 생성! (의문을 품지 마세요)",
    add_friend_message_template_4 = "실수로 %s를 동기화! (어쨌든 유지...)",
    add_friend_message_template_5 = "%s에 대한 친구 프로토콜 활성화! (경고: 포옹을 유발할 수 있음)",
    remove_friend_message_template_1 = "데이터 뱅크에서 %s를 제거! (동기화 세금 징수됨)",
    remove_friend_message_template_2 = "%s에 대한 친구 프로토콜 종료. (베타 열정 오버플로)",
    remove_friend_message_template_3 = "예기치 않게 %s를 삭제! (기능입니다, 버그 아님!)",
    remove_friend_message_template_4 = "극도의 편견으로 %s를 절제! (사회적 응집력 +0.2%%)",
    remove_friend_message_template_5 = "%s를 구식으로 표시하고 제거! (감정적 RAM 해제)",
    save_friend_message_template_1 = "새로운 사회적 자산 발견: %s! (휘발성 메모리에 카탈로그 작성...)",
    save_friend_message_template_2 = "초기 데이터베이스 시딩을 위해 %s 캡처! (보존: 73%% 신뢰성)",
    save_friend_message_template_3 = "노움급 저장소에 %s 등록! (오차 범위: +-1 친구)",
    save_friend_message_template_4 = "%s의 최초 친구 각인 수행! (전원을 끄지 마세요!)",
    save_friend_message_template_5 = "%s를 베타 소셜 레지스트리에 할당! (백업 프로토콜: 비활성화됨)",
    save_multiple_friends_message_template_1 = "대량 소셜 카탈로그 시작! %d개의 우정 단위 처리 중... (휘발성 메모리 떨림)",
    save_multiple_friends_message_template_2 = "베타 테스트 친구 대량 가져오기! %d개의 사회적 유대 수화 중... (시스템 무결성: [계산 중])",
    save_multiple_friends_message_template_3 = "노움급 친구 압축 활성화! %d명의 친구를 불안정한 데이터베이스에 압축... (실드 12%%)",
    friend_list_full_message = "사회적 용량 오버플로! 새로운 연락처를 동화할 수 없습니다. (권장 사항: 기존 친구의 20%% 제거 또는 프리미엄 우정 라이선스로 업그레이드)",
}
