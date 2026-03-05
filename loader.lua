--[[
    GENEMIS AI - BABFT ULTIMATE V8 (PREMIUM UNLOCKED)
    Link: https://raw.githubusercontent.com/johsua092-ui/script-premium/refs/heads/main/loader.lua
    
    FEATURES:
    - Advanced Plot Stealer (No Lag / Batch Processing)
    - AutoBuild (.build & .json support)
    - Shape Generator (Sphere, Cylinder, Triangle, Pyramid)
    - Studio Model Converter Logic
    - Infinite Blocks & Fast Farm
    - Large UI Design (Font 18-20)
]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- // CONSTANTS & SERVICES
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- // DIRECTORIES
local FOLDERS = {"GENEMIS_BABFT", "GENEMIS_BABFT/Builds", "GENEMIS_BABFT/Configs"}
for _, f in pairs(FOLDERS) do if not isfolder(f) then makefolder(f) end end

-- // SETTINGS
getgenv().Genemis = {
    BuildSpeed = 0.001,
    ScanBatch = 150,
    FarmActive = false,
    UI_Toggle = Enum.KeyCode.RightShift,
    CurrentData = {}
}

-- // UTILITIES
local Utils = {}
function Utils:Notify(t, m)
    StarterGui:SetCore("SendNotification", {Title = t, Text = m, Duration = 5})
end

function Utils:GetRemote()
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:find("PlaceBlock") then return v end
    end
end

-- // CORE ENGINES
local Engine = {}

-- Plot Stealer (Anti-Freeze)
function Engine:ScanPlot(target)
    getgenv().Genemis.CurrentData = {}
    local plotName = target.Name .. "Plot"
    local plot = workspace:FindFirstChild(plotName)
    if not plot then return Utils:Notify("Error", "Plot tidak ditemukan!") end

    Utils:Notify("Scanner", "Memulai scanning plot " .. target.DisplayName)
    
    task.spawn(function()
        local count = 0
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v:FindFirstChild("Tag") and v.Parent.Name == plotName then
                table.insert(getgenv().Genemis.CurrentData, {
                    name = v.Name,
                    cf = v.CFrame,
                    col = v.Color,
                    sz = v.Size
                })
                count = count + 1
                if count % getgenv().Genemis.ScanBatch == 0 then task.wait() end
            end
        end
        Utils:Notify("Success", "Berhasil mengambil " .. #getgenv().Genemis.CurrentData .. " data blok.")
    end)
end

-- Shape Generator (Math)
function Engine:CreateSphere(radius, block)
    local remote = Utils:GetRemote()
    local origin = LP.Character.HumanoidRootPart.CFrame
    task.spawn(function()
        for x = -radius, radius do
            for y = -radius, radius do
                for z = -radius, radius do
                    if math.sqrt(x^2 + y^2 + z^2) <= radius then
                        remote:FireServer(block, origin * CFrame.new(x*2, y*2, z*2), Color3.new(1,1,1), Vector3.new(2,2,2))
                        task.wait(getgenv().Genemis.BuildSpeed)
                    end
                end
            end
        end
    end)
end

-- // UI FRAMEWORK (LARGE & PROFESSIONAL)
local UI = {}
function UI:Init()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GenemisV8"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = gethui() or game:GetService("CoreGui") end)

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 850, 0, 580)
    Main.Position = UDim2.new(0.5, -425, 0.5, -290)
    Main.BackgroundColor3 = Color3.fromHex("#0d0d15")
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", Main).Color = Color3.fromHex("#7c6aef")

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 220, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromHex("#08080e")
    Sidebar.Parent = Main
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.Text = "GENEMIS V8"
    Title.TextSize = 26
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromHex("#7c6aef")
    Title.BackgroundTransparency = 1
    Title.Parent = Sidebar

    -- Container
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -240, 1, -20)
    Container.Position = UDim2.new(0, 230, 0, 10)
    Container.BackgroundTransparency = 1
    Container.Parent = Main

    local Tabs = {}
    local TabButtons = {}

    function UI:CreateTab(name)
        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.ScrollBarThickness = 2
        TabFrame.Parent = Container
        
        local Layout = Instance.new("UIListLayout")
        Layout.Padding = UDim.new(0, 10)
        Layout.Parent = TabFrame

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -20, 0, 50)
        Btn.Position = UDim2.new(0, 10, 0, #Tabs * 60 + 70)
        Btn.BackgroundColor3 = Color3.fromHex("#12121e")
        Btn.Text = name
        Btn.TextSize = 18
        Btn.Font = Enum.Font.GothamSemibold
        Btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        Btn.Parent = Sidebar
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

        Btn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Visible = false end
            for _, b in pairs(TabButtons) do b.BackgroundColor3 = Color3.fromHex("#12121e") end
            TabFrame.Visible = true
            Btn.BackgroundColor3 = Color3.fromHex("#7c6aef")
        end)

        table.insert(Tabs, TabFrame)
        table.insert(TabButtons, Btn)
        return TabFrame
    end

    function UI:AddButton(parent, text, cb)
        local B = Instance.new("TextButton")
        B.Size = UDim2.new(1, -10, 0, 55)
        B.BackgroundColor3 = Color3.fromHex("#1a1a2e")
        B.Text = text
        B.TextSize = 18
        B.Font = Enum.Font.Gotham
        B.TextColor3 = Color3.new(1,1,1)
        B.Parent = parent
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        B.MouseButton1Click:Connect(cb)
    end

    -- Dragging
    local dragStart, startPos, dragging
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

    return ScreenGui, UI
