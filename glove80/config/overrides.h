// NOTE: Use the many #define settings below to customize this keymap!
#define OPERATING_SYSTEM 'M' // choose 'L'inux, 'M'acOS, or 'W'indows
#define DIFFICULTY_LEVEL  0  // 0:custom, 1:easy -> 5:hard (see below)
#define ENABLE_MOUSE_KEYS    // requires HID_POINTING override to "y"
//#define ENFORCE_BILATERAL    // cancels single-handed home row mod+tap
//#define SPACE_FORGIVENESS  // allow lingering taps on the space bar
//#define THUMB_FORGIVENESS  // allow lingering taps on the thumb keys
//#define SHIFT_FORGIVENESS  // requires v24.08-beta or newer firmware
#define NATURAL_SCROLLING  // supports "natural scrolling" in macOS
//#define WORLD_USE_COMPOSE  // use native Compose in place of Unicode
//#define WORLD_HOST_AZERTY  // host computer is set to AZERTY locale
//#define WORLD_SHIFT_NUMBER // apply Shift to type number row digits
// TIP: Add more setting overrides here instead of editing them below.

// HRM config: balanced flavor, uniform timing (synced with Sofle working config)
#define HOMEY_HOLDING_TYPE "balanced"
#define HOMEY_REPEAT_DECAY 175

// Uniform streak decay (require-prior-idle-ms) - 75ms across all fingers
#define LEFT_PINKY_STREAK_DECAY 75    // A = Ctrl
#define RIGHT_PINKY_STREAK_DECAY 75   // ; = Ctrl
#define LEFT_RINGY_STREAK_DECAY 75    // S = Alt
#define RIGHT_RINGY_STREAK_DECAY 75   // L = Alt
#define LEFT_MIDDY_STREAK_DECAY 75    // D = GUI
#define RIGHT_MIDDY_STREAK_DECAY 75   // K = GUI
#define LEFT_INDEX_STREAK_DECAY 75    // F = Shift
#define RIGHT_INDEX_STREAK_DECAY 75   // J = Shift

// Uniform holding time (tapping-term-ms) - 280ms across all fingers
#define PINKY_HOLDING_TIME 280
#define RINGY_HOLDING_TIME 280
#define MIDDY_HOLDING_TIME 280
#define INDEX_HOLDING_TIME 280
