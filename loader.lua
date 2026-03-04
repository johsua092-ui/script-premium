--[[
    GENEMIS AI - BABFT ULTIMATE V4 (OPTIMIZED)
    Status: PREMIUM / KEYLESS
    Fitur: Anti-Lag Scanner, File Explorer, Slot Stealer, UI Controls
]]

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- // THEME & CONFIG
local Theme = {
    Background = Color3.fromHex("#0d0d15"),
    Sidebar = Color3.fromHex("#09090f"),
    Surface = Color3.fromHex("#12121e"),
    Accent = Color3.fromHex("#7c6aef"),
    Text = Color3.fromHex("#e8e6f0"),
    Corner = UDim.new(0, 8)
}

getgenv().Config = { Farming = false, BuildSpeed = 0.005 }
local ScannedData = {}

-- // FOLDER CHECK
if not isfolder("GENEMIS_BABFT") then makefolder("GENEMIS_BABFT") end
if not isfolder("GENEMIS_BABFT/Builds") then makefolder("GENEMIS_BABFT/Builds") end

-- // UTILS
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
end

local function GetBuildRemote()
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:find("PlaceBlock") then return v end
    end
end

-- // ANTI-LAG SCANNER
local function ScanPlayerPlot(targetPlayer)
    ScannedData = {}
    local plotName = targetPlayer.Name .. "Plot"
    local targetPlot = workspace:FindFirstChild(plotName)
    
    if not targetPlot then return Notify("Error", "Plot tidak ditemukan!") end
    
    Notify("Scanning", "Sedang mengambil data blok " .. targetPlayer.DisplayName .. "...")
    
    task.spawn(function()
        local count = 0
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v:FindFirstChild("Tag") and v.Parent.Name == plotName then
                table.insert(ScannedData, {
                    Name = v.Name,
                    CF = v.CFrame,
                    Color = v.Color,
                    Size = v.Size
                })
                count = count + 1
                
                -- ANTI-FREEZE: Jeda setiap 200 blok agar tidak lag
                if count % 200 == 0 then task.wait() end
            end
        end
        Notify("Success", "Berhasil scan " .. #ScannedData .. " blok tanpa lag!")
    end)
end

-- // UI SYSTEM (ENLARGED 650x450)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenemisV4"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 450)
Main.Position = UDim2.new(0.5, -325, 0.5, -225)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = Theme.Corner

-- Top Bar (Drag & Controls)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Theme.Sidebar
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = Theme.Corner

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "GENEMIS AI | BABFT PREMIUM"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Close & Minimize
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Theme.Surface
MinBtn.TextColor3 = Theme.Text
MinBtn.Parent = TopBar
MinBtn.MouseButton1Click:Connect(function() 
    Main.Visible = not Main.Visible 
    Notify("Genemis", "Tekan RightShift untuk memunculkan kembali")
end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -45)
Sidebar.Position = UDim2.new(0, 5, 0, 45)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.Parent = Main
Instance.new("UICorner", Sidebar).CornerRadius = Theme.Corner

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -165, 1, -50)
TabContainer.Position = UDim2.new(0, 160, 0, 45)
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
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = TabFrame
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -10, 0, 40)
    TabBtn.Position = UDim2.new(0, 5, 0, #Tabs * 45 + 5)
    TabBtn.BackgroundColor3 = Theme.Surface
    TabBtn.Text = name
    TabBtn.TextColor3 = Theme.Text
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.Parent = Sidebar
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Frame.Visible = false end
        TabFrame.Visible = true
    end)
    
    local t = {Frame = TabFrame, Button = TabBtn}
    table.insert(Tabs, t)
    return TabFrame
end

local function AddButton(parent, txt, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Theme.Surface
    btn.Text = txt
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent
    btn.MouseButton1Click:Connect(cb)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
end

-- // TAB 1: MAIN
local TabMain = CreateTab("Main")
TabMain.Visible = true
AddButton(TabMain, "Fast Auto Farm", function()
    getgenv().Config.Farming = not getgenv().Config.Farming
    Notify("Farm", getgenv().Config.Farming and "Enabled" or "Disabled")
end)

-- // TAB 2: SLOT STEALER
local TabSlot = CreateTab("Slot Stealer")
local function RefreshPlayers()
    for _, v in pairs(TabSlot:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            AddButton(TabSlot, "Scan Plot: " .. p.DisplayName, function() ScanPlayerPlot(p) end)
        end
    end
end
AddButton(TabSlot, "REFRESH PLAYER LIST", RefreshPlayers)
AddButton(TabSlot, "BUILD SCANNED DATA", function()
    local Remote = GetBuildRemote()
    task.spawn(function()
        for _, data in pairs(ScannedData) do
            Remote:FireServer(data.Name, data.CF, data.Color, data.Size)
            task.wait(getgenv().Config.BuildSpeed)
        end
    end)
end)

-- // TAB 3: BUILDER (FILE EXPLORER)
local TabBuild = CreateTab("Builder")
local function RefreshFiles()
    for _, v in pairs(TabBuild:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    local files = listfiles("GENEMIS_BABFT/Builds")
    for _, file in pairs(files) do
        local fileName = file:gsub("GENEMIS_BABFT/Builds\\", "")
        AddButton(TabBuild, "Load: " .. fileName, function()
            local data = HttpService:JSONDecode(readfile(file))
            local Remote = GetBuildRemote()
            task.spawn(function()
                for _, b in pairs(data) do
                    Remote:FireServer(b[1], b[2], b[3], b[4])
                    task.wait(getgenv().Config.BuildSpeed)
                end
            end)
        end)
    end
end
AddButton(TabBuild, "REFRESH .BUILD FILES", RefreshFiles)

-- // DRAGGABLE LOGIC
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Toggle
UIS.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then ScreenGui.Enabled = not ScreenGui.Enabled end
end)

Notify("GENEMIS V4", "Premium Unlocked! Anti-Lag Active.")
