local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Spawner
do
    local ok, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
    end)
    if ok then
        Spawner = result
    else
        warn("[Entity Studio] Failed to load Vynixu V2:", result)
    end
end

_G.Studio_SavedEntities = _G.Studio_SavedEntities or {}
_G.Studio_CurrentConfig = _G.Studio_CurrentConfig or {
    Name = "Custom Entity",
    Layout = "Vynixu",
    AssetId = "https://github.com/RegularVynixu/DOORS-Entity-Spawner-V2/raw/main/Assets/Entities/Rush.rbxm",
    HeightOffset = 0,
    Flicker = false,
    FlickerDuration = 5,
    Break = false,
    Repair = false,
    Earthquake = false,
    CamShake = false,
    ShakeRange = 100,
    ShakeFormat = "1.5, 20, 0.1, 1",
    Speed = 100,
    Delay = 0,
    Reversed = false,
    Rebounding = false,
    ReboundType = "Ambush",
    MinRebound = 1,
    MaxRebound = 5,
    ReboundDelay = 2,
    Damage = false,
    DamageRange = 15,
    DamageAmount = 100,
    Crucifixion = false,
    CruciType = "Guiding",
    CruciRange = 15,
    CruciResist = false,
    CruciBreak = false,
}

local CFG = _G.Studio_CurrentConfig

local function notify(title, description, time)
    Library:Notify({
        Title = title or "Entity Studio",
        Description = description or "",
        Time = time or 3,
    })
end

