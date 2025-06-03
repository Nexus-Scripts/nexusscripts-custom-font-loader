local function LoadCustomUIFonts()
    print("[CustomFontsTest] Attempting to load custom UI fonts library...")
    local success, content = pcall(function()
        return readfile("custom_ui_fonts.lua")
    end)
    
    if not success then
        error("Failed to load custom UI fonts library: " .. tostring(content))
        return
    end
    
    print("[CustomFontsTest] Library file loaded successfully")
    
    local success2, CustomUIFonts = pcall(function()
        return loadstring(content)()
    end)
    
    if not success2 then
        error("Failed to execute custom UI fonts library: " .. tostring(CustomUIFonts))
        return
    end
    
    print("[CustomFontsTest] Library initialized successfully")
    return CustomUIFonts
end

local function TestFonts()
    local CustomUIFonts = LoadCustomUIFonts()
    if not CustomUIFonts then
        print("[CustomFontsTest] Failed to load CustomUIFonts")
        return
    end
    
    CustomUIFonts.SetDebugMode(true)
    print("[CustomFontsTest] Initializing default fonts...")
    local fonts = CustomUIFonts.InitializeDefaultFonts()
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 800, 0, 700)
    frame.Position = UDim2.new(0.5, -400, 0.5, -350)
    frame.BackgroundTransparency = 1

    local fontConfigs = {
        {name = "ProggyClean", color = Color3.new(0.521568, 1, 0.262745)},
        {name = "TahomaBold", color = Color3.new(1, 0.8, 0.2)},
        {name = "leadcoat", color = Color3.new(0.4, 0.6, 1)},
        {name = "MinecraftiaRegular", color = Color3.new(1, 0.4, 0.4)},
        {name = "ProggyTiny", color = Color3.new(0.8, 0.4, 1)},
        {name = "fstahoma8px", color = Color3.new(0.4, 1, 0.8)},
        {name = "smallest_pixel", color = Color3.new(1, 0.6, 0.2)}
    }

    for i, config in ipairs(fontConfigs) do
        local txt = Instance.new("TextLabel", frame)
        txt.Size = UDim2.new(1, 0, 0.14, 0)
        txt.Position = UDim2.new(0, 0, 0.14 * (i-1), 0)
        txt.BackgroundTransparency = 0.9
        txt.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        txt.Text = string.format("ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890 (%s)", config.name)
        txt.TextScaled = true
        txt.FontFace = CustomUIFonts.GetFont(config.name)
        txt.TextColor3 = config.color
    end
    
    wait(10)
    frame:Destroy()
end

print("[CustomFontsTest] Starting font test...")
local success, err = pcall(TestFonts)
if not success then
    print("[CustomFontsTest] Test failed:", err)
else
    print("[CustomFontsTest] Test completed successfully!")
end 