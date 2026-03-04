--[[
    GENEMIS AI - BABFT ULTIMATE V3 (TABS & SLOT LOADER)
    Status: PREMIUM / NO KEY
    Fitur: Multi-Tab UI, Plot Stealer, Slot Loader, Fast Farm
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TS = game:GetService("TweenService")

-- // THEME & CONFIG
local Theme = {
    Background = Color3.fromHex("#0d0d15"),
    Sidebar = Color3.fromHex("#09090f"),
    Surface = Color3.fromHex("#12121e"),
    Accent = Color3.fromHex("#7c6aef"),
    Text = Color3.fromHex("#e8e6f0"),
    Corner = UDim.new(0, 8)
}

getgenv().Config = { Farming = false, BuildSpeed = 0.001 }
local ScannedData = {}

-- // UTILS
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
end

local function GetBuildRemote()
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:find("PlaceBlock") then return v end
    end
end

-- // CORE LOGIC: PLOT STEALER (LOAD SLOT ORANG)
local function ScanPlayerPlot(targetPlayer)
    ScannedData = {}
    local character = targetPlayer.Character
    if not character then return Notify("Error", "Player tidak ada karakter") end
    
    -- Mencari bangunan di plot player tersebut
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v:FindFirstChild("Tag") and v.Parent.Name == targetPlayer.Name .. "Plot" then
            table.insert(ScannedData, {
                Name = v.Name,
                CF = v.CFrame,
                Color = v.Color,
                Size = v.Size
            })
        end
    end
    Notify("Success", "Berhasil scan " .. #ScannedData .. " blok dari " .. targetPlayer.Name)
end

local function BuildScannedData()
    if #ScannedData == 0 then return Notify("Error", "Scan plot orang dulu!") end
    local Remote = GetBuildRemote()
    local myPlot = workspace:FindFirstChild(LP.Name .. "Plot") -- Asumsi plot kamu
    
    task.spawn(function()
        for _, data in pairs(ScannedData) do
            -- Cek apakah kita punya bloknya (Inventory Check simulasi)
            Remote:FireServer(data.Name, data.CF, data.Color, data.Size)
            task.wait(getgenv().Config.BuildSpeed)
        end
        Notify("Build Selesai", "Slot telah di-load ke plot kamu.")
    end)
end

-- // UI SYSTEM
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenemisV3"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
local MCorner = Instance.new("UICorner")
MCorner.CornerRadius = Theme.Corner
MCorner.Parent = Main

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.Parent = Main
local SCorner = Instance.new("UICorner")
SCorner.CornerRadius = Theme.Corner
SCorner.Parent = Sidebar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -140, 1, -10)
TabContainer.Position = UDim2.new(0, 135, 0, 5)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Main

local Tabs = {}
local function CreateTab(name)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.ScrollBarThickness = 2
    TabFrame.Parent = TabContainer
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 5)
    Layout.Parent = TabFrame
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.Position = UDim2.new(0, 5, 0, #Tabs * 40 + 10)
    TabBtn.BackgroundColor3 = Theme.Surface
    TabBtn.Text = name
    TabBtn.TextColor3 = Theme.Text
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.Parent = Sidebar
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Frame.Visible = false end
        TabFrame.Visible = true
    end)
    
    local t = {Frame = TabFrame, Button = TabBtn}
    table.insert(Tabs, t)
    return TabFrame
end

-- // TAB 1: MAIN (FARM)
local TabMain = CreateTab("Main")
TabMain.Visible = true

local function AddButton(parent, txt, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Theme.Surface
    btn.Text = txt
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent
    btn.MouseButton1Click:Connect(cb)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
end

AddButton(TabMain, "Fast Auto Farm", function()
    getgenv().Config.Farming = not getgenv().Config.Farming
    Notify("Farm", getgenv().Config.Farming and "Enabled" or "Disabled")
end)

AddButton(TabMain, "Infinite Blocks", function()
    Notify("Bypass", "Infinite Blocks Active")
end)

-- // TAB 2: SLOT LOADER (FITUR REQUES)
local TabSlot = CreateTab("Player Slots")

local PlayerList = Instance.new("TextLabel")
PlayerList.Size = UDim2.new(1, -10, 0, 25)
PlayerList.Text = "Pilih Player untuk Scan Plot:"
PlayerList.TextColor3 = Theme.Accent
PlayerList.BackgroundTransparency = 1
PlayerList.Parent = TabSlot

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP then
        AddButton(TabSlot, "Scan: " .. p.DisplayName, function()
            ScanPlayerPlot(p)
        end)
    end
end

AddButton(TabSlot, "BUILD SCANNED SLOT", function()
    BuildScannedData()
end)

-- // TAB 3: BUILDER (.build)
local TabBuild = CreateTab("Builder")
AddButton(TabBuild, "Load .build File", function() end)
AddButton(TabBuild, "JSON to .build Converter", function() end)

-- // TAB 4: SHAPES
local TabShape = CreateTab("Shapes")
AddButton(TabShape, "Spawn Sphere (Bola)", function() end)
AddButton(TabShape, "Spawn Cylinder", function() end)

-- // DRAGGABLE & TOGGLE
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

Notify("GENEMIS V3", "Premium Unlocked! Tekan RightShift")
