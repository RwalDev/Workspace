local rs = game:GetService("ReplicatedStorage")

local function god()
	local events = rs:FindFirstChild("RemoteEvents")
	if not events then
		warn("RemoteEvents not found")
		return
	end

	local dmg = events:FindFirstChild("DamagePlayer")
	if not dmg then
		warn("DamagePlayer not found")
		return
	end

	local ok, err = pcall(function()
		dmg:FireServer(-9e9)
	end)

	if not ok then
		warn("God failed:", err)
	end
end

task.wait(1)
god()

task.spawn(function()
	while task.wait(0.5) do
		god()
	end
end)
