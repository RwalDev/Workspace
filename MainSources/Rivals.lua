-- old file of mine, i open sourced it because i don't work on it now
-- // Libraries
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- // Window
local Window = Fluent:CreateWindow({
    Title = "RwalDev | Rivals",
    SubTitle = "Made By Rwal / github.com/RwalDev",
    TabWidth = 180,
    Size = UDim2.fromOffset(640, 420),
    Acrylic = true,
    Theme = "Rose",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Aimbot   = Window:AddTab({ Title = "Aimbot",   Icon = "crosshair" }),
    SilentAim= Window:AddTab({ Title = "Silent Aim", Icon = "target" }),
    Visuals  = Window:AddTab({ Title = "Visuals",  Icon = "eye" }),
    Misc     = Window:AddTab({ Title = "Misc",     Icon = "archive" })
}

-- // Save / Interface
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The settings tab has been loaded.",
    Duration = 8
})

-- // Services / Globals
local Players          = game:GetService("Players")
local Workspace        = game:GetService("Workspace")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer    = Players.LocalPlayer
local CurrentCamera  = Workspace.CurrentCamera

-- // Aimbot Settings
local AimbotEnabled     = false
local AimPartName       = "Head"
local TeamCheck         = false
local WallCheck         = false
local TargetNPCs        = false
local TargetMode        = "Closest" -- "Closest" / "None"

-- // Get Closest Target
local function GetBestTarget()
    if TargetMode == "None" then
        return nil
    end

    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end

    local bestTarget
    local closestDist = math.huge

    local function considerModel(model)
        if not (model and model:IsA("Model")) then return end
        if not (model:FindFirstChild("Humanoid") and model:FindFirstChild(AimPartName)) then return end

        local part = model[AimPartName]
        local dist = (part.Position - localRoot.Position).Magnitude
        if dist >= closestDist then return end

        if WallCheck then
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = { LocalPlayer.Character }
            params.FilterType = Enum.RaycastFilterType.Blacklist

            local result = Workspace:Raycast(
                CurrentCamera.CFrame.Position,
                (part.Position - CurrentCamera.CFrame.Position).Unit * 1000,
                params
            )

            if result and result.Instance:IsDescendantOf(model) then
                closestDist = dist
                bestTarget = model
            end
        else
            closestDist = dist
            bestTarget = model
        end
    end

    -- Players
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and (not TeamCheck or plr.Team ~= LocalPlayer.Team) then
            considerModel(plr.Character)
        end
    end

    -- NPCs
    if TargetNPCs then
        for _, desc in ipairs(Workspace:GetDescendants()) do
            considerModel(desc)
        end
    end

    return bestTarget
end

-- // Camera Aim
local function AimCameraAt(position)
    if position then
        CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, position)
    end
end

-- // Aimbot Loop
function aimAtTarget()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not AimbotEnabled then
            connection:Disconnect()
            return
        end

        local targetModel = GetBestTarget()
        if not targetModel then return end

        local part = targetModel:FindFirstChild(AimPartName)
        local humanoid = targetModel:FindFirstChild("Humanoid")
        if not (part and humanoid and humanoid.Health > 0) then return end

        while AimbotEnabled and targetModel and targetModel:FindFirstChild(AimPartName) and humanoid.Health > 0 do
            AimCameraAt(part.Position)

            if WallCheck then
                local params = RaycastParams.new()
                params.FilterDescendantsInstances = { LocalPlayer.Character }
                params.FilterType = Enum.RaycastFilterType.Blacklist

                local result = Workspace:Raycast(
                    CurrentCamera.CFrame.Position,
                    (part.Position - CurrentCamera.CFrame.Position).Unit * 1000,
                    params
                )

                if not result or not result.Instance:IsDescendantOf(targetModel) then
                    break
                end
            end

            RunService.RenderStepped:Wait()
        end
    end)
end

-- // Aimbot UI
local AimbotToggle = Tabs.Aimbot:AddToggle("aimbot_toggle", {
    Title = "Enable Aimbot",
    Default = false
})

AimbotToggle:OnChanged(function(value)
    AimbotEnabled = value
    if AimbotEnabled then
        aimAtTarget()
    end
end)

