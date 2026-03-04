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
   ConfigurationSaving = { Enabled = true, FolderName = "AsuHub", FileName = "BABFT_Config" },
   KeySystem = false -- Keyless enabled
})

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local FarmingTab = Window:CreateTab("Farming", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Auto Farm Logic (Fast Bypass)
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

-- Quest Solver (Bypass)
FarmingTab:CreateButton({
   Name = "Auto Solve All Quests",
   Callback = function()
      local quests = {"Cloud", "Target", "Ramp", "FindMe", "Dragon"}
      for _, questName in pairs(quests) do
          game:GetService("ReplicatedStorage").Events.QuestEvents:FireServer("StartQuest", questName)
          task.wait(1)
      end
   end,
})

Rayfield:LoadConfiguration()
