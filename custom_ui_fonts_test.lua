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
    frame.Size = UDim2.new(0, 600, 0, 300)
    frame.Position = UDim2.new(0.5, -300, 0.5, -150)
    frame.BackgroundTransparency = 1
    
    local txt1 = Instance.new("TextLabel", frame)
    txt1.Size = UDim2.new(1, 0, 0.33, 0)
    txt1.Position = UDim2.new(0, 0, 0, 0)
    txt1.BackgroundTransparency = 1
    txt1.Text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ (ProggyClean)"
    txt1.TextScaled = true
    txt1.FontFace = CustomUIFonts.GetFont("ProggyClean")
    txt1.TextColor3 = Color3.new(0.521568, 1, 0.262745)
    
    local txt2 = Instance.new("TextLabel", frame)
    txt2.Size = UDim2.new(1, 0, 0.33, 0)
    txt2.Position = UDim2.new(0, 0, 0.33, 0)
    txt2.BackgroundTransparency = 1
    txt2.Text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ (TahomaBold)"
    txt2.TextScaled = true
    txt2.FontFace = CustomUIFonts.GetFont("TahomaBold")
    txt2.TextColor3 = Color3.new(1, 0.8, 0.2)
    
    local txt3 = Instance.new("TextLabel", frame)
    txt3.Size = UDim2.new(1, 0, 0.33, 0)
    txt3.Position = UDim2.new(0, 0, 0.66, 0)
    txt3.BackgroundTransparency = 1
    txt3.Text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ (Leadcoat)"
    txt3.TextScaled = true
    txt3.FontFace = CustomUIFonts.GetFont("leadcoat")
    txt3.TextColor3 = Color3.new(0.4, 0.6, 1)
    
    wait(5)
    frame:Destroy()
end

print("[CustomFontsTest] Starting font test...")
local success, err = pcall(TestFonts)
if not success then
    print("[CustomFontsTest] Test failed:", err)
else
    print("[CustomFontsTest] Test completed successfully!")
end 