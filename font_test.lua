local function LoadFontLibrary()
    print("[FontTest] Attempting to load font library...")
    local success, content = pcall(function()
        return readfile("font_library.lua")
    end)
    
    if not success then
        error("Failed to load font library: " .. tostring(content))
        return
    end
    
    print("[FontTest] Font library file loaded successfully")
    
    local success2, FontLibrary = pcall(function()
        return loadstring(content)()
    end)
    
    if not success2 then
        error("Failed to execute font library: " .. tostring(FontLibrary))
        return
    end
    
    print("[FontTest] Font library initialized successfully")
    return FontLibrary
end

local function TestFonts()
    local FontLibrary = LoadFontLibrary()
    if not FontLibrary then
        print("[FontTest] Failed to load FontLibrary")
        return
    end
    
    print("[FontTest] Initializing default fonts...")
    local fonts = FontLibrary.InitializeDefaultFonts()
    
    print("[FontTest] Available fonts:")
    for _, fontName in ipairs(FontLibrary.GetAvailableFonts()) do
        print("  -", fontName)
    end
    
    print("[FontTest] Creating test labels...")
    local tahomaBoldFrame = FontLibrary.CreateTestLabel("TahomaBold", -150)  -- Above center
    local proggyCleanFrame = FontLibrary.CreateTestLabel("ProggyClean", 150)  -- Below center
    
    --wait(5)
    --tahomaBoldFrame:Destroy()
    --:Destroy()
    
    print("[FontTest] Test complete!")
end

print("[FontTest] Starting font test...")
local success, err = pcall(TestFonts)
if not success then
    print("[FontTest] Test failed:", err)
end 