local function deepCopy(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            copy[k] = deepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

local function savedNames()
    local list = {}
    for name in pairs(_G.Studio_SavedEntities) do
        table.insert(list, name)
    end
    table.sort(list)
    return list
end

local function parseShakeFormat(str)
    local params = {}
    for num in string.gmatch(tostring(str or ""), "[%d%.%-]+") do
        table.insert(params, tonumber(num))
    end
    local fallback = { 1.5, 20, 0.1, 1 }
    for i = 1, 4 do
        if type(params[i]) ~= "number" then
            params[i] = fallback[i]
        end
    end
    return { params[1], params[2], params[3], params[4] }
end

local function applyConfigToUI(cfg)
    local function setOpt(idx, value)
        if Options[idx] and value ~= nil then
            Options[idx]:SetValue(value)
        end
    end
    local function setTgl(idx, value)
        if Toggles[idx] and value ~= nil then
            Toggles[idx]:SetValue(value)
        end
    end

    setOpt("Studio_EntityNameInput", cfg.Name)
    setOpt("Studio_LayoutDropdown", cfg.Layout)
    setOpt("Studio_AssetId", cfg.AssetId)
    setOpt("Studio_HeightOffset", cfg.HeightOffset)
    setOpt("Studio_Speed", cfg.Speed)
    setOpt("Studio_Delay", cfg.Delay)
    setTgl("Studio_TglReversed", cfg.Reversed)

    setTgl("Studio_TglFlicker", cfg.Flicker)
    setOpt("Studio_FlickerDuration", cfg.FlickerDuration)
    setTgl("Studio_TglBreak", cfg.Break)
    setTgl("Studio_TglRepair", cfg.Repair)
    setTgl("Studio_TglEarthquake", cfg.Earthquake)

    setTgl("Studio_TglCamShake", cfg.CamShake)
    setOpt("Studio_ShakeRange", cfg.ShakeRange)
    setOpt("Studio_ShakeFormat", cfg.ShakeFormat)

    setTgl("Studio_TglRebounding", cfg.Rebounding)
    setOpt("Studio_ReboundType", cfg.ReboundType)
    setOpt("Studio_MinRebound", cfg.MinRebound)
    setOpt("Studio_MaxRebound", cfg.MaxRebound)
    setOpt("Studio_ReboundDelay", cfg.ReboundDelay)

    setTgl("Studio_TglDamage", cfg.Damage)
    setOpt("Studio_DamageRange", cfg.DamageRange)
    setOpt("Studio_DamageAmount", cfg.DamageAmount)

    setTgl("Studio_TglCrucifixion", cfg.Crucifixion)
    setOpt("Studio_CruciType", cfg.CruciType)
    setOpt("Studio_CruciRange", cfg.CruciRange)
    setTgl("Studio_TglCruciResist", cfg.CruciResist)
    setTgl("Studio_TglCruciBreak", cfg.CruciBreak)
end

local function refreshSavedDropdown(selectName)
    local list = savedNames()
    if #list == 0 then
        list = { "(none)" }
    end
    local dropdown = Options.Studio_SavedEntitiesDropdown
    if dropdown then
        dropdown:SetValues(list)
        if selectName and _G.Studio_SavedEntities[selectName] then
            dropdown:SetValue(selectName)
        end
    end
end

local Window = Library:CreateWindow({
    Title = "DOORS Entity Studio",
    Footer = "Made By RegularVynixu, Addon By HaxGlag",
    NotifySide = "Right",
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Studio = Window:AddTab("Entity Studio", "ghost"),
    Settings = Window:AddTab("UI Settings", "settings"),
}

Tabs.Studio:UpdateWarningBox({
    Visible = true,
    Title = "Client-side only",
    Text = "Only YOU can see spawned entities. Other players will not see, hear, or take damage from them.",
})

local LeftBox = Tabs.Studio:AddLeftGroupbox("Configuration & Saves", "save")
local RightBox = Tabs.Studio:AddRightGroupbox("Modifiers & Actions", "sliders-horizontal")

LeftBox:AddLabel("Made by Vynixyu\nDOORS Entity Studio (mspaint addon by HaxGlag)\nPorted by RwalDev", true)

LeftBox:AddInput("Studio_EntityNameInput", {
    Text = "Entity Name",
    Default = CFG.Name,
    Placeholder = "Input entity name",
    Callback = function(v)
        CFG.Name = v
    end,
})

LeftBox:AddButton({
    Text = "Save Entity Profile",
    Tooltip = "Stores the current configuration in the local profile list",
    Func = function()
        local name = CFG.Name
        if name == nil or name == "" or name == " " then
            name = "Unnamed Entity"
            CFG.Name = name
        end

        _G.Studio_SavedEntities[name] = deepCopy(CFG)
        _G.Studio_SavedEntities[name].Name = name
        refreshSavedDropdown(name)
        notify("Profile Saved", "Saved configuration: " .. name)
    end,
})

LeftBox:AddDropdown("Studio_SavedEntitiesDropdown", {
    Values = (#savedNames() > 0) and savedNames() or { "(none)" },
    Default = 1,
    Searchable = true,
    Text = "Load Saved Entities",
})

LeftBox:AddButton({
    Text = "Load Selected Profile",
    Func = function()
        local selected = Options.Studio_SavedEntitiesDropdown.Value
        local profile = selected and _G.Studio_SavedEntities[selected]
        if not profile then
            notify("Load Failed", "No profile selected.", 3)
            return
        end
        for k, v in pairs(profile) do
            CFG[k] = v
        end
        applyConfigToUI(profile)
        notify("Profile Loaded", "Loaded: " .. tostring(selected))
    end,
}):AddButton({
    Text = "Delete Profile",
    Tooltip = "Removes the selected profile from the local registry",
    Func = function()
        local selected = Options.Studio_SavedEntitiesDropdown.Value
        if selected and _G.Studio_SavedEntities[selected] then
            _G.Studio_SavedEntities[selected] = nil
            refreshSavedDropdown()
            notify("Profile Deleted", "Removed: " .. tostring(selected))
        else
            notify("Delete Failed", "No profile selected.", 3)
        end
    end,
})

LeftBox:AddDivider("Base Configuration")

LeftBox:AddDropdown("Studio_LayoutDropdown", {
    Values = { "Vynixu", "ADM Panel" },
    Default = CFG.Layout or "Vynixu",
    Text = "Select Studio Layout",
    Callback = function(v)
        CFG.Layout = v
    end,
})

LeftBox:AddInput("Studio_AssetId", {
    Text = "Model rbxassetid / URL",
    Default = CFG.AssetId,
    Placeholder = "Input Model Asset ID or URL...",
    Callback = function(v)
        CFG.AssetId = v
    end,
})

LeftBox:AddSlider("Studio_HeightOffset", {
    Text = "Model Height Offset",
    Default = CFG.HeightOffset,
    Min = -5,
    Max = 5,
    Rounding = 1,
    Callback = function(v)
        CFG.HeightOffset = v
    end,
})

LeftBox:AddSlider("Studio_Speed", {
    Text = "Speed",
    Default = CFG.Speed,
    Min = 1,
    Max = 2000,
    Rounding = 0,
    Callback = function(v)
        CFG.Speed = v
    end,
})

LeftBox:AddSlider("Studio_Delay", {
    Text = "Spawn Delay",
    Default = CFG.Delay,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "s",
    Callback = function(v)
        CFG.Delay = v
    end,
})

LeftBox:AddToggle("Studio_TglReversed", {
    Text = "Reversed Direction",
    Default = CFG.Reversed,
    Callback = function(v)
        CFG.Reversed = v
    end,
})

RightBox:AddDivider("Lights & Camera")

local Toggle_Flicker = RightBox:AddToggle("Studio_TglFlicker", {
    Text = "Flicker Lights",
    Default = CFG.Flicker,
    Callback = function(v)
        CFG.Flicker = v
    end,
})

local Dep_Flicker = RightBox:AddDependencyBox()
Dep_Flicker:AddSlider("Studio_FlickerDuration", {
    Text = "Flicker Duration",
    Default = CFG.FlickerDuration,
    Min = 1,
    Max = 60,
    Rounding = 0,
    Suffix = "s",
    Callback = function(v)
        CFG.FlickerDuration = v
    end,
})
Dep_Flicker:SetupDependencies({ { Toggle_Flicker, true } })

RightBox:AddToggle("Studio_TglBreak", {
    Text = "Break Lights",
    Default = CFG.Break,
    Callback = function(v)
        CFG.Break = v
    end,
})

RightBox:AddToggle("Studio_TglRepair", {
    Text = "Repair Lights",
    Default = CFG.Repair,
    Callback = function(v)
        CFG.Repair = v
    end,
})

RightBox:AddToggle("Studio_TglEarthquake", {
    Text = "Earthquake",
    Default = CFG.Earthquake,
    Callback = function(v)
        CFG.Earthquake = v
    end,
})

local Toggle_CamShake = RightBox:AddToggle("Studio_TglCamShake", {
    Text = "Camera Shake",
    Default = CFG.CamShake,
    Callback = function(v)
        CFG.CamShake = v
    end,
})

local Dep_CamShake = RightBox:AddDependencyBox()
Dep_CamShake:AddSlider("Studio_ShakeRange", {
    Text = "Shake Range",
    Default = CFG.ShakeRange,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        CFG.ShakeRange = v
    end,
})
Dep_CamShake:AddInput("Studio_ShakeFormat", {
    Text = "Magnitude, Roughness, FadeIn, FadeOut",
    Default = CFG.ShakeFormat,
    Placeholder = "#, #, #, #",
    Callback = function(v)
        CFG.ShakeFormat = v
    end,
})
Dep_CamShake:SetupDependencies({ { Toggle_CamShake, true } })

RightBox:AddDivider("Rebound & Damage")

local Toggle_Rebounding = RightBox:AddToggle("Studio_TglRebounding", {
    Text = "Enable Rebounding",
    Default = CFG.Rebounding,
    Callback = function(v)
        CFG.Rebounding = v
    end,
})

local Dep_Rebound = RightBox:AddDependencyBox()
Dep_Rebound:AddDropdown("Studio_ReboundType", {
    Values = { "Ambush", "Blitz" },
    Default = CFG.ReboundType or "Ambush",
    Text = "Rebound Type",
    Callback = function(v)
        CFG.ReboundType = v
    end,
})
Dep_Rebound:AddSlider("Studio_MinRebound", {
    Text = "Min Rebound",
    Default = CFG.MinRebound,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        CFG.MinRebound = v
    end,
})
Dep_Rebound:AddSlider("Studio_MaxRebound", {
    Text = "Max Rebound",
    Default = CFG.MaxRebound,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        CFG.MaxRebound = v
    end,
})
Dep_Rebound:AddSlider("Studio_ReboundDelay", {
    Text = "Rebound Delay",
    Default = CFG.ReboundDelay or 2,
    Min = 0,
    Max = 30,
    Rounding = 1,
    Suffix = "s",
    Callback = function(v)
        CFG.ReboundDelay = v
    end,
})
Dep_Rebound:SetupDependencies({ { Toggle_Rebounding, true } })

local Toggle_Damage = RightBox:AddToggle("Studio_TglDamage", {
    Text = "Enable Damage",
    Default = CFG.Damage,
    Callback = function(v)
        CFG.Damage = v
    end,
})

local Dep_Damage = RightBox:AddDependencyBox()
Dep_Damage:AddSlider("Studio_DamageRange", {
    Text = "Damage Range",
    Default = CFG.DamageRange,
    Min = 1,
    Max = 400,
    Rounding = 0,
    Callback = function(v)
        CFG.DamageRange = v
    end,
})
Dep_Damage:AddSlider("Studio_DamageAmount", {
    Text = "Damage Amount",
    Default = CFG.DamageAmount,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        CFG.DamageAmount = v
    end,
})
Dep_Damage:SetupDependencies({ { Toggle_Damage, true } })

RightBox:AddDivider("Crucifixion")

local Toggle_Crucifixion = RightBox:AddToggle("Studio_TglCrucifixion", {
    Text = "Enable Crucifixion",
    Default = CFG.Crucifixion,
    Callback = function(v)
        CFG.Crucifixion = v
    end,
})

local Dep_Cruci = RightBox:AddDependencyBox()
Dep_Cruci:AddDropdown("Studio_CruciType", {
    Values = { "Guiding", "Curious" },
    Default = CFG.CruciType or "Guiding",
    Text = "Crucifix Type",
    Callback = function(v)
        CFG.CruciType = v
    end,
})
Dep_Cruci:AddSlider("Studio_CruciRange", {
    Text = "Crucifix Range",
    Default = CFG.CruciRange,
    Min = 1,
    Max = 400,
    Rounding = 0,
    Callback = function(v)
        CFG.CruciRange = v
    end,
})
Dep_Cruci:AddToggle("Studio_TglCruciResist", {
    Text = "Resist Crucifix",
    Default = CFG.CruciResist,
    Callback = function(v)
        CFG.CruciResist = v
    end,
})
Dep_Cruci:AddToggle("Studio_TglCruciBreak", {
    Text = "Break Crucifix",
    Default = CFG.CruciBreak,
    Callback = function(v)
        CFG.CruciBreak = v
    end,
})
Dep_Cruci:SetupDependencies({ { Toggle_Crucifixion, true } })

RightBox:AddDivider("Actions")

RightBox:AddButton({
    Text = "SPAWN CUSTOM ENTITY",
    Tooltip = "Creates and runs a Vynixu V2 entity with the current configuration",
    Func = function()
        if not Spawner or type(Spawner.Create) ~= "function" then
            notify("Spawn Failed", "Vynixu Entity Spawner V2 is not loaded. Join DOORS and re-execute.", 5)
            return
        end

        local cfg = CFG
        local minRebound = tonumber(cfg.MinRebound) or 0
        local maxRebound = tonumber(cfg.MaxRebound) or minRebound
        if maxRebound < minRebound then
            maxRebound = minRebound
        end

        local ok, entityOrErr = pcall(function()
            return Spawner:Create({
                Entity = {
                    Name = (cfg.Name ~= nil and cfg.Name ~= "" and cfg.Name) or "Custom Entity",
                    Asset = cfg.AssetId,
                    HeightOffset = cfg.HeightOffset,
                },
                Movement = {
                    Speed = cfg.Speed,
                    Delay = cfg.Delay,
                    Reversed = cfg.Reversed,
                },
                Damage = {
                    Enabled = cfg.Damage,
                    IgnoreHiding = false,
                    Range = cfg.DamageRange,
                    Amount = cfg.DamageAmount,
                },
                Rebounding = {
                    Enabled = cfg.Rebounding,
                    Type = cfg.ReboundType or "Ambush",
                    Min = minRebound,
                    Max = maxRebound,
                    Delay = cfg.ReboundDelay or 2,
                },
                Lights = {
                    Flicker = {
                        Enabled = cfg.Flicker,
                        Duration = cfg.FlickerDuration,
                    },
                    Shatter = cfg.Break,
                    Repair = cfg.Repair,
                },
                Earthquake = {
                    Enabled = cfg.Earthquake,
                },
                CameraShake = {
                    Enabled = cfg.CamShake,
                    Range = cfg.ShakeRange,
                    Values = parseShakeFormat(cfg.ShakeFormat),
                },
                Crucifixion = {
                    Type = cfg.CruciType or "Guiding",
                    Enabled = cfg.Crucifixion,
                    Range = cfg.CruciRange,
                    Resist = cfg.CruciResist,
                    Break = cfg.CruciBreak,
                },
                Death = {
                    Type = "Guiding",
                    Hints = {
                        "You died to a custom entity.",
                        "It was spawned by Entity Studio.",
                        "Hide next time.",
                        "Good luck.",
                    },
                    Cause = (cfg.Name ~= nil and cfg.Name ~= "" and cfg.Name) or "Custom Entity",
                },
            })
        end)

        if not ok or not entityOrErr then
            notify("Spawn Failed", tostring(entityOrErr), 6)
            return
        end

        local runOk, runErr = pcall(function()
            entityOrErr:Run(true)
        end)

        if not runOk then
            notify("Run Failed", tostring(runErr), 6)
            return
        end

        notify("Entity Spawned", (cfg.Name ~= "" and cfg.Name or "Custom Entity") .. " is now running.")
    end,
})

local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = Library.ShowCustomCursor,
    Callback = function(value)
        Library.ShowCustomCursor = value
    end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",
    Text = "Notification Side",
    Callback = function(value)
        Library:SetNotifySide(value)
    end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind",
})

MenuGroup:AddButton({
    Text = "Unload",
    Func = function()
        Library:Unload()
    end,
})

local CreditsGroup = Tabs.Settings:AddRightGroupbox("Credits", "info")
CreditsGroup:AddLabel("Made by HaxGlag", true)
CreditsGroup:AddLabel("DOORS Entity Studio (mspaint addon from https://www.mspaint.cc/subscription-dashboard/addons/U11BOTJ9jh)", true)
CreditsGroup:AddLabel("Ported by RwalDev", true)

Library.ToggleKeybind = Options.MenuKeybind

Library:OnUnload(function()
    print("[Entity Studio] Unloaded.")
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("EntityStudio")
SaveManager:SetFolder("EntityStudio/DOORS")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

notify("Entity Studio", "ported by rwaldev XD", 4)
