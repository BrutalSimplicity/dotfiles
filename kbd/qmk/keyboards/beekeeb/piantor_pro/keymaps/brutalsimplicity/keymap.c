// Copyright 2023 QMK
// SPDX-License-Identifier: GPL-2.0-or-later

#include QMK_KEYBOARD_H
#include "achordion.h"

#define KC_LEADER LGUI(LALT(LCTL(KC_NO)))
#define LEADER(x) MT(MOD_LGUI | MOD_LALT | MOD_LCTL, x)

enum custom_keycodes {
    SYM_LT = SAFE_RANGE,
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

#define SCRCPY_MAC LGUI(LCTL(LSFT(KC_4)))
#define NEXT_WORD LALT(KC_RIGHT)
#define PREV_WORD LALT(KC_LEFT)

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [LBASE] = LAYOUT_split_3x6_3(
        KC_TAB,         KC_Q,     KC_W,     KC_E,         KC_R,            KC_T, KC_Y, KC_U,         KC_I,         KC_O,   KC_P,    KC_LEADER,
        LEADER(KC_ESC), KC_A,     KC_S,     RCTL_T(KC_D), LSFT_T(KC_F),    KC_G, KC_H, RSFT_T(KC_J), RCTL_T(KC_K), KC_L,   KC_SCLN, CW_TOGG,
        MO(LBRD),        KC_Z,     KC_X,     KC_C,         KC_V,            KC_B, KC_N, KC_M,         KC_COMM,      KC_DOT, KC_SLSH, KC_ENTER,
        KC_LGUI,        MO(LRHS), MO(LNUM), KC_BSPC,      LT(LLHS,KC_SPC), KC_RALT
  ),

    [LNUM] = LAYOUT_split_3x6_3(
        _______, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_UNDS,  KC_7, KC_8, KC_9, KC_MINUS, _______,
        _______, _______, KC_NO,   KC_LCTL, KC_NO,   KC_NO, KC_COMMA, KC_4, KC_5, KC_6, KC_DOT,   QK_LOCK,
        _______, KC_NO,   KC_NO,   KC_NO,   KC_UNDS, KC_NO, KC_0,     KC_1, KC_2, KC_3, KC_SLASH, KC_NO,
        _______, _______, _______, _______,  _______, _______
  ),

    [LLHS] = LAYOUT_split_3x6_3(
        _______,  KC_EXLM, KC_AT,   KC_HASH,          KC_DLR,           KC_PERC, KC_HOME, PREV_WORD,       NEXT_WORD,     KC_END,           KC_NO,   _______,
        KC_GRAVE, KC_LCBR, KC_LPRN, LCTL_T(SYM_RPRN), LSFT_T(SYM_RCBR), KC_TILD, KC_LEFT, RSFT_T(KC_DOWN), RCTL_T(KC_UP), RALT_T(KC_RIGHT), KC_RGUI, KC_NO,
        _______,  KC_LBRC, KC_LT,   KC_GT,            KC_RBRC,          KC_BSLS, KC_NO,   KC_PGDN,         KC_PGUP,       KC_NO,            KC_NO,   KC_NO,
        _______,  _______, _______, KC_ENT,           _______,          _______
  ),

    [LRHS] = LAYOUT_split_3x6_3(
        _______, KC_NO,   KC_NO,   KC_NO,      KC_NO,   KC_NO, KC_CIRC, KC_EQUAL, KC_ASTR, KC_PLUS,  KC_MINUS, _______,
        _______, KC_NO,   KC_NO,   KC_LCTL,    KC_LSFT, KC_NO, KC_AMPR, KC_UNDS,  KC_DQUO, KC_QUOTE, KC_PIPE,  KC_CAPS,
        _______, KC_NO,   KC_NO,   SCRCPY_MAC, KC_NO,   KC_NO, KC_NO,   KC_COLON, KC_NO,   KC_NO,    KC_QUES,  KC_NO,
        _______, _______, _______, _______,    _______, _______
  ),

    [LBRD] = LAYOUT_split_3x6_3(
        QK_BOOT, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        KC_LGUI, _______, KC_SPC,  KC_ENT,  _______, KC_RALT
  )
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LSFT_T(KC_F):
        case RSFT_T(KC_J):
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
    }
    return true;
}

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
      return true;  // Eagerly apply left mods

    default:
      return false;
  }
}


uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LT(LLHS,KC_SPACE):
            return 0;
        default:
            return QUICK_TAP_TERM;
    }
}

uint16_t achordion_streak_chord_timeout(uint16_t tap_hold_keycode, uint16_t next_keycode) {
    return 100;
}

const key_override_t delete_key_override =
    ko_make_basic(MOD_MASK_SHIFT, KC_BSPC, KC_DEL);
const key_override_t **key_overrides = (const key_override_t *[]){
    &delete_key_override,
    NULL
};
