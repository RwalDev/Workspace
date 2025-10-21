--// teleporting bugs :( it's finally fixed now
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Fling To Climb",
            Text = text,
            Duration = 5
        })
    end)
end

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Fling To Climb",
    LoadingTitle = "Loading FTC Workspace...",
    LoadingSubtitle = "By Rwal / Open Source",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local plr = Players.LocalPlayer
local char, hum, hrp

local function refreshCharacterRefs(c)
    char = c or plr.Character
    if not char then return end
    hum = char:FindFirstChildOfClass("Humanoid")
    hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart")
end

if plr.Character then refreshCharacterRefs(plr.Character) end
plr.CharacterAdded:Connect(function(c) 
    task.wait(0.5)
    refreshCharacterRefs(c) 
end)

local function getPositionOf(instance)
    if not instance then return nil end
    if instance:IsA("BasePart") then return instance.Position end
    if instance:IsA("Model") then
        local bp = instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart")
        if bp then return bp.Position end
    end
    local descendant = instance:FindFirstChildWhichIsA("BasePart", true)
    if descendant then return descendant.Position end
    return nil
end

local function findNamedInFolder(folder, name)
    if not folder then return nil end
    local target = folder:FindFirstChild(name)
    if target then return target end
    for _,v in ipairs(folder:GetDescendants()) do
        if v.Name == name then return v end
    end
    return nil
end

local function getWorld()
    return workspace:FindFirstChild("World")
end

local function buildNames(folder)
    local t = {}
    if not folder then
        return {"Not Found"}
    end
    for _,v in ipairs(folder:GetChildren()) do
        if v.Name and v.Name ~= "" then
            table.insert(t, v.Name)
        end
    end
    if #t == 0 then 
        return {"Empty"} 
    end
    return t
end

-- Main Tab
local Main = Window:CreateTab("Main Features", "map")
local checkpointSelection = ""

Main:CreateDropdown({
    Name = "Select Checkpoint",
    Options = buildNames(getWorld() and getWorld():FindFirstChild("Checkpoints")),
    CurrentOption = {"Select The CheckPoint"},
    Flag = "CheckpointDropdown",
    Callback = function(option)
        checkpointSelection = option[1] or option
        notify("Selected: " .. tostring(checkpointSelection))
    end
})

Main:CreateButton({
    Name = "Teleport To Selected Checkpoint",
    Callback = function()
        local World = getWorld()
        if not World then
            return notify("World not found!")
        end
        
        local checkpointsFolder = World:FindFirstChild("Checkpoints")
        if not checkpointsFolder then
            return notify("Checkpoints folder not found!")
        end
        
        if not checkpointSelection or checkpointSelection == "" or 
           checkpointSelection == "Not Found" or 
           checkpointSelection == "Empty" or
           checkpointSelection == "Select One" then
            return notify("Please select a checkpoint first!")
        end
        
        if not char or not hrp then
            refreshCharacterRefs()
            if not char or not hrp then
                return notify("Character not loaded!")
            end
        end
        
        local target = findNamedInFolder(checkpointsFolder, checkpointSelection)
        if not target then
            return notify("Checkpoint '" .. tostring(checkpointSelection) .. "' not found!")
        end
        
        local pos = getPositionOf(target)
        if pos then
            local success, err = pcall(function() 
                char:PivotTo(CFrame.new(pos + Vector3.new(0, 5, 0))) 
            end)
            
            if success then
                notify("Teleported to " .. tostring(checkpointSelection))
            else
                -- Fallback method
                if hrp then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
                    notify("Teleported to " .. tostring(checkpointSelection))
                end
            end
        else
            notify("Could not get position of checkpoint!")
        end
    end
})

