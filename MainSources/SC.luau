local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Solitary Confinement - By Rwal",
   LoadingTitle = "Loading Solitary Confinement Script",
   LoadingSubtitle = "By Rwal",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- tabs
local Credits = Window:CreateTab("Home", 4483362458)
Credits:CreateLabel("Credits:")
Credits:CreateLabel("Script Made by: Rwal (Me)")
Credits:CreateLabel("Credits To EdgeIY For IY And 7yd7 For Fe Emote Loader...")
Credits:CreateLabel("Thanks For Using My Script :D")
local Main = Window:CreateTab("Main", 4483362458)
local Misc = Window:CreateTab("Misc", 4483362458)

-- notify support
local function notify(text)
   game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Script",
      Text = text,
      Icon = "",
      Duration = 5
   })
end

Main:CreateButton({
   Name = "Show Your Symbol",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local lph = workspace:FindFirstChild(lp.Name) and workspace[lp.Name]:FindFirstChild("Head")
      if lph and lph:FindFirstChild("SymbolGUI") then
         lph.SymbolGUI.Enabled = true
         notify("Symbol Enabled!")
      else
         notify("Symbol not found. Your not in the game buddy!")
      end
   end,
})

local espHighlight
Main:CreateToggle({
   Name = "ESP Jack",
   CurrentValue = false,
   Flag = "JackESP",
   Callback = function(state)
      if state then
         local jack = game:GetService("ReplicatedStorage"):FindFirstChild("JackName")
         if jack and jack:IsA("StringValue") then
            local player = game.Players:FindFirstChild(jack.Value)
            if player and player.Character then
               local char = player.Character
               espHighlight = Instance.new("Highlight")
               espHighlight.Parent = char
               espHighlight.Adornee = char
               espHighlight.FillColor = Color3.fromRGB(255,0,0)
               espHighlight.OutlineColor = Color3.fromRGB(255,255,255)
               espHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
               notify("ESP enabled for Jack: " .. player.Name)
            else
               notify("Jack player not found. Or Not In The Game")
            end
         else
            notify("JackName not found in ReplicatedStorage. or Not In The Game!")
         end
      else
         if espHighlight then
            espHighlight:Destroy()
            espHighlight = nil
            notify("Jack ESP disabled.")
         end
      end
   end,
})
Main:CreateButton({
   Name = "Copy Jack User",
   Callback = function()
      local jack = game:GetService("ReplicatedStorage"):FindFirstChild("JackName")
      if jack and jack:IsA("StringValue") then
         setclipboard(jack.Value)
         notify("Jack of heart copied: " .. jack.Value)
      else
         notify("Jack not found! or NOT IN THE GAME!")
      end
   end,
})
Misc:CreateButton({
   Name = "Enable Chat",
   Callback = function()
      local StarterGui = game:GetService("StarterGui")
      StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
      StarterGui:SetCore("ChatMakeSystemMessage", {
         Text = "Chat enabled successfully!",
         Color = Color3.fromRGB(0,255,0),
         Font = Enum.Font.SourceSansBold,
         FontSize = Enum.FontSize.Size24
      })
      notify("Chat enabled!")
   end,
})
Misc:CreateButton({
   Name = "Fe Emote Loader",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
end,
})
Misc:CreateButton({
   Name = "Infinite Yleid",
   Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end,
})

-- end
notify("Loaded Successfully... But Make Sure Your In The Game...!")
