# 🎨 NexusScripts Custom Font Loader

<div align="center">

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
[![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.com/invite/devnexusshop)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

A powerful and easy-to-use custom font loader for Roblox UI development. Transform your user interface with custom fonts while maintaining performance and reliability.

</div>

## ✨ Features

- 🚀 **Easy Integration** - Simple API for registering and applying custom fonts
- 🎯 **Type Safety** - Full support for TextLabel, TextButton, and TextBox elements
- 🔍 **Debug Mode** - Built-in debugging capabilities for troubleshooting
- 📦 **Pre-loaded Fonts** - Comes with a selection of ready-to-use fonts
- ⚡ **Performance Optimized** - Efficient font loading and caching system

## 📋 Installation

1. Download the repository files
2. Include the following files in your project:
   - `custom_ui_fonts.lua` - Main library
   - `fonts/` directory - Contains font assets

## 🚀 Quick Start

```lua
-- Load the library
local CustomUIFonts = loadstring(readfile("custom_ui_fonts.lua"))()

-- Enable debug mode (optional)
CustomUIFonts.SetDebugMode(true)

-- Initialize default fonts
local fonts = CustomUIFonts.InitializeDefaultFonts()

-- Apply a font to a UI element
local success = CustomUIFonts.ApplyFont(myTextLabel, "ProggyClean")
```

## 💡 Usage Examples

### Register a Custom Font
```lua
local customFont = CustomUIFonts.Register_Font("MyFont", 200, "Normal", {
    Id = "MyFont.ttf",
    Font = game:HttpGet("your_font_url_here")
})
```

### List Available Fonts
```lua
local fontList = CustomUIFonts.GetAvailableFonts()
for _, fontName in ipairs(fontList) do
    print("Available font:", fontName)
end
```

## 📚 API Reference

### Core Functions

| Function | Description |
|----------|-------------|
| `InitializeDefaultFonts()` | Loads and initializes the default font set |
| `Register_Font(Name, Weight, Style, Asset)` | Registers a new custom font |
| `ApplyFont(uiElement, fontName)` | Applies a font to a UI element |
| `GetFont(fontName)` | Retrieves a font object by name |
| `GetAvailableFonts()` | Returns a list of all available fonts |
| `SetDebugMode(enabled)` | Toggles debug logging |

## 🔧 Default Fonts

- **ProggyClean** - Clean, modern programming font
- **TahomaBold** - Bold variant of the classic Tahoma
- **Leadcoat** - Stylish display font

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests

## 📬 Support

Need help? Join our [Discord community](https://discord.com/invite/devnexusshop) for support and updates.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

<div align="center">
Made with ❤️ by NexusScripts
</div> 