Main:CreateButton({
    Name = "Bring All Coins To You",
    Callback = function()
        local World = getWorld()
        if not World then
            return notify("World not found!")
        end
        
        local coinsFolder = World:FindFirstChild("Coins")
        if not coinsFolder then
            return notify("Coins folder not found!")
        end
        
        if not char or not hrp then
            refreshCharacterRefs()
            if not hrp then
                return notify("Character not loaded!")
            end
        end
        
        local moved = 0
        for _,coin in ipairs(coinsFolder:GetDescendants()) do
            if coin:IsA("BasePart") then
                local ok = pcall(function()
                    coin.CFrame = CFrame.new(hrp.Position + Vector3.new(math.random(-3,3), 2, math.random(-3,3)))
                end)
                if ok then moved = moved + 1 end
            elseif coin:IsA("Model") then
                local ok = pcall(function()
                    if coin.PrimaryPart then
                        coin:SetPrimaryPartCFrame(CFrame.new(hrp.Position + Vector3.new(math.random(-3,3), 2, math.random(-3,3))))
                    else
                        for _,p in ipairs(coin:GetDescendants()) do
                            if p:IsA("BasePart") then
                                p.CFrame = CFrame.new(hrp.Position + Vector3.new(math.random(-3,3), 2, math.random(-3,3)))
                            end
                        end
                    end
                end)
                if ok then moved = moved + 1 end
            end
        end
        
        if moved > 0 then
            notify("Brought " .. tostring(moved) .. " coins to you!")
        else
            notify("No coins found or couldn't move them!")
        end
    end
})

-- Easter Egg Tab
local EggTab = Window:CreateTab("EasterEgg Section", "sparkles")
local maxwellSelection = ""

EggTab:CreateDropdown({
    Name = "Select Maxwell Egg",
    Options = buildNames(getWorld() and getWorld():FindFirstChild("EasterEggs") and getWorld().EasterEggs:FindFirstChild("Maxwell")),
    CurrentOption = {"Select One"},
    Flag = "MaxwellDropdown",
    Callback = function(option)
        maxwellSelection = option[1] or option
        notify("Selected: " .. tostring(maxwellSelection))
    end
})

EggTab:CreateButton({
    Name = "Teleport To Selected Maxwell Egg",
    Callback = function()
        local World = getWorld()
        if not World then
            return notify("World not found!")
        end
        
        local easterEggs = World:FindFirstChild("EasterEggs")
        if not easterEggs then
            return notify("EasterEggs folder not found!")
        end
        
        local maxwell = easterEggs:FindFirstChild("Maxwell")
        if not maxwell then
            return notify("Maxwell folder not found!")
        end
        
        if not maxwellSelection or maxwellSelection == "" or 
           maxwellSelection == "Not Found" or 
           maxwellSelection == "Empty" or
           maxwellSelection == "Select One" then
            return notify("Please select a Maxwell egg first!")
        end
        
        if not char or not hrp then
            refreshCharacterRefs()
            if not char or not hrp then
                return notify("Character not loaded!")
            end
        end
        
        local target = findNamedInFolder(maxwell, maxwellSelection)
        if not target then
            return notify("Maxwell egg '" .. tostring(maxwellSelection) .. "' not found!")
        end
        
        local pos = getPositionOf(target)
        if pos then
            local success, err = pcall(function() 
                char:PivotTo(CFrame.new(pos + Vector3.new(0, 3, 0))) 
            end)
            
            if success then
                notify("Teleported to Maxwell: " .. tostring(maxwellSelection))
            else
                if hrp then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                    notify("Teleported to Maxwell: " .. tostring(maxwellSelection))
                end
            end
        else
            notify("Could not get position of Maxwell egg!")
        end
    end
})

