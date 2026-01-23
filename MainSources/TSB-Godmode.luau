-- HAVENT TESTED YET, DO NOT USE IT --




--!skidsimagonnatouchya
--[[
rwal was here!...
it's been an while
'more open src :3': 
GitHub.com/RwalDev/Workspace/
]]--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
	return oldNamecall(self, ...)
end)

setreadonly(mt, true)

local heartbeatConn: RBXScriptConnection? = nil
local charAddedConn: RBXScriptConnection? = nil

local function fixCamera(char)
	local hum = char:WaitForChild("Humanoid", 5)
	if hum then
		Camera.CameraSubject = hum
		Camera.CameraType = Enum.CameraType.Custom
	end
end

local function enableSemiGodmode()
	if heartbeatConn then return end

	heartbeatConn = RunService.Heartbeat:Connect(function()
		local c = lp.Character
		local r = c and c:FindFirstChild("HumanoidRootPart")
		if not r then return end

		local cf = r.CFrame
		r.CFrame = cf * CFrame.new(0, -6, 0)
		task.wait()
		r.CFrame = cf
	end)

	if lp.Character then
		fixCamera(lp.Character)
	end

	charAddedConn = lp.CharacterAdded:Connect(function(char)
		task.wait(0.2)
		fixCamera(char)
	end)
end

local function disableSemiGodmode()
	if heartbeatConn then
		heartbeatConn:Disconnect()
		heartbeatConn = nil
	end

	if charAddedConn then
		charAddedConn:Disconnect()
		charAddedConn = nil
	end
end

local gui = Instance.new("ScreenGui")
gui.Name = "SemiGodmodeUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local button = Instance.new("TextButton")
button.Name = "SemiGodmodeButton"
button.Size = UDim2.new(0, 150, 0, 34)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
button.BorderSizePixel = 0
button.AutoButtonColor = false
button.Font = Enum.Font.GothamSemibold
button.Text = "Semi Godmode"
button.TextSize = 14
button.TextColor3 = Color3.fromRGB(235, 235, 245)
button.TextXAlignment = Enum.TextXAlignment.Left
button.ZIndex = 10
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = button

local madeBy = Instance.new("TextLabel")
madeBy.Name = "MadeBy"
madeBy.BackgroundTransparency = 1
madeBy.Size = UDim2.new(1, -20, 0, 12)
madeBy.Position = UDim2.new(0, 10, 1, -14)
madeBy.Font = Enum.Font.Gotham
madeBy.Text = "Made By Rwal"
madeBy.TextSize = 10
madeBy.TextXAlignment = Enum.TextXAlignment.Left
madeBy.TextColor3 = Color3.fromRGB(150, 150, 170)
madeBy.ZIndex = 11
madeBy.Parent = button

local statusDot = Instance.new("Frame")
statusDot.Name = "StatusDot"
statusDot.AnchorPoint = Vector2.new(0, 0.5)
statusDot.Position = UDim2.new(0, 10, 0.5, -2)
statusDot.Size = UDim2.new(0, 6, 0, 6)
statusDot.BackgroundColor3 = Color3.fromRGB(120, 120, 135)
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 11
statusDot.Parent = button

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

local toggleOnSound = Instance.new("Sound")
toggleOnSound.Name = "ToggleOn"
toggleOnSound.SoundId = "rbxassetid://9120094547"
toggleOnSound.Volume = 0.5
toggleOnSound.Parent = button

local toggleOffSound = Instance.new("Sound")
toggleOffSound.Name = "ToggleOff"
toggleOffSound.SoundId = "rbxassetid://9120094547"
toggleOffSound.Volume = 0.5
toggleOffSound.Parent = button

local enabled = false
local hovering = false

local baseSize = button.Size
local baseColor = Color3.fromRGB(25, 25, 35)
local hoverColor = Color3.fromRGB(35, 35, 45)
local onColor = Color3.fromRGB(70, 190, 130)

local offDotColor = Color3.fromRGB(120, 120, 135)
local onDotColor = Color3.fromRGB(180, 255, 200)

local function tween(obj: Instance, info: TweenInfo, props: {[string]: any})
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

local function currentButtonColor(): Color3
	if enabled then
		return onColor
	end
	if hovering then
		return hoverColor
	end
	return baseColor
end

local function applyVisual(instant: boolean)
	local d = instant and 0 or 0.18

	tween(button, TweenInfo.new(d, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundColor3 = currentButtonColor(),
	})

	tween(statusDot, TweenInfo.new(d, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundColor3 = enabled and onDotColor or offDotColor,
	})
end

local function playClickPulse()
	local up = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local down = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

	local grow = tween(button, up, {
		Size = UDim2.new(
			baseSize.X.Scale,
			baseSize.X.Offset + 4,
			baseSize.Y.Scale,
			baseSize.Y.Offset + 4
		),
	})

	grow.Completed:Connect(function()
		tween(button, down, { Size = baseSize })
	end)
end

local function playVfx(onState: boolean)
	local pulse = Instance.new("Frame")
	pulse.AnchorPoint = Vector2.new(0.5, 0.5)
	pulse.Position = UDim2.fromScale(0.5, 0.5)
	pulse.Size = UDim2.new(0, 0, 0, 0)
	pulse.BackgroundColor3 = onState and Color3.fromRGB(90, 220, 160) or Color3.fromRGB(180, 80, 80)
	pulse.BackgroundTransparency = 0.4
	pulse.BorderSizePixel = 0
	pulse.ZIndex = 9
	pulse.Parent = button

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1, 0)
	c.Parent = pulse

	local t = tween(pulse, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(1.4, 0, 1.8, 0),
		BackgroundTransparency = 1,
	})

	t.Completed:Connect(function()
		pulse:Destroy()
	end)
end

local function onToggleChanged(state: boolean)
	if state then
		enableSemiGodmode()
	else
		disableSemiGodmode()
	end
end

local function setEnabled(state: boolean)
	if enabled == state then
		return
	end

	enabled = state
	applyVisual(false)
	playClickPulse()
	playVfx(enabled)

	if enabled then
		toggleOnSound:Play()
	else
		toggleOffSound:Play()
	end

	onToggleChanged(enabled)
end

button.MouseEnter:Connect(function()
	hovering = true
	applyVisual(false)
end)

button.MouseLeave:Connect(function()
	hovering = false
	applyVisual(false)
end)

button.MouseButton1Click:Connect(function()
	setEnabled(not enabled)
end)

applyVisual(true)
