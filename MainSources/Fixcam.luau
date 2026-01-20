pcall(function()
    if not getgenv().CameraFixLoaded then
        getgenv().CameraFixLoaded = true
        
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer
        local camera = workspace.CurrentCamera
        
        local function targetScript()
            local char = player.Character
            if not char then return nil end
            local handler = char:FindFirstChild("CharacterHandler")
            if not handler then return nil end
            return handler:FindFirstChild("Client")
        end
        
        local function currentCamera()
            return workspace.CurrentCamera
        end
        
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNewIndex = mt.__newindex
        
        mt.__newindex = newcclosure(function(self, key, value)
            if self == currentCamera() and key == "CameraSubject" then
                local caller = getcallingscript()
                if caller == targetScript() then
                    return
                end
            end
            if self == currentCamera() and key == "CameraType" then
                local caller = getcallingscript()
                if caller == targetScript() then
                    return
                end
            end
            return oldNewIndex(self, key, value)
        end)
        
        setreadonly(mt, true)
        
        local function fixCamera()
            camera.CameraType = Enum.CameraType.Custom
            
            if player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    camera.CameraSubject = humanoid
                    player.CameraMaxZoomDistance = 128
                    player.CameraMinZoomDistance = 0.5
                end
            end
        end
        
        camera:GetPropertyChangedSignal("CameraType"):Connect(function()
            task.wait()
            if camera.CameraType == Enum.CameraType.Scriptable then
                fixCamera()
            end
        end)
        
        camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            task.wait()
            fixCamera()
        end)
        
        RunService.RenderStepped:Connect(function()
            if camera.CameraType == Enum.CameraType.Scriptable then
                fixCamera()
            end
        end)
        
        player.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid")
            task.wait(0.5)
            fixCamera()
        end)
        
        if player.Character then
            fixCamera()
        end
    end
end)