EggTab:CreateButton({
    Name = "Teleport To Rescur",
    Callback = function()
        local World = getWorld()
        if not World or not World:FindFirstChild("EasterEggs") then
            return notify("EasterEggs not found!")
        end
        
        if not char or not hrp then
            refreshCharacterRefs()
            if not char or not hrp then
                return notify("Character not loaded!")
            end
        end
        
        local target = World.EasterEggs:FindFirstChild("Rescur")
        if not target then
            return notify("Rescur egg not found!")
        end
        
        local pos = getPositionOf(target)
        if pos then
            local success, err = pcall(function() 
                char:PivotTo(CFrame.new(pos + Vector3.new(0, 3, 0))) 
            end)
            
            if success then
                notify("Teleported to Rescur Egg!")
            else
                if hrp then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                    notify("Teleported to Rescur Egg!")
                end
            end
        else
            notify("Could not get position of Rescur egg!")
        end
    end
})

EggTab:CreateButton({
    Name = "Teleport To Uranium",
    Callback = function()
        local World = getWorld()
        if not World or not World:FindFirstChild("EasterEggs") then
            return notify("EasterEggs not found!")
        end
        
        if not char or not hrp then
            refreshCharacterRefs()
            if not char or not hrp then
                return notify("Character not loaded!")
            end
        end
        
        local target = World.EasterEggs:FindFirstChild("Uranium")
        if not target then
            return notify("Uranium egg not found!")
        end
        
        local pos = getPositionOf(target)
        if pos then
            local success, err = pcall(function() 
                char:PivotTo(CFrame.new(pos + Vector3.new(0, 3, 0))) 
            end)
            
            if success then
                notify("Teleported to Uranium Egg!")
            else
                if hrp then
                    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                    notify("Teleported to Uranium Egg!")
                end
            end
        else
            notify("Could not get position of Uranium egg!")
        end
    end
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player Features", "user")
local defaultWalk = 16
local defaultJump = 50

task.wait(0.5)
if hum then
    if hum.WalkSpeed then defaultWalk = hum.WalkSpeed end
    if hum.JumpPower then defaultJump = hum.JumpPower end
end

local loopSpeed = false
local desiredSpeed = defaultWalk

PlayerTab:CreateSlider({
    Name = "Loop WalkSpeed",
    Range = {16, 200},
    Increment = 2,
    CurrentValue = defaultWalk,
    Flag = "WalkSpeedSlider",
    Callback = function(value)
        desiredSpeed = value
        if not loopSpeed then
            loopSpeed = true
            task.spawn(function()
                while loopSpeed do
                    if hum then 
                        hum.WalkSpeed = desiredSpeed 
                    else
                        refreshCharacterRefs()
                    end
                    task.wait(0.1)
                end
            end)
        end
        notify("Loop WalkSpeed Set: " .. tostring(value))
    end
})

PlayerTab:CreateButton({
    Name = "Stop Loop WalkSpeed",
    Callback = function()
        loopSpeed = false
        notify("Loop WalkSpeed Disabled")
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = defaultJump,
    Flag = "JumpPowerSlider",
    Callback = function(value)
        if hum then
            hum.JumpPower = value
            notify("JumpPower set to " .. tostring(value))
        else
            refreshCharacterRefs()
            if hum then
                hum.JumpPower = value
                notify("JumpPower set to " .. tostring(value))
            else
                notify("Humanoid not found!")
            end
        end
    end
})

getgenv().InfJump = false

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(state)
        getgenv().InfJump = state
        if state then 
            notify("Infinite Jump Enabled") 
        else 
            notify("Infinite Jump Disabled") 
        end
    end
})

UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump then
        if hum then
            pcall(function() 
                hum:ChangeState(Enum.HumanoidStateType.Jumping) 
            end)
        else
            refreshCharacterRefs()
        end
    end
end)

local Credits = Window:CreateTab("Credits", "heart")
Credits:CreateParagraph({
    Title = "Made By Rwal ❤️",
    Content = "Creator of Fling To Climb Script.\nThanks for using this open source!"
})
Credits:CreateParagraph({
    Title = "Update",
    Content = "Fixed The CallBack And Dropdown Teleport..."
})

notify("Script loaded successfully!")
