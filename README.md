# 🎨 Grapnote - Smart Drawing & Note-Taking App

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />
</div>

## ✨ Overview

**Grapnote** is a revolutionary smart drawing and note-taking app that transforms any touchscreen into a realistic digital notebook. Write or sketch naturally on your phone or tablet without needing an expensive stylus—use anything the screen can detect: a cheap stylus, charger tip, or even your finger!

### 🎯 Key Features

- **🖐️ Dual Palm Rejection Modes**:
  - **Standard Mode**: First touch draws, others ignored
  - **Palm-First Mode**: First touch ignored (palm), second touch draws ⭐ NEW!
- **📝 Natural Writing Experience**: Rest your palm on the screen just like on real paper—no accidental marks!
- **🎨 Multiple Drawing Tools**: 
  - Pen for precise writing and drawing
  - Highlighter for emphasizing important notes
  - Eraser for corrections (properly erases, not white paint!) ✨ FIXED!
- **🌈 Rich Color Palette**: 10 beautiful colors to choose from
- **📏 Adjustable Stroke Width**: Customize your pen thickness (1-20px)
- **↩️ Undo/Redo**: Never lose your work with full history support
- **🗑️ Clear Canvas**: Start fresh anytime
- **📄 Paper-Like Background**: Authentic notebook feel with beige paper texture
- **⚙️ Settings Dialog**: Easy mode switching with beautiful UI
- **🎭 Beautiful Modern UI**: Gradient accents and smooth animations
- **⚡ Smooth Performance**: Optimized rendering with custom painters

## 🚀 How It Works

### Dual Palm Rejection Modes

Grapnote offers **TWO innovative palm rejection systems**:

#### Mode 1: Standard Mode (Default)
1. When you touch the screen, Grapnote locks onto that first touch point (your stylus/finger)
2. All other touches are completely ignored (your palm, other fingers)
3. Only the locked touch point can draw on the canvas
4. When you lift your tool, the lock is released and ready for the next stroke

#### Mode 2: Palm-First Mode ⭐ NEW!
1. When you touch the screen, Grapnote **ignores** the first touch (assumes it's your palm)
2. The **second touch** becomes your drawing tool
3. All other touches are completely ignored
4. Perfect for users who naturally rest their palm before writing!

**Note**: In Palm-First Mode, you need at least 2 touches on screen. Single touch won't draw (this prevents accidental palm marks).

### Switch Modes Anytime
Tap the ⚙️ **Settings** button in the top toolbar to switch between modes!

### Benefits
- ✅ Rest your entire palm on the screen
- ✅ Write at any angle
- ✅ Use any object as a stylus
- ✅ Get a paper-like experience for free!

## 📱 Screenshots

*The app features:*
- Clean, modern interface with gradient purple branding
- Large white canvas with paper-like background
- Bottom toolbar with tool selection
- Color picker with smooth animations
- Stroke width slider for precision control

## 🛠️ Technical Architecture

### Project Structure

```
lib/
├── main.dart                    # App entry point and theme configuration
├── drawing/
│   ├── stroke.dart             # Stroke model with drawing data
│   ├── drawing_controller.dart # State management & palm rejection logic
│   └── drawing_painter.dart    # Custom painter for rendering strokes
└── screens/
    └── grapnote_page.dart      # Main UI and user interactions
```

### Core Components

#### 1. **Stroke Model** (`stroke.dart`)
- Represents individual drawing strokes
- Stores points, color, width, and tool type
- Supports pen, highlighter, and eraser tools

#### 2. **Drawing Controller** (`drawing_controller.dart`)
- Implements the one-touch lock system
- Manages stroke history and undo/redo stacks
- Handles pointer events (down, move, up, cancel)
- Notifies UI of state changes using ChangeNotifier

#### 3. **Drawing Painter** (`drawing_painter.dart`)
- Custom painter for high-performance rendering
- Draws smooth bezier curves for natural strokes
- Applies tool-specific effects (transparency for highlighter)
- Optimized with shouldRepaint logic

#### 4. **Grapnote Page** (`grapnote_page.dart`)
- Main UI with toolbar and canvas
- Pointer event listeners for drawing
- Color picker and width adjustment
- Animated tool selection

## 🎨 Design Features

### Color Scheme
- **Primary**: `#6B4CE6` (Purple)
- **Secondary**: `#9D5CE8` (Light Purple)
- **Canvas**: White with subtle shadow
- **Background**: `#F5F5DC` (Beige - paper texture)

### UI/UX Highlights
- Gradient buttons with shadow effects
- Smooth color transitions
- Responsive touch interactions
- Clear visual feedback
- Minimalist, distraction-free interface

## 🔧 Installation & Setup

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator / iOS simulator

### Steps

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd grapnote
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Release

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  path_provider: ^2.1.5  # For future save/load functionality
```

## 🎯 Usage Guide

### Choosing Your Palm Rejection Mode

1. Tap the **⚙️ Settings** button in the app bar
2. Choose between:
   - **Standard Mode**: Start writing first, rest palm after (first touch draws)
   - **Palm-First Mode**: Rest palm first, then write (second touch draws)
3. Tap **Done**

### Basic Drawing
1. Launch Grapnote
2. Select your palm rejection mode (if needed)
3. Select a tool (Pen, Highlighter, or Eraser)
4. Choose your color from the color palette
5. Adjust stroke width using the slider
6. Start drawing! Rest your palm naturally on the screen

### Palm Rejection Usage

#### Standard Mode
- **First touch wins**: The first contact point is your drawing tool
- **Palm ignored**: All other touches are automatically ignored
- **Natural writing**: Start writing, then rest your palm

#### Palm-First Mode ⭐ NEW!
- **Palm first**: Rest your palm on the screen first
- **Then write**: Your second touch (stylus/finger) draws
- **Most natural**: Mimics real paper writing experience
- **Need 2 touches**: Single touch won't draw (prevents accidental marks)

### Tools
- **Pen**: Standard drawing tool for precise lines
- **Highlighter**: Semi-transparent wide strokes
- **Eraser**: Properly erases previous strokes (not just white paint!)

### Canvas Management
- **Undo**: Tap the undo button to remove last stroke
- **Redo**: Restore undone strokes
- **Clear**: Remove all drawings (with confirmation)
- **Settings**: Configure palm rejection mode

## 🔮 Future Enhancements

- [ ] Save/Load drawings
- [ ] Export to PNG/PDF
- [ ] Multiple pages support
- [ ] Text tool for typing
- [ ] Shape tools (line, circle, rectangle)
- [ ] Layers support
- [ ] Cloud sync
- [ ] Pressure sensitivity (for devices that support it)
- [ ] Zoom and pan
- [ ] Custom color picker

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Developer

Built with ❤️ using Flutter

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open-source community for inspiration
- All users who believe in affordable, accessible note-taking

---

**Made for everyone who wants a paper-like writing experience without expensive hardware!** ✨