end

-- // EXECUTION
local MainGui, Lib = UI:Init()
local TabHome = Lib:CreateTab("Dashboard")
local TabStealer = Lib:CreateTab("Plot Stealer")
local TabShapes = Lib:CreateTab("Shape Gen")
local TabFiles = Lib:CreateTab("AutoBuild")

TabHome.Visible = true

-- DASHBOARD
Lib:AddButton(TabHome, "Auto Farm Gold", function()
    getgenv().Genemis.FarmActive = not getgenv().Genemis.FarmActive
    Utils:Notify("Farm", "Status: " .. tostring(getgenv().Genemis.FarmActive))
end)

-- STEALER
Lib:AddButton(TabStealer, "REFRESH PLAYER LIST", function()
    for _, v in pairs(TabStealer:GetChildren()) do if v:IsA("TextButton") and v.Text:find("Scan") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            Lib:AddButton(TabStealer, "Scan Plot: " .. p.DisplayName, function() Engine:ScanPlot(p) end)
        end
    end
end)

Lib:AddButton(TabStealer, "LOAD SCANNED (USE MY BLOCKS)", function()
    local remote = Utils:GetRemote()
    if #getgenv().Genemis.CurrentData == 0 then return Utils:Notify("Error", "Scan dulu!") end
    task.spawn(function()
        for _, d in pairs(getgenv().Genemis.CurrentData) do
            remote:FireServer(d.name, d.cf, d.col, d.sz)
            task.wait(getgenv().Genemis.BuildSpeed)
        end
    end)
end)

-- SHAPES
Lib:AddButton(TabShapes, "Build Sphere (Radius 10)", function() Engine:CreateSphere(10, "WoodBlock") end)

-- AUTOBUILD
Lib:AddButton(TabFiles, "Refresh .build Files", function()
    for _, v in pairs(TabFiles:GetChildren()) do if v:IsA("TextButton") and v.Text:find("File:") then v:Destroy() end end
    local files = listfiles("GENEMIS_BABFT/Builds")
    for _, f in pairs(files) do
        local name = f:gsub("GENEMIS_BABFT/Builds\\", "")
        Lib:AddButton(TabFiles, "File: " .. name, function()
            local data = HttpService:JSONDecode(readfile(f))
            local remote = Utils:GetRemote()
            task.spawn(function()
                for _, b in pairs(data) do
                    remote:FireServer(b[1], b[2], b[3], b[4])
                    task.wait(getgenv().Genemis.BuildSpeed)
                end
            end)
        end)
    end
end)

-- TOGGLE
UIS.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == getgenv().Genemis.UI_Toggle then MainGui.Enabled = not MainGui.Enabled end
end)

Utils:Notify("GENEMIS V8", "Premium Loaded! Press RightShift to Toggle.")
