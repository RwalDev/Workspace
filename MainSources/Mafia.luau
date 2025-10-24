local player = game.Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")
local lighting = game:GetService("Lighting")

while true do
    local hd = pg:FindFirstChild("HeadsDown")
    if hd then hd:Destroy() end

    for _, b in pairs(lighting:GetChildren()) do
        if b:IsA("BlurEffect") then
            b.Size = 0
            b.Enabled = false
        end
    end

    wait(0.5)
end
