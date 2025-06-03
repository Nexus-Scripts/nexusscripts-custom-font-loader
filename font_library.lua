local FontLibrary = {}

local fonts = {}
local DEBUG_ENABLED = false

local function debugLog(message)
    if DEBUG_ENABLED then
        print("[FontLibrary Debug]", message)
    end
end

function FontLibrary.SetDebugMode(enabled)
    DEBUG_ENABLED = enabled
    debugLog("Debug mode " .. (enabled and "enabled" or "disabled"))
end

function FontLibrary.GetScreenSize()
    return Vector2.new(1920, 1080)
end

function FontLibrary.GetScreenCenter()
    local screenSize = FontLibrary.GetScreenSize()
    return Vector2.new(screenSize.X / 2, screenSize.Y / 2)
end

function FontLibrary.Register_Font(Name, Weight, Style, Asset)
    debugLog("Attempting to register font: " .. Name)
    
    if not isfile(Asset.Id) then
        debugLog("Font file doesn't exist, creating: " .. Asset.Id)
        writefile(Asset.Id, Asset.Font)
    else
        debugLog("Font file already exists: " .. Asset.Id)
    end
    
    if isfile(Name .. ".font") then
        debugLog("Removing existing font definition file")
        delfile(Name .. ".font")
    end
    
    local Data = {
        name = Name,
        faces = {
            {
                name = "Regular",
                weight = Weight,
                style = Style,
                assetId = getcustomasset(Asset.Id),
            },
        },
    }
    
    debugLog("Writing font definition file: " .. Name .. ".font")
    writefile(Name .. ".font", game:GetService("HttpService"):JSONEncode(Data))
    local fontAsset = getcustomasset(Name .. ".font")
    debugLog("Font asset created: " .. tostring(fontAsset))
    return fontAsset
end

function FontLibrary.InitializeDefaultFonts()
    debugLog("Initializing default fonts...")
    
    local proggyTiny = FontLibrary.Register_Font("ProggyTiny", 200, "Normal", {
        Id = "ProggyTiny.ttf",
        Font = game:HttpGet("https://github.com/Nexus-Scripts/nexusscripts-custom-font-loader/raw/main/fonts/tahoma_bold.ttf")
    })
    
    local proggyClean = FontLibrary.Register_Font("ProggyClean", 200, "Normal", {
        Id = "ProggyClean.ttf", 
        Font = game:HttpGet("https://github.com/Nexus-Scripts/nexusscripts-custom-font-loader/raw/main/fonts/ProggyClean.ttf")
    })
    
    debugLog("Creating Font objects...")
    fonts = {
        ["TahomaBold"] = Font.new(proggyTiny, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        ["ProggyClean"] = Font.new(proggyClean, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    }
    
    debugLog("Font initialization complete")
    return fonts
end

function FontLibrary.CreateTestLabel(fontName, yOffset)
    debugLog("Creating test label for font: " .. fontName)
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 600, 0, 100)
    frame.Position = UDim2.new(0.5, -300, 0.5, -50 + (yOffset or 0))
    frame.BackgroundTransparency = 0.8
    frame.BackgroundColor3 = Color3.new(0, 0, 0)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = fontName .. ": ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    label.TextScaled = true
    
    if fonts[fontName] then
        debugLog("Setting font for label: " .. fontName)
        label.FontFace = fonts[fontName]
    else
        debugLog("Warning: Font not found: " .. fontName)
    end
    
    label.TextColor3 = Color3.new(1, 1, 1)
    
    return frame
end

function FontLibrary.GetAvailableFonts()
    local fontList = {}
    for fontName, _ in pairs(fonts) do
        table.insert(fontList, fontName)
    end
    return fontList
end

return FontLibrary 