Tabs.Aimbot:AddParagraph({
    Title = "Toggle Key",
    Content = "Press Q to toggle Aimbot"
})

Tabs.Aimbot:AddDropdown("aim_part", {
    Title = "Aim Part",
    Values = { "Head", "HumanoidRootPart" },
    Default = "Head"
}):OnChanged(function(value)
    AimPartName = value
end)

Tabs.Aimbot:AddToggle("team_check", {
    Title = "Team Check",
    Default = false
}):OnChanged(function(value)
    TeamCheck = value
end)

Tabs.Aimbot:AddToggle("wall_check", {
    Title = "Wall Check",
    Default = false
}):OnChanged(function(value)
    WallCheck = value
end)

Tabs.Aimbot:AddToggle("target_npcs", {
    Title = "Target NPCs",
    Default = false
}):OnChanged(function(value)
    TargetNPCs = value
end)

Tabs.Aimbot:AddDropdown("aim_target", {
    Title = "Target Mode",
    Values = { "Closest", "None" },
    Default = "Closest"
}):OnChanged(function(value)
    TargetMode = value
end)

-- // Silent Aim
local SilentAimEnabled = false

local function GetClosestHeadToCamera()
    local bestHead
    local closest = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - CurrentCamera.CFrame.Position).Magnitude
            if dist < closest then
                closest = dist
                bestHead = plr.Character.Head
            end
        end
    end

    return bestHead
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end

    -- Aimbot key
    if input.KeyCode == Enum.KeyCode.Q then
        AimbotEnabled = not AimbotEnabled
        AimbotToggle:SetValue(AimbotEnabled)
        if AimbotEnabled then
            aimAtTarget()
        end
    end

    -- Silent Aim fire
    if input.UserInputType == Enum.UserInputType.MouseButton1 and SilentAimEnabled then
        local head = GetClosestHeadToCamera()
        if head then
            CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, head.Position)
            local attackRemote = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Attack")
            if attackRemote then
                attackRemote:FireServer(head)
            end
        end
    end
end)

Tabs.SilentAim:AddParagraph({
    Title = "Silent Aim Instructions",
    Content = "\n1. Use the toggle below to enable Silent Aim.\n2. When enabled, aim at a target and hold the left mouse button to silent aim.\n3. The FOV circle indicates the area where targets can be hit.\n"
})

Tabs.SilentAim:AddToggle("SilentAimToggle", {
    Title = "Toggle Silent Aim",
    Default = false
}):OnChanged(function(value)
    SilentAimEnabled = value
    if value then
        print("Silent Aim is now active.")
    else
        print("Silent Aim has been disabled.")
    end
end)

-- // Silent Aim FOV Circle
local FOVCircle
local FOVRadius = 160

do
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Radius = FOVRadius
    FOVCircle.Position = Vector2.new(Workspace.CurrentCamera.ViewportSize.X / 2, Workspace.CurrentCamera.ViewportSize.Y / 2)
    FOVCircle.Thickness = 1
    FOVCircle.Color = Color3.fromRGB(76, 119, 228)
    FOVCircle.Transparency = 1
    FOVCircle.Visible = false

    RunService.RenderStepped:Connect(function()
        if FOVCircle then
            FOVCircle.Position = Vector2.new(Workspace.CurrentCamera.ViewportSize.X / 2, Workspace.CurrentCamera.ViewportSize.Y / 2)
        end
    end)
end

