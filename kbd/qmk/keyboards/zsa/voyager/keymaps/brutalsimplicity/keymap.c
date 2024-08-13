#include "keycodes.h"
#include "quantum_keycodes.h"
#include "voyager.h"
#include QMK_KEYBOARD_H
#define MOON_LED_LEVEL LED_LEVEL

/**
  [LAYER] = LAYOUT_voyager(
    KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
    KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
    KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
    KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,
    KC_NO, KC_NO, KC_NO, KC_NO
  ),
* */
enum custom_keycodes {
    RGB_SLD = ML_SAFE_RANGE,
    HSV_0_255_255,
    HSV_74_255_255,
    HSV_169_255_255,
    SYM_LT,
    SYM_RPRN,
    SYM_LPRN,
    SYM_RCBR,
    SYM_LCBR,
};

enum layers {
    LBASE,
    LNUM,
    LLHS,
    LRHS,
    LFN,
    LBRD,
};

#define KT_PREFIX LGUI(LALT(LCTL(KC_NO)))
#define PREFIX(x) MT(MOD_LGUI | MOD_LALT | MOD_LCTL, x)
#define LPREFIX PREFIX(KC_ESC)

#define SCRCPY_MAC LGUI(LCTL(LSFT(KC_4)))
#define NEXT_WORD LALT(KC_RIGHT)
#define PREV_WORD LALT(KC_LEFT)
#define NEXT_WIN LGUI(KC_TAB)
#define PREV_WIN LGUI(LSFT(KC_TAB))

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [LBASE] = LAYOUT(
    KC_NO,    KC_1,             KC_2,         KC_3,         KC_4,          KC_5, KC_6, KC_7,         KC_8,         KC_9,         KC_0,            MO(LBRD),
    KC_TAB,   KC_Q,             KC_W,         KC_E,         KC_R,          KC_T, KC_Y, KC_U,         KC_I,         KC_O,         KC_P,            KT_PREFIX,
    LPREFIX,  LGUI_T(KC_A),     LALT_T(KC_S), LCTL_T(KC_D), LSFT_T(KC_F),  KC_G, KC_H, RSFT_T(KC_J), RCTL_T(KC_K), LALT_T(KC_L), RGUI_T(KC_SCLN), CW_TOGG,
    KC_MEH,   KC_Z,             KC_X,         KC_C,         LT(LNUM,KC_V), KC_B, KC_N, KC_M,         KC_COMMA,     KC_DOT,       KC_SLASH,        KC_MEH,
    MO(LRHS), LGUI_T(KC_ENTER), KC_BSPC,      LT(LLHS,KC_SPACE)
  ),
  [LNUM] = LAYOUT(
    KC_NO,   KC_NO,   KC_NO,           KC_NO,   KC_NO,   KC_NO, KC_NO,    KC_NO, KC_NO, KC_NO, KC_NO,    KC_NO,
    _______, KC_NO,   KC_NO,           KC_NO,   KC_NO,   KC_NO, KC_UNDS,  KC_7,  KC_8,  KC_9,  KC_MINUS, _______,
    _______, KC_LGUI, KC_LALT,         KC_LCTL, KC_NO, KC_NO, KC_COMMA, KC_4,  KC_5,  KC_6,  KC_DOT,   QK_LLCK,
    _______, KC_NO,   KC_NO,           KC_NO,   KC_NO, KC_NO, KC_0,     KC_1,  KC_2,  KC_3,  KC_SLASH, KC_NO,
    _______, _______, LT(LFN,KC_BSPC), _______
  ),
  [LLHS] = LAYOUT(
    KC_NO,    KC_NO,            KC_NO,            KC_NO,            KC_NO,            KC_NO,   KC_NO,   KC_NO,           KC_NO,         KC_NO,            KC_NO,   _______,
    _______,  KC_EXLM,          KC_AT,            KC_HASH,          KC_DLR,           KC_PERC, KC_HOME, PREV_WORD,       NEXT_WORD,     KC_END,           KC_NO,   _______,
    KC_GRAVE, LGUI_T(SYM_LCBR), LALT_T(SYM_LPRN), LCTL_T(SYM_RPRN), LSFT_T(SYM_RCBR), KC_TILD, KC_LEFT, RSFT_T(KC_DOWN), RCTL_T(KC_UP), RALT_T(KC_RIGHT), KC_RGUI, KC_NO,
    _______,  KC_LBRC,          KC_LT,            KC_GT,            KC_RBRC,          KC_BSLS, KC_NO,   KC_PGDN,         KC_PGUP,       KC_NO,            KC_NO,   KC_NO,
    _______,  _______,         _______,          _______
  ),
  [LRHS] = LAYOUT(
    KC_NO,   KC_NO,   KC_NO,   KC_NO,      KC_NO,   KC_NO, KC_NO,   NEXT_WIN, PREV_WIN, KC_NO,    KC_NO,    KC_NO,
    _______, KC_NO,   KC_NO,   KC_NO,      KC_NO,   KC_NO, KC_CIRC, KC_EQUAL, KC_ASTR,  KC_PLUS,  KC_MINUS, _______,
    _______, KC_LGUI, KC_LALT, KC_LCTL,    KC_LSFT, KC_NO, KC_AMPR, KC_UNDS,  KC_DQUO,  KC_QUOTE, KC_PIPE,  KC_CAPS,
    _______, KC_NO,   KC_NO,   SCRCPY_MAC, KC_NO,   KC_NO, KC_NO,   KC_COLON, KC_NO,    KC_NO,    KC_QUES,  KC_NO,
    _______, _______, _______, _______
  ),
  [LFN] = LAYOUT(
    KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO,  KC_NO,
    _______, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO, KC_F7, KC_F8, KC_F9, KC_F12, KC_NO,
    _______, KC_NO,   KC_NO,   KC_LCTL, KC_LSFT, KC_NO, KC_NO, KC_F4, KC_F5, KC_F6, KC_F11, KC_NO,
    _______, KC_LGUI, KC_LALT, KC_NO,   KC_NO,   KC_NO, KC_NO, KC_F1, KC_F2, KC_F3, KC_F10, KC_NO,
    _______, _______, _______, _______
  ),
  [LBRD] = LAYOUT(
    RGB_TOG, TOGGLE_LAYER_COLOR,  RGB_MODE_FORWARD,    RGB_SLD,         RGB_VAD,             RGB_VAI,         _______, _______, _______, _______, _______, _______,
    _______, _______,             KC_AUDIO_VOL_DOWN,   KC_AUDIO_VOL_UP, KC_AUDIO_MUTE,       _______,         _______, _______, _______, _______, _______, _______,
    KO_TOGG, KC_MEDIA_PREV_TRACK, KC_MEDIA_NEXT_TRACK, KC_MEDIA_STOP,   KC_MEDIA_PLAY_PAUSE, _______,         _______, _______, _______, _______, _______, _______,
    QK_BOOT, _______,             _______,             HSV_0_255_255,   HSV_74_255_255,      HSV_169_255_255, _______, _______, _______, _______, _______, _______,
    _______, _______,             _______,             _______
  ),
};


uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LSFT_T(KC_F):
        case RSFT_T(KC_J):
        case LCTL_T(KC_D):
        case RCTL_T(KC_K):
            return TAPPING_TERM -30;
        case LT(LLHS,KC_SPACE):
            return TAPPING_TERM -20;
        default:
            return TAPPING_TERM;
    }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LSFT_T(SYM_RCBR):
            if (record->event.pressed && record->tap.count) {
                tap_code16(KC_RCBR);
                return false;
            }
            break;
        case LGUI_T(SYM_LCBR):
            if (record->event.pressed && record->tap.count) {
                tap_code16(KC_LCBR);
                return false;
            }
            break;
        case LCTL_T(SYM_RPRN):
            if (record->event.pressed && record->tap.count) {
                tap_code16(KC_RPRN);
                return false;
            }
            break;
        case LALT_T(SYM_LPRN):
            if (record->event.pressed && record->tap.count) {
                tap_code16(KC_LPRN);
                return false;
            }
            break;
        case LALT_T(SYM_LT):
            if (record->event.pressed && record->tap.count) {
                tap_code16(KC_LT);
                return false;
            }
            break;
        case RGB_SLD:
            if (record->event.pressed) {
                rgblight_mode(1);
            }
            return false;
        case HSV_0_255_255:
            if (record->event.pressed) {
                rgblight_mode(1);
                rgblight_sethsv(0, 255, 255);
            }
            return false;
        case HSV_74_255_255:
            if (record->event.pressed) {
                rgblight_mode(1);
                rgblight_sethsv(74, 255, 255);
            }
            return false;
        case HSV_169_255_255:
            if (record->event.pressed) {
                rgblight_mode(1);
                rgblight_sethsv(169, 255, 255);
            }
            return false;
    }
    return true;
}

#ifdef ACHORDION_ENABLE
// By default, use the BILATERAL_COMBINATIONS rule to consider the tap-hold key
// "held" only when it and the other key are on opposite hands.
// Add exceptions for tap-hold keys we want to ignore the achordion rules
bool achordion_chord(uint16_t tap_hold_keycode, keyrecord_t* tap_hold_record, uint16_t other_keycode, keyrecord_t* other_record) {
    // Ignore rules for all thumb keys (keys on the bottom row)
    if (other_record->event.key.row % (MATRIX_ROWS / 2) >= 4) { return true; }

    return achordion_opposite_hands(tap_hold_record, other_record);
}

// Override default achordion timeout (1000), and ingore timeout for
// tap-hold keys we want to ignore the achordion rules
uint16_t achordion_timeout(uint16_t tap_hold_keycode) {
    // Ignore achordion rules for all thumb keys
    // with tap-hold assignments (timeout of 0 causes achordion to ignores rules)
    switch (tap_hold_keycode) {
        case LT(LLHS,KC_SPACE):
        case LGUI_T(KC_ENTER):
        case LPREFIX:
            return 0;
    }
    return 800;
}

bool achordion_eager_mod(uint8_t mod) {
  switch (mod) {
    case MOD_LSFT:
    case MOD_LCTL:
    case MOD_RSFT:
    case MOD_RCTL:
    case MOD_RGUI:
      return true;  // Eagerly apply left mods

    default:
      return false;
  }
}


uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LT(LLHS,KC_SPACE):
            return 0;
        // case LT(LNUM,KC_A):
        //     return 125;
        default:
            return QUICK_TAP_TERM;
    }
}

uint16_t achordion_streak_chord_timeout(uint16_t tap_hold_keycode, uint16_t next_keycode) {
    return 100;
}
#endif

const key_override_t delete_key_override =
    ko_make_basic(MOD_MASK_SHIFT, KC_BSPC, KC_DEL);
const key_override_t **key_overrides = (const key_override_t *[]){
    &delete_key_override,
    NULL
};

