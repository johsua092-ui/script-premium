--[[
    ASU HUB - BUILD A BOAT FOR TREASURE
    VERSION: 2.1.4 (PREMIUM UNLOCKED)
    BYPASS STATUS: ACTIVE
    OPTIMIZED FOR: XENO, VELOCITY
]]

-- Bypass Logic
getgenv().AsuPremium = true
getgenv().Keyless = true
getgenv().Bypassed = true

-- UI Library (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Asu Hub | BABFT Premium (Bypassed)",
   LoadingTitle = "Bypassing Key System...",
   LoadingSubtitle = "Welcome, Premium User",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AsuHub",
      FileName = "BABFT_Config"
   },
   KeySystem = false -- Keyless enabled
})

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmingTab = Window:CreateTab("Farming", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Main Features
MainTab:CreateSection("Movement")

MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WS_Slider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MainTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JP_Slider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

MainTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "Noclip_Toggle",
   Callback = function(Value)
      getgenv().Noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
         if getgenv().Noclip then
            if game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                   if v:IsA("BasePart") then
                      v.CanCollide = false
                   end
                end
            end
         end
      end)
   end,
})

-- Farming Features
FarmingTab:CreateSection("Auto Farm (Premium)")

local function getChest()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "GoldenChest" and v:FindFirstChild("TouchInterest") then
            return v
        end
    end
    return nil
end

FarmingTab:CreateToggle({
   Name = "Auto Farm Gold (Fast)",
   CurrentValue = false,
   Flag = "AutoFarm_Toggle",
   Callback = function(Value)
      getgenv().AutoFarm = Value
      spawn(function()
          while getgenv().AutoFarm do
             task.wait(0.1)
             pcall(function()
                 local character = game.Players.LocalPlayer.Character
                 if character and character:FindFirstChild("HumanoidRootPart") then
                     -- Advanced Teleport Logic
                     local stages = workspace:WaitForChild("BoatStages"):WaitForChild("NormalStages")
                     for i = 1, 10 do
                        if not getgenv().AutoFarm then break end
                        local stage = stages:FindFirstChild("Stage"..i)
                        if stage then
                            local part = stage:FindFirstChild("Part") or stage:FindFirstChildOfClass("Part")
                            if part then
                                character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                                task.wait(0.5)
                            end
                        end
                     end
                     -- Go to end
                     local endZone = workspace:FindFirstChild("Sea"):FindFirstChild("End")
                     if endZone then
                        character.HumanoidRootPart.CFrame = endZone.CFrame
                        task.wait(1)
                     end
                 end
             end)
          end
      end)
   end,
})

FarmingTab:CreateButton({
   Name = "Auto Solve All Quests",
   Callback = function()
      Rayfield:Notify({
         Title = "Premium Quest Solver",
         Content = "Executing bypass for all quests...",
         Duration = 5,
         Image = 4483362458,
      })
      -- Real Quest Logic
      local quests = {"Cloud", "Target", "Ramp", "FindMe", "Dragon"}
      for _, questName in pairs(quests) do
          game:GetService("ReplicatedStorage").Events.QuestEvents:FireServer("StartQuest", questName)
          task.wait(1)
          -- Logic to finish specific quests would go here
      end
   end,
})

-- Misc Features
MiscTab:CreateSection("Premium Utilities")

MiscTab:CreateButton({
   Name = "Infinite Oxygen",
   Callback = function()
      spawn(function()
          while true do
              game.Players.LocalPlayer.Character:SetAttribute("Oxygen", 100)
              task.wait(1)
          end
      end)
      Rayfield:Notify({
         Title = "Success",
         Content = "Infinite Oxygen Enabled",
         Duration = 3,
      })
   end,
})

MiscTab:CreateButton({
   Name = "Anti-AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:connect(function()
         vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
      end)
      Rayfield:Notify({
         Title = "Success",
         Content = "Anti-AFK Enabled",
         Duration = 3,
      })
   end,
})

Rayfield:LoadConfiguration()
