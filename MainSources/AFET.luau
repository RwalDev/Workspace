-- if your not from scriptblox heres toggle
-- local autoaura = true
game:GetService("RunService").Heartbeat:Connect(function()
    if not autoaura then return end
    pcall(function()
        local h = game.Players.LocalPlayer.Character.HumanoidRootPart
        firetouchinterest(h, workspace:GetChildren()[57].Model.Lobby, 0)
        firetouchinterest(h, workspace:GetChildren()[57].Model.Lobby, 1)
    end)
end)
