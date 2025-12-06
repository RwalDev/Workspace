local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "RwalDev/Workspace - Mafia",
    LoadingTitle = "Loading UI",
    LoadingSubtitle = "Made by RwalDev",
    Theme = "Dark"
})

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

local roleColors = {
    ["Mafia"] = Color3.fromRGB(255, 70, 70),
    ["Detective"] = Color3.fromRGB(70, 120, 255),
    ["Doctor"] = Color3.fromRGB(80, 255, 120),
    ["Citizen"] = Color3.fromRGB(200, 200, 200),
    ["Sheriff"] = Color3.fromRGB(255, 180, 60),
    ["Jester"] = Color3.fromRGB(255, 100, 255),
    ["Mayor"] = Color3.fromRGB(255, 220, 90),
}

local defaultColor = Color3.fromRGB(150,150,150)
local espHighlights = {}
local espEnabled = false
local removeBlackEnabled = false

local function applyESP(plr)
    if not espEnabled then return end
    if not plr.Character then return end

    local role = plr:GetAttribute("Role")
    if not role then return end

    local color = roleColors[role] or defaultColor

    if not espHighlights[plr] then
        local h = Instance.new("Highlight")
        h.FillTransparency = 1
        h.OutlineTransparency = 0.15
        h.OutlineColor = color
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Adornee = plr.Character
        h.Parent = plr.Character
        espHighlights[plr] = h
    else
        espHighlights[plr].OutlineColor = color
        espHighlights[plr].Adornee = plr.Character
    end

    if not plr.Character:FindFirstChild("RwalBillboard") then
        local bb = Instance.new("BillboardGui")
        bb.Name = "RwalBillboard"
        bb.Size = UDim2.new(4,0,1,0)
        bb.AlwaysOnTop = true
        bb.Adornee = plr.Character:FindFirstChild("Head")
        bb.Parent = plr.Character

        local tl = Instance.new("TextLabel")
        tl.BackgroundTransparency = 1
        tl.Size = UDim2.new(1,0,1,0)
        tl.TextScaled = true
        tl.Font = Enum.Font.GothamBold
        tl.TextColor3 = color
        tl.Text = plr.Name.." ["..role.."]"
        tl.Parent = bb
    else
        local bb = plr.Character.RwalBillboard
        bb.TextLabel.TextColor3 = color
        bb.TextLabel.Text = plr.Name.." ["..role.."]"
    end
end

local function removeESP(plr)
    if espHighlights[plr] then
        espHighlights[plr]:Destroy()
        espHighlights[plr] = nil
    end

    if plr.Character and plr.Character:FindFirstChild("RwalBillboard") then
        plr.Character.RwalBillboard:Destroy()
    end
end

local function removeBlackScreenLoop()
    task.spawn(function()
        while removeBlackEnabled do
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if pg then
                local hd = pg:FindFirstChild("HeadsDown")
                if hd then hd:Destroy() end
            end

            for _, blur in pairs(Lighting:GetChildren()) do
                if blur:IsA("BlurEffect") then
                    blur.Enabled = false
                    blur.Size = 0
                end
            end

            task.wait(0.3)
        end
    end)
end

local Tab = Window:CreateTab("Main")

Tab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Callback = function(state)
        espEnabled = state

        if not espEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                removeESP(p)
            end
        else
            for _, p in ipairs(Players:GetPlayers()) do
                applyESP(p)
            end
        end
    end
})

Tab:CreateToggle({
    Name = "Remove Black Screens / Blur",
    CurrentValue = false,
    Callback = function(state)
        removeBlackEnabled = state
        removeBlackScreenLoop()
    end
})

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        applyESP(plr)
    end)
end)

Players.PlayerRemoving:Connect(function(plr)
    removeESP(plr)
end)

task.spawn(function()
    while true do
        if espEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                applyESP(p)
            end
        end
        task.wait(0.5)
    end
end)
