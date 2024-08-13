/*
  Set any config.h overrides for your specific keymap here.
  See config.h options at https://docs.qmk.fm/#/config_options?id=the-configh-file
*/
#define ORYX_CONFIGURATOR
#undef IGNORE_MOD_TAP_INTERRUPT

#define QUICK_TAP_TERM_PER_KEY
#define USB_SUSPEND_WAKEUP_DELAY 0
#define CAPS_LOCK_STATUS
#define FIRMWARE_VERSION u8"7REwy/WBeO4"
#define RAW_USAGE_PAGE 0xFF60
#define RAW_USAGE_ID 0x61
#define LAYER_STATE_8BIT

#define TAPPING_TERM_PER_KEY
#define RGB_MATRIX_STARTUP_SPD 60
#define ARCHORDION_STREAK
#define ONESHOT_TIMEOUT 2500