-- // ESP
local ESPColors = {
    Green  = Color3.fromRGB(0, 255, 0),
    Blue   = Color3.fromRGB(0, 0, 255),
    Red    = Color3.fromRGB(255, 0, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Orange = Color3.fromRGB(255, 165, 0),
    Purple = Color3.fromRGB(128, 0, 128)
}

local ESPColor = ESPColors.Red
local ESPEnabled = true

local function GetCharacterFromPlayer(player)
    return Workspace:FindFirstChild(player.Name)
end

local function UpdateHighlightColor(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local highlight = hrp:FindFirstChild("Highlight")
    if highlight then
        highlight.FillColor = ESPColor
    end
end

local function ApplyHighlight(player, character)
    if player == LocalPlayer then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp or hrp:FindFirstChild("Highlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.Adornee = character
    highlight.Parent = hrp
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = ESPColor
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
end

local function RemoveHighlight(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local highlight = hrp:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

local function ESPUpdate()
    for _, plr in pairs(Players:GetPlayers()) do
        local char = GetCharacterFromPlayer(plr)
        if char then
            if ESPEnabled then
                ApplyHighlight(plr, char)
                UpdateHighlightColor(char)
            else
                RemoveHighlight(char)
            end
        end
    end
end

RunService.RenderStepped:Connect(ESPUpdate)

Tabs.Visuals:AddToggle("ESPToggle", {
    Title = "Enable ESP",
    Default = true
}):OnChanged(function(value)
    ESPEnabled = value
end)

Tabs.Visuals:AddDropdown("ESPColour", {
    Title = "ESP Colour",
    Values = { "Green", "Blue", "Red", "Yellow", "Orange", "Purple" },
    Multi = false,
    Default = "Red"
}):OnChanged(function(value)
    ESPColor = ESPColors[value]
    ESPUpdate()
end)

-- // Misc
Tabs.Misc:AddToggle("BackTPToggle", {
    Title = "Enable Back Teleporting (Q)",
    Default = true
}):OnChanged(function() end)

Fluent:Notify({
    Title = "Atlas Client Loaded...!",
    Content = "Welcome to Atlas Rivals V3",
    Duration = 10
})

-- // FPS Booster
Tabs.Misc:AddButton({
    Title = "Fps Booster",
    Description = "Recommended On Low End Devices Only.",
    Callback = function()
        Window:Dialog({
            Title = "FPS BOOSTER",
            Content = "This will Boost your fps by 100 FRAMES and make your game smoother (recommended on low end devices)",
            Buttons = {
                {
                    Title = "Continue",
                    Callback = function()
                        local function ApplyFPSBoost()
                            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

                            -- World simplification
                            local function simplify(obj)
                                if obj:IsA("Texture") or obj:IsA("Decal") then
                                    obj:Destroy()
                                elseif obj:IsA("BasePart") then
                                    obj.Material = Enum.Material.Plastic
                                    obj.CastShadow = false
                                    obj.Reflectance = 0
                                    obj.Color = Color3.fromRGB(50, 50, 50)
                                elseif obj:IsA("Model") and obj.Name:lower():find("tree") then
                                    obj:Destroy()
                                end
                                for _, child in ipairs(obj:GetChildren()) do
                                    simplify(child)
                                end
                            end

                            for _, desc in ipairs(Workspace:GetDescendants()) do
                                simplify(desc)
                            end

                            -- Player simplification
                            local function simplifyCharacter(player)
                                if player.Character and player.Character:FindFirstChild("Humanoid") then
                                    for _, child in ipairs(player.Character:GetChildren()) do
                                        if child:IsA("Accessory") or child:IsA("Clothing") then
                                            child:Destroy()
                                        elseif child:IsA("BasePart") then
                                            child.Color = Color3.fromRGB(255, 255, 255)
                                            child.Material = Enum.Material.SmoothPlastic
                                        end
                                    end
                                end
                            end

                            for _, plr in ipairs(Players:GetPlayers()) do
                                simplifyCharacter(plr)
                                plr.CharacterAdded:Connect(function()
                                    simplifyCharacter(plr)
                                end)
                            end

                            Players.PlayerAdded:Connect(function(plr)
                                plr.CharacterAdded:Connect(function()
                                    simplifyCharacter(plr)
                                end)
                            end)

                            -- Lighting
                            local Lighting = game:GetService("Lighting")
                            Lighting.Bloom.Enabled = false
                            Lighting.SunRays.Enabled = false
                            Lighting.ColorCorrection.Enabled = false
                            Lighting.Blur.Enabled = false
                            Lighting.Ambient = Color3.fromRGB(10, 10, 10)
                            Lighting.Brightness = 1
                            Lighting.OutdoorAmbient = Color3.fromRGB(10, 10, 10)
                            Lighting.FogEnd = 50
                            Lighting.FogStart = 0
                            Lighting.FogColor = Color3.fromRGB(10, 10, 10)
                            Lighting.ClockTime = 0
                            Lighting.GlobalShadows = false

                            -- Streaming
                            Workspace.StreamingEnabled = true
                            Workspace.StreamingMinRadius = 32
                            Workspace.StreamingTargetRadius = 64

                            -- Rendering settings
                            settings().Rendering.AutoFRMLevel = Enum.AutomaticSizing.FramerateBoost
                            settings().Rendering.EnableFRM = true
                            settings().Rendering.EagerBulkAsyncContentLoad = true
                            game:GetService("RunService"):Set3dRenderingEnabled(false)
                            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level00
                            settings().Rendering.EnableDamageOverlay = false
                            settings().Rendering.EnableShadows = false
                            settings().Rendering.AnisotropicFiltering = false
                            settings().Rendering.RenderFidelity = Enum.RenderFidelity.Performance
                            settings().Rendering.FrameBufferEnabled = false

                            -- Simplify world geometry & decals
                            for _, part in ipairs(Workspace:GetDescendants()) do
                                if part:IsA("BasePart") and part.Shape ~= Enum.PartType.Block then
                                    part.Shape = Enum.PartType.Block
                                end
                            end

                            for _, d in ipairs(Workspace:GetDescendants()) do
                                if d:IsA("Decal") then
                                    d:Destroy()
                                end
                            end

                            -- GUI simplification
                            for _, guiObj in ipairs(game:GetService("StarterGui"):GetDescendants()) do
                                if guiObj:IsA("GuiObject") then
                                    guiObj.BackgroundTransparency = 0.4
                                    if guiObj:IsA("UICorner") then
                                        guiObj:Destroy()
                                    end
                                end
                            end

                            -- Humanoid states
                            for _, plr in ipairs(Players:GetPlayers()) do
                                if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                                    local hum = plr.Character.Humanoid
                                    for _, state in ipairs(Enum.HumanoidStateType:GetEnumItems()) do
                                        hum:SetStateEnabled(state, false)
                                    end
                                end
                            end

                            -- Flags (note: some may not work or may error on some executors)
                            local flags = {
                                FFlagDebugDisableTelemetryPoint = "True",
                                FFlagDebugDisableTelemetryV2Counter = "True",
                                FFlagDebugDisableTelemetryV2Event = "True",
                                FFlagDebugDisableTelemetryV2Stat = "True",
                                FFlagDebugSkyGray = "true",
                                FFlagDebugDisplayFPS = "True",
                                FIntFRMMinGrassDistance = 0,
                                FIntFRMMaxGrassDistance = 0,
                                FIntRenderGrassDetailStrands = 0,
                                FintRenderGrassHeightScaler = 0,
                                DFIntMaxFrameBufferSize = "4",
                                DebugGraphicsDisableVulkan = "True",
                                DebugGraphicsDisableVulkan11 = "True",
                                DebugGraphicsDisableOpenGL = "True",
                                DebugGraphicPreferD3D11 = "True",
                                FIntRobloxGuiBlurIntensity = "0",
                                FIntFullscreenTitleBarTriggerDelayMillis = "3600000",
                                FFlagFastGPULightCulling3 = "True",
                                FFlagNewLightAttenuation = "True",
                                FFlagDisablePostFx = "True",
                                DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent = "0",
                                DFIntClientLightingEnvmapPlacementTelemetryHundredthsPercent = "100",
                                FIntMockClientLightingTechnologyIxpExperimentMode = "0",
                                FIntMockClientLightingTechnologyIxpExperimentQualityLevel = "7"
                            }

                            for k, v in pairs(flags) do
                                pcall(function()
                                    settings()[k] = v
                                end)
                            end
                        end

                        ApplyFPSBoost()

                        Players.PlayerAdded:Connect(function(plr)
                            plr.CharacterAdded:Connect(function()
                                ApplyFPSBoost()
                            end)
                        end)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function() end
                }
            }
        })
    end
})

-- // Save system finalization
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("AimbotScript")
SaveManager:SetFolder("AimbotScript/Settings")
SaveManager:LoadAutoloadConfig()

-- // External load
loadstring(game:HttpGet("https://raw.githubusercontent.com/VisioneducationOfLuaCoding/Adverts/refs/heads/main/Ambrion%20Hub", true))()
