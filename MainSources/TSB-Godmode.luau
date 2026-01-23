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
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local heartbeatConn = nil
local steppedConn = nil
local charAddedConn = nil
local gui = nil
local button = nil
local statusDot = nil
local toggleOnSound = nil
local toggleOffSound = nil

local enabled = false
local hovering = false

local baseSize = UDim2.new(0, 150, 0, 34)
local baseColor = Color3.fromRGB(25, 25, 35)
local hoverColor = Color3.fromRGB(35, 35, 45)
local onColor = Color3.fromRGB(70, 190, 130)
local offDotColor = Color3.fromRGB(120, 120, 135)
local onDotColor = Color3.fromRGB(180, 255, 200)

local function fixCamera(char)
	local hum = char:WaitForChild("Humanoid", 5)
	if hum and Camera then
		Camera.CameraType = Enum.CameraType.Custom
		Camera.CameraSubject = hum
	end
end

local function enableGodmode()
	if heartbeatConn or steppedConn then return end

	steppedConn = RunService.Stepped:Connect(function()
		local char = lp.Character
		if not char then return end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local v = hrp.AssemblyLinearVelocity
		if v.Y < -60 then
			hrp.AssemblyLinearVelocity = Vector3.new(v.X, -10, v.Z)
		end
	end)

	heartbeatConn = RunService.Heartbeat:Connect(function()
		local char = lp.Character
		if not char then return end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local cf = hrp.CFrame
		hrp.CFrame = cf * CFrame.new(0, -0.8, 0)
		RunService.Heartbeat:Wait()
		if hrp then
			hrp.CFrame = cf
		end
	end)

	if lp.Character then
		task.delay(0.1, function()
			fixCamera(lp.Character)
		end)
	end

	charAddedConn = lp.CharacterAdded:Connect(function(char)
		task.delay(0.2, function()
			fixCamera(char)
		end)
	end)
end

local function disableGodmode()
	if heartbeatConn then heartbeatConn:Disconnect() heartbeatConn = nil end
	if steppedConn then steppedConn:Disconnect() steppedConn = nil end
	if charAddedConn then charAddedConn:Disconnect() charAddedConn = nil end
end

local function tween(obj, info, props)
	local t = TweenService:Create(obj, info, props)
	t:Play()
	return t
end

local function currentButtonColor()
	if enabled then return onColor end
	if hovering then return hoverColor end
	return baseColor
end

local function applyVisual(instant)
	local d = instant and 0 or 0.18
	tween(button, TweenInfo.new(d, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundColor3 = currentButtonColor()
	})
	tween(statusDot, TweenInfo.new(d, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundColor3 = enabled and onDotColor or offDotColor
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
		)
	})
	grow.Completed:Connect(function()
		tween(button, down, { Size = baseSize })
	end)
end

local function playVfx(onState)
	local pulse = Instance.new("Frame")
	pulse.AnchorPoint = Vector2.new(0.5, 0.5)
	pulse.Position = UDim2.fromScale(0.5, 0.5)
	pulse.Size = UDim2.new(0, 0, 0, 0)
	pulse.BackgroundColor3 = onState and Color3.fromRGB(90, 220, 160) or Color3.fromRGB(180, 80, 80)
	pulse.BackgroundTransparency = 0.4
	pulse.BorderSizePixel = 0
	pulse.ZIndex = 9
	pulse.Parent = button
	Instance.new("UICorner", pulse).CornerRadius = UDim.new(1, 0)
	local t = tween(pulse, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(1.4, 0, 1.8, 0),
		BackgroundTransparency = 1
	})
	t.Completed:Connect(function()
		pulse:Destroy()
	end)
end

gui = Instance.new("ScreenGui")
gui.Name = "GodmodeUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function ensureGui()
	if gui.Parent ~= playerGui then
		gui.Parent = playerGui
	end
end

ensureGui()

lp.CharacterAdded:Connect(function()
	task.wait(0.1)
	playerGui = lp:WaitForChild("PlayerGui")
	ensureGui()
end)

button = Instance.new("TextButton")
button.Name = "GodmodeButton"
button.Size = baseSize
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = baseColor
button.BorderSizePixel = 0
button.AutoButtonColor = false
button.Font = Enum.Font.GothamSemibold
button.Text = "Godmode"
button.TextSize = 14
button.TextColor3 = Color3.fromRGB(235, 235, 245)
button.TextXAlignment = Enum.TextXAlignment.Left
button.ZIndex = 10
button.Parent = gui

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

local madeBy = Instance.new("TextLabel")
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

statusDot = Instance.new("Frame")
statusDot.AnchorPoint = Vector2.new(0, 0.5)
statusDot.Position = UDim2.new(0, 10, 0.5, -2)
statusDot.Size = UDim2.new(0, 6, 0, 6)
statusDot.BackgroundColor3 = offDotColor
statusDot.BorderSizePixel = 0
statusDot.ZIndex = 11
statusDot.Parent = button

Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)

toggleOnSound = Instance.new("Sound")
toggleOnSound.SoundId = "rbxassetid://9120094547"
toggleOnSound.Volume = 0.5
toggleOnSound.Parent = button

toggleOffSound = Instance.new("Sound")
toggleOffSound.SoundId = "rbxassetid://9120094547"
toggleOffSound.Volume = 0.5
toggleOffSound.Parent = button

button.MouseEnter:Connect(function()
	hovering = true
	applyVisual(false)
end)

button.MouseLeave:Connect(function()
	hovering = false
	applyVisual(false)
end)

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	applyVisual(false)
	playClickPulse()
	playVfx(enabled)
	if enabled then
		toggleOnSound:Play()
		enableGodmode()
	else
		toggleOffSound:Play()
		disableGodmode()
	end
end)

applyVisual(true)
