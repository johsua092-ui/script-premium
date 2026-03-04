--[[
    ASU HUB - oxyX CUSTOM EDITION
    VERSION: 4.0.0 (FULL CUSTOM UI)
    BYPASS: GOD-TIER
    OPTIMIZED FOR: XENO, VELOCITY
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Bypass & Global Vars
getgenv().AsuPremium = true
getgenv().InfiniteBlocks = true
getgenv().FastFarm = false

-- Create UI Base
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AsuHub_oxyX"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Container
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 400)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Split Panels
local LeftPanel = Instance.new("Frame")
LeftPanel.Name = "LeftPanel"
LeftPanel.Size = UDim2.new(0.5, -10, 1, -20)
LeftPanel.Position = UDim2.new(0, 5, 0, 10)
LeftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LeftPanel.BorderSizePixel = 1
LeftPanel.BorderColor3 = Color3.fromRGB(30, 30, 30)
LeftPanel.Parent = MainFrame

local RightPanel = Instance.new("Frame")
RightPanel.Name = "RightPanel"
RightPanel.Size = UDim2.new(0.5, -10, 1, -20)
RightPanel.Position = UDim2.new(0.5, 5, 0, 10)
RightPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
RightPanel.BorderSizePixel = 1
RightPanel.BorderColor3 = Color3.fromRGB(30, 30, 30)
RightPanel.Parent = MainFrame

-- Titles
local function CreateTitle(name, parent)
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.Parent = parent
    return title
end

CreateTitle("oxyX", LeftPanel)
CreateTitle("Exploit", RightPanel)

-- Tabs Row (Left)
local LeftTabs = Instance.new("Frame")
LeftTabs.Size = UDim2.new(1, -10, 0, 30)
LeftTabs.Position = UDim2.new(0, 5, 0, 35)
LeftTabs.BackgroundTransparency = 1
LeftTabs.Parent = LeftPanel

local function CreateTabBtn(name, pos, size, parent)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = parent
    return btn
end

CreateTabBtn("AutoBuild", UDim2.new(0, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), LeftTabs)
CreateTabBtn("Image Loader", UDim2.new(0.35, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), LeftTabs)
CreateTabBtn("Shapes", UDim2.new(0.7, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), LeftTabs)

-- Content Area (Left)
local LeftContent = Instance.new("ScrollingFrame")
LeftContent.Size = UDim2.new(1, -10, 1, -80)
LeftContent.Position = UDim2.new(0, 5, 0, 75)
LeftContent.BackgroundTransparency = 1
LeftContent.ScrollBarThickness = 2
LeftContent.Parent = LeftPanel

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Parent = LeftContent

-- Feature Buttons (Left)
local function CreateActionBtn(name, parent, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 25)
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.Parent = parent
    return btn
end

CreateActionBtn("Go Back", LeftContent, Color3.fromRGB(150, 50, 50))
CreateActionBtn("ac dc (1).build", LeftContent)
CreateActionBtn("anomali 595.Build", LeftContent)
CreateActionBtn("Big Robot.Build", LeftContent)

-- JSON Converter Section
local JsonLabel = Instance.new("TextLabel")
JsonLabel.Size = UDim2.new(0.9, 0, 0, 20)
JsonLabel.Text = "--- JSON to .build Converter ---"
JsonLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
JsonLabel.BackgroundTransparency = 1
JsonLabel.TextSize = 10
JsonLabel.Parent = LeftContent

CreateActionBtn("Convert JSON + .build", LeftContent, Color3.fromRGB(0, 100, 200))

-- Infinite Blocks Status
local InfLabel = Instance.new("TextLabel")
InfLabel.Size = UDim2.new(0.9, 0, 0, 25)
InfLabel.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
InfLabel.Text = "Infinite Blocks: ENABLED"
InfLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
InfLabel.TextSize = 11
InfLabel.Parent = LeftContent

-- Tabs Row (Right)
local RightTabs = Instance.new("Frame")
RightTabs.Size = UDim2.new(1, -10, 0, 30)
RightTabs.Position = UDim2.new(0, 5, 0, 35)
RightTabs.BackgroundTransparency = 1
RightTabs.Parent = RightPanel

CreateTabBtn("AutoFarm", UDim2.new(0, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), RightTabs)
CreateTabBtn("Misc", UDim2.new(0.35, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), RightTabs)
CreateTabBtn("Modules", UDim2.new(0.7, 0, 0, 0), UDim2.new(0.3, 0, 1, 0), RightTabs)

-- Content Area (Right)
local RightContent = Instance.new("ScrollingFrame")
RightContent.Size = UDim2.new(1, -10, 1, -80)
RightContent.Position = UDim2.new(0, 5, 0, 75)
RightContent.BackgroundTransparency = 1
RightContent.ScrollBarThickness = 2
RightContent.Parent = RightPanel

local UIList2 = Instance.new("UIListLayout")
UIList2.Padding = UDim.new(0, 5)
UIList2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList2.Parent = RightContent

-- Exploit Controls
CreateActionBtn("Anti-Afk", RightContent)
local FarmBtn = CreateActionBtn("AutoFarm (Fastest)", RightContent)
CreateActionBtn("Silent Mode", RightContent)

-- Stats Section
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(0.9, 0, 0, 80)
StatsLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
StatsLabel.Text = "--- Stats ---\nElapsed: 00:00:00\nGold Blocks: 0\nGold Gained: 0\nGold/Hour: 0"
StatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatsLabel.TextSize = 10
StatsLabel.Parent = RightContent

-- Webhook Section
CreateActionBtn("Discord Webhook URL", RightContent)
CreateActionBtn("WebHook Active", RightContent, Color3.fromRGB(0, 100, 200))

-- Config Section
CreateActionBtn("Save Configuration", RightContent, Color3.fromRGB(50, 50, 150))
CreateActionBtn("Load Configuration", RightContent, Color3.fromRGB(50, 50, 150))

-- LOGIC: AutoFarm Fastest
FarmBtn.MouseButton1Click:Connect(function()
    getgenv().FastFarm = not getgenv().FastFarm
    FarmBtn.BackgroundColor3 = getgenv().FastFarm and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(30, 30, 30)
    
    spawn(function()
        while getgenv().FastFarm do
            task.wait(0.01)
            pcall(function()
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local endZone = workspace:FindFirstChild("Sea"):FindFirstChild("End")
                if endZone then
                    hrp.CFrame = endZone.CFrame
                    firetouchinterest(hrp, endZone, 0)
                    firetouchinterest(hrp, endZone, 1)
                end
            end)
        end
    end)
end)

-- LOGIC: Close UI (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("Asu Hub oxyX Edition Loaded Successfully!")
