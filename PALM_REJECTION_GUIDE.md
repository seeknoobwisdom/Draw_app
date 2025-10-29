# 🎨 Palm Rejection Modes Guide

## Overview
Grapnote now offers **TWO palm rejection modes** to match your natural writing style!

---

## 🖊️ Mode 1: Standard Mode (Default)

### How It Works
1. **First touch = Drawing tool** ✍️
2. All subsequent touches are ignored (palm rejection)
3. Best for users who start writing before resting their palm

### Perfect For:
- Quick sketching
- Users who lift their palm frequently
- Writing with finger or stylus-first approach
- Tablet users with active styluses

### Visual Flow:
```
Touch 1 (Stylus) → DRAWS ✓
Touch 2 (Palm)   → IGNORED
Touch 3 (Finger) → IGNORED
Touch 4+ (Any)   → IGNORED
```

---

## 🖐️ Mode 2: Palm-First Mode ⭐ NEW!

### How It Works
1. **First touch = IGNORED** (assumed to be palm)
2. **Second touch = Drawing tool** ✍️
3. All subsequent touches are ignored
4. Best for users who naturally rest their palm before writing

### Perfect For:
- Natural palm-down writing style
- Users coming from paper notebooks
- Comfortable long writing sessions
- More realistic paper experience

### Visual Flow:
```
Touch 1 (Palm)   → IGNORED (waiting...)
Touch 2 (Stylus) → DRAWS ✓
Touch 3 (Finger) → IGNORED
Touch 4+ (Any)   → IGNORED
```

### Important Note:
⚠️ **Single touch won't draw!** You need at least two touches:
- First touch (palm) → ignored
- Second touch (stylus) → draws

This prevents accidental marks and ensures your palm is always ignored.

---

## 🔄 Switching Between Modes

### How to Change:
1. Tap the **⚙️ Settings** button in the top toolbar
2. Choose your preferred mode:
   - **Standard Mode**: First touch draws
   - **Palm-First Mode**: First touch ignored, second draws
3. Tap **Done**

### Live Switching:
- Mode changes take effect immediately
- Current stroke is cleared when switching
- No need to restart the app

---

## 🎯 Which Mode Should You Use?

### Choose **Standard Mode** if you:
- ✅ Start writing before placing your palm
- ✅ Use a stylus with hover detection
- ✅ Prefer quick, single-touch drawing
- ✅ Don't rest your palm much while writing

### Choose **Palm-First Mode** if you:
- ✅ Naturally rest your palm first (like on paper!)
- ✅ Want the most realistic notebook experience
- ✅ Write for extended periods
- ✅ Come from traditional note-taking
- ✅ Use cheap styluses or improvised tools

---

## 🛠️ Technical Implementation

### Standard Mode Logic:
```dart
onPointerDown(event) {
  if (_activePointerId == null) {
    _activePointerId = event.pointer;  // Lock to first touch
    startDrawing();
  }
  // All other touches ignored
}
```

### Palm-First Mode Logic:
```dart
onPointerDown(event) {
  if (_ignoredPointerId == null) {
    _ignoredPointerId = event.pointer;  // Ignore first touch
  } else if (_activePointerId == null) {
    _activePointerId = event.pointer;  // Lock to second touch
    startDrawing();
  }
  // All other touches ignored
}
```

---

## 🎨 Eraser Fix

### What Was Fixed:
The eraser now properly **erases** previous strokes instead of just drawing white lines!

### Technical Details:
- Uses `BlendMode.clear` for true transparency
- Implemented `saveLayer` for proper compositing
- Works on any background color
- Erases all drawing tools (pen, highlighter, previous eraser marks)

### Before:
```dart
// Old: Drew white paint (doesn't erase, just covers)
paint.color = Colors.white;
```

### After:
```dart
// New: True erasing with blend mode
paint.blendMode = BlendMode.clear;
canvas.saveLayer(...);  // Proper layer compositing
```

---

## 💡 Pro Tips

### For Palm-First Mode:
1. **Place palm first**: Rest your palm comfortably on the screen
2. **Then write**: Touch with stylus/finger to start drawing
3. **Keep palm down**: You can keep your palm rested while writing
4. **Lift both**: When done with a stroke, lift stylus then palm (or together)

### For Standard Mode:
1. **Touch to draw**: Start drawing immediately with your tool
2. **Rest palm anytime**: Place palm down after starting
3. **Natural flow**: Write as you normally would

### For Best Experience:
- 🎯 Experiment with both modes to find your preference
- 📏 Adjust stroke width for your writing style (3-5px recommended)
- 🎨 Use different colors for organization
- ↩️ Don't forget undo/redo for corrections

---

## 🚀 Future Enhancements

Potential additions:
- [ ] Automatic mode detection based on writing style
- [ ] Custom pointer count (ignore first N touches)
- [ ] Pressure sensitivity support
- [ ] Hover detection for compatible styluses
- [ ] Per-tool mode settings

---

## 📊 Comparison Table

| Feature | Standard Mode | Palm-First Mode |
|---------|---------------|-----------------|
| First Touch | **Draws** ✍️ | **Ignored** 🖐️ |
| Second Touch | Ignored | **Draws** ✍️ |
| Single Touch Drawing | ✅ Yes | ❌ No (needs 2) |
| Palm Protection | ✅ Yes | ✅ Yes |
| Best For | Quick notes | Long writing |
| Paper-like Feel | Good | **Excellent** |
| Learning Curve | Easy | Very Easy |

---

## 🎓 Usage Examples

### Scenario 1: Taking Class Notes (Palm-First Mode)
```
1. Open Grapnote
2. Enable Palm-First Mode in settings
3. Rest palm on screen
4. Write with stylus naturally
5. Palm stays ignored throughout!
```

### Scenario 2: Quick Sketch (Standard Mode)
```
1. Keep Standard Mode (default)
2. Start drawing immediately
3. Rest palm if needed
4. Lift and repeat
```

### Scenario 3: Annotating Document (Either Mode)
```
Standard: Quick marks, lift palm between notes
Palm-First: Rest palm, make detailed annotations
```

---

## ❓ FAQ

**Q: Why doesn't anything draw in Palm-First Mode?**
A: You need TWO touches! First touch (palm) is ignored, second touch draws.

**Q: Can I switch modes mid-drawing?**
A: Yes! But current stroke will be cleared for clean mode transition.

**Q: Which mode is better?**
A: Try both! Most users who write a lot prefer Palm-First Mode for comfort.

**Q: Does the eraser work in both modes?**
A: Yes! The eraser works perfectly in both modes and properly erases strokes.

**Q: What if I have 3+ fingers on screen?**
A: Only the designated drawing touch works. All others are ignored automatically.

---

## 🌟 Benefits Summary

### Standard Mode:
- ⚡ Instant drawing
- 🎯 Single-touch simplicity
- 🚀 Great for quick notes

### Palm-First Mode:
- 📝 Most natural writing experience
- 🖐️ Rest palm like on real paper
- ⭐ Perfect for long note-taking sessions
- 💯 Feels like using a real notebook

---

**Choose your mode and enjoy a paper-like writing experience! ✨**
