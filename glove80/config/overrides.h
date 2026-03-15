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

// HRM config: balanced flavor, per-finger tuning
#define HOMEY_HOLDING_TYPE "balanced"
#define HOMEY_REPEAT_DECAY 175

// Per-finger streak decay (require-prior-idle-ms)
// Higher = safer from misfires, but slower to activate as modifier
#define LEFT_PINKY_STREAK_DECAY 150   // A = Ctrl (slow finger, needs more time)
#define RIGHT_PINKY_STREAK_DECAY 150  // ; = Ctrl
#define LEFT_RINGY_STREAK_DECAY 100   // S = Alt (Alt+Bksp needs to be fast)
#define RIGHT_RINGY_STREAK_DECAY 100  // L = Alt
#define LEFT_MIDDY_STREAK_DECAY 100   // D = GUI
#define RIGHT_MIDDY_STREAK_DECAY 100  // K = GUI
#define LEFT_INDEX_STREAK_DECAY 150   // F = Shift (most misfire-prone)
#define RIGHT_INDEX_STREAK_DECAY 150  // J = Shift

// Per-finger holding time (tapping-term-ms)
#define PINKY_HOLDING_TIME 300        // pinky is slower
#define RINGY_HOLDING_TIME 280
#define MIDDY_HOLDING_TIME 260        // middle finger is fastest
#define INDEX_HOLDING_TIME 260
