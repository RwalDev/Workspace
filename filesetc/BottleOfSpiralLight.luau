local TweenService_upvr = game:GetService("TweenService")
local MainUI_upvr = nil
if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI") then repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI") end
MainUI_upvr = game.Players.LocalPlayer.PlayerGui.MainUI
local toolNew = nil
if game.GameId == 6627207668 then
	toolNew = game.ReplicatedStorage["Spiral Bottle"]:Clone()
else
	toolNew = game:GetObjects("rbxassetid://125377922223551")[1]
end
local newCloneEffect = MainUI_upvr.MainFrame.Healthbar.Effects.HerbGreenEffect:Clone()
local drinked = false
local okstop = false
newCloneEffect.Name = "EvilLightPotion"
newCloneEffect.ImageColor3 = Color3.fromRGB(255,255,255)
newCloneEffect.Image = "rbxassetid://74062787660956"
newCloneEffect.Visible = false
newCloneEffect.Parent = MainUI_upvr.MainFrame.Healthbar.Effects

local highlight = Instance.new("Highlight")

local heartBeat = Instance.new("Sound",workspace)
heartBeat.Name = "_HeartBeatEvil"
heartBeat.Volume = 1
heartBeat.SoundId = "rbxassetid://7188240609"
heartBeat.Looped = true

local ohhmydayz = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(toolNew.bals.idle)
local ohhmydayz2 = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(toolNew.bals.open)
local ohhmydayz3 = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(toolNew.Animations.open)

spawn(function()
	while wait() do
		if drinked == true then
			if okstop == false then
				okstop = true
				local newColorEcction = Instance.new("ColorCorrectionEffect",game.Lighting)
				wait(4)
				if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 10 then
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health = 10
				end
				heartBeat:Play()
				TweenService_upvr:Create(newColorEcction, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Brightness = 0.3,
					TintColor = Color3.fromRGB(255,0,0)
				}):Play()
				wait(5)
				newColorEcction:Destroy()
				if game.ReplicatedStorage:FindFirstChild("GameStats") then
					if game.ReplicatedStorage.GameStats:FindFirstChild("Player_"..game.Players.LocalPlayer.Name) then
						game.ReplicatedStorage.GameStats["Player_"..game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Mischievious Light"
					end
				end
				game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
				heartBeat:Stop()
				highlight:Destroy()
			end
		end
	end
end)

local function EffectOnScreen()
	drinkSoundPlay()
	newCloneEffect.Visible = true
	highlight.Parent = game.Players.LocalPlayer.Character
	spawn(function()
		local clone = MainUI_upvr.MainFrame.WhiteVignette:Clone()
		if clone then
			local clone_2 = clone:Clone()
			clone_2.Name ..= "Live"
			clone_2.ImageColor3 = Color3.fromRGB(255, 0, 4)
			clone_2.ImageTransparency = 1
			clone_2.Parent = MainUI_upvr.MainFrame
			clone_2.Visible = true
			TweenService_upvr:Create(clone_2, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				ImageTransparency = 0;
			}):Play()
			wait(5)
			TweenService_upvr:Create(clone_2, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Size = UDim2.new(1.5, 0, 1.5, 0);
			}):Play()
			wait(0.5)
			TweenService_upvr:Create(clone_2, TweenInfo.new(4.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
				ImageTransparency = 1;
			}):Play()
			wait(4.5)
			clone_2:Destroy()
		end
	end)
end

function drinkSoundPlay()
	local newSound = nil
	if not workspace:FindFirstChild("DrinkPotionAddonSound") then
		newSound = Instance.new("Sound",workspace)
		newSound.Name = "DrinkPotionAddonSound"
		if game.GameId == 6627207668 then
			newSound.SoundId = "rbxassetid://103799151859408"
		else
			newSound.SoundId = "rbxassetid://18869124055"
		end
	else
		newSound = workspace:WaitForChild("DrinkPotionAddonSound")
	end
	newSound:Play()
end

toolNew.Parent = game.Players.LocalPlayer.Backpack

toolNew.Equipped:Connect(function()
	if game.GameId == 6627207668 then
		ohhmydayz:Play()
	end
end)
toolNew.Unequipped:Connect(function()
	if game.GameId == 6627207668 then
		ohhmydayz:Stop()
	end
end)

toolNew.Activated:Connect(function()
	if drinked == false then
		drinked = true
		EffectOnScreen()
		if game.GameId == 6627207668 then
			ohhmydayz2:Play()
			ohhmydayz2.Ended:Wait()
		else
			ohhmydayz3:Play()
			ohhmydayz3.Ended:Wait()
		end
		toolNew:Destroy()
	end
end)
