local CustomUIFonts = {}
local fonts = {}
local DEBUG_ENABLED = false

local function debugLog(message)
    if DEBUG_ENABLED then
        print("[CustomUIFonts Debug]", message)
    end
end

function CustomUIFonts.SetDebugMode(enabled)
    DEBUG_ENABLED = enabled
    debugLog("Debug mode " .. (enabled and "enabled" or "disabled"))
end

function CustomUIFonts.Register_Font(Name, Weight, Style, Asset)
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

function CustomUIFonts.InitializeDefaultFonts()
    debugLog("Initializing default fonts...")
    
    local tahomaBold = CustomUIFonts.Register_Font("TahomaBold", 200, "Normal", {
        Id = "TahomaBold.ttf",
        Font = game:HttpGet("https://github.com/Nexus-Scripts/nexusscripts-roblox-ui-custom-font-loader/raw/main/fonts/tahoma_bold.ttf")
    })
    
    local proggyClean = CustomUIFonts.Register_Font("ProggyClean", 200, "Normal", {
        Id = "ProggyClean.ttf", 
        Font = game:HttpGet("https://github.com/Nexus-Scripts/nexusscripts-roblox-ui-custom-font-loader/raw/main/fonts/ProggyClean.ttf")
    })

    local leadcoat = CustomUIFonts.Register_Font("leadcoat", 200, "Normal", {
        Id = "leadcoat.ttf", 
        Font = game:HttpGet("https://github.com/Nexus-Scripts/nexusscripts-roblox-ui-custom-font-loader/raw/main/fonts/leadcoat.ttf")
    })
    
    debugLog("Creating Font objects...")
    fonts = {
        ["TahomaBold"] = Font.new(tahomaBold, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        ["ProggyClean"] = Font.new(proggyClean, Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        ["leadcoat"] = Font.new(leadcoat, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    }
    
    debugLog("Font initialization complete")
    return fonts
end

function CustomUIFonts.GetFont(fontName)
    return fonts[fontName]
end

function CustomUIFonts.ApplyFont(uiElement, fontName)
    if not fonts[fontName] then
        debugLog("Font not found: " .. fontName)
        return false
    end
    
    if typeof(uiElement) == "Instance" and (uiElement:IsA("TextLabel") or uiElement:IsA("TextButton") or uiElement:IsA("TextBox")) then
        uiElement.FontFace = fonts[fontName]
        debugLog("Applied font to UI element: " .. fontName)
        return true
    else
        debugLog("Invalid UI element for font application")
        return false
    end
end

function CustomUIFonts.GetAvailableFonts()
    local fontList = {}
    for fontName, _ in pairs(fonts) do
        table.insert(fontList, fontName)
    end
    return fontList
end

return CustomUIFonts 