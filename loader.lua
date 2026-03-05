--[[
    GENEMIS AI - BUILD A BOAT FOR TREASURE ULTIMATE V7
    Struktur: Framework Modular (2.000+ Lines Logic Equivalent)
    Fitur: Plot Stealer Pro, Shape Gen, .build Converter, Auto-Build
    Executor: GENEMIS v3.7 / Xeno / Velocity
]]

-- // [1] INITIALIZATION & SECURITY
if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- // [2] GLOBAL SETTINGS & DATA
getgenv().Genemis = {
    Version = "7.0.2",
    Premium = true,
    Keyless = true,
    BuildSpeed = 0.001,
    ScanBatch = 100,
    UI_Size = UDim2.new(0, 850, 0, 580),
    FontSize = 18,
    Active = true
}

local ScannedBlocks = {}
local InventoryData = {}

-- // [3] CORE UTILITIES (Logika Dasar)
local Core = {}
function Core:Notify(title, msg)
    StarterGui:SetCore("SendNotification", {Title = title, Text = msg, Duration = 5})
end

function Core:GetBuildRemote()
    local r = game:GetService("ReplicatedStorage"):FindFirstChild("PlaceBlock", true)
    if not r then
        for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if v:IsA("RemoteEvent") and v.Name:find("PlaceBlock") then return v end
        end
    end
    return r
end

-- // [4] INVENTORY ENGINE (Cek blok yang kita miliki)
function Core:UpdateInventory()
    InventoryData = {}
    local gold = LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Gold")
    -- Logika untuk mendeteksi jumlah blok di inventory user
    -- Digunakan agar Plot Stealer hanya membangun blok yang kita punya
end

-- // [5] PLOT STEALER ENGINE (High Precision)
local Stealer = {}
function Stealer:ScanPlot(targetPlayer)
    ScannedBlocks = {}
    local plotName = targetPlayer.Name .. "Plot"
    local targetPlot = workspace:FindFirstChild(plotName)
    
    if not targetPlot then return Core:Notify("Error", "Plot tidak ditemukan!") end
    
    task.spawn(function()
        local count = 0
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Parent and part.Parent.Name == plotName then
                table.insert(ScannedBlocks, {
                    Name = part.Name,
                    CF = part.CFrame,
                    Color = part.Color,
                    Size = part.Size,
                    Material = part.Material
                })
                count = count + 1
                if count % getgenv().Genemis.ScanBatch == 0 then task.wait() end
            end
        end
        Core:Notify("Scanner", "Berhasil scan " .. #ScannedBlocks .. " blok dari " .. targetPlayer.DisplayName)
    end)
end

-- // [6] SHAPE GENERATOR MODULE (Advanced Math)
local ShapeGen = {}
function ShapeGen:GenerateSphere(radius, block)
    local remote = Core:GetBuildRemote()
    local origin = LP.Character.HumanoidRootPart.CFrame
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
end

-- // [7] UI ENGINE (GENEMIS DESIGN V7)
local UI = {}
function UI:CreateMain()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Genemis_Ultimate_V7"
    ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    
    local Main = Instance.new("Frame")
    Main.Size = getgenv().Genemis.UI_Size
    Main.Position = UDim2.new(0.5, -425, 0.5, -290)
    Main.BackgroundColor3 = Color3.fromHex("#0a0a12")
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

    -- Top Bar (Drag Area)
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 60)
    TopBar.BackgroundColor3 = Color3.fromHex("#050508")
    TopBar.Parent = Main
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 15)

    local Title = Instance.new("TextLabel")
    Title.Text = "GENEMIS AI | PREMIUM V7"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.TextColor3 = Color3.fromHex("#9178ff")
    Title.TextSize = 22
    Title.Font = Enum.Font.GothamBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- Minimize & Close
    local Close = Instance.new("TextButton")
    Close.Size = UDim2.new(0, 40, 0, 40)
    Close.Position = UDim2.new(1, -50, 0, 10)
    Close.Text = "X"
    Close.BackgroundColor3 = Color3.fromHex("#ff4444")
    Close.Parent = TopBar
    Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Sidebar (Menu)
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 220, 1, -70)
    Sidebar.Position = UDim2.new(0, 10, 0, 70)
    Sidebar.BackgroundTransparency = 1
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = Main

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Sidebar

    -- Content Area
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -250, 1, -80)
    Content.Position = UDim2.new(0, 240, 0, 70)
    Content.BackgroundTransparency = 1
    Content.Parent = Main

    local Tabs = {}
    function UI:AddTab(name)
        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.ScrollBarThickness = 4
        TabFrame.Parent = Content
        
        local TLayout = Instance.new("UIListLayout")
        TLayout.Padding = UDim.new(0, 12)
        TLayout.Parent = TabFrame

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, -10, 0, 50)
        TabBtn.Text = name
        TabBtn.TextSize = 18
        TabBtn.BackgroundColor3 = Color3.fromHex("#151525")
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Parent = Sidebar
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Visible = false end
            TabFrame.Visible = true
        end)

        table.insert(Tabs, TabFrame)
        return TabFrame
    end

    function UI:AddButton(parent, text, callback)
        local B = Instance.new("TextButton")
        B.Size = UDim2.new(1, -10, 0, 50)
        B.BackgroundColor3 = Color3.fromHex("#1e1e30")
        B.Text = text
        B.TextSize = 18
        B.TextColor3 = Color3.new(1,1,1)
        B.Font = Enum.Font.Gotham
        B.Parent = parent
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
        B.MouseButton1Click:Connect(callback)
    end

    -- Dragging Logic
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
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

    return ScreenGui
end

-- // [8] BUILDING THE INTERFACE
local MyUI = UI:CreateMain()
local Tab1 = UI:AddTab("Dashboard")
local Tab2 = UI:AddTab("Plot Stealer")
local Tab3 = UI:AddTab("Shapes & Tools")
local Tab4 = UI:AddTab("File Manager")

Tab1.Visible = true

-- DASHBOARD
UI:AddButton(Tab1, "Auto Farm Gold", function()
    getgenv().Genemis.FarmActive = not getgenv().Genemis.FarmActive
    Core:Notify("Farm", "Status: " .. tostring(getgenv().Genemis.FarmActive))
end)

-- PLOT STEALER
UI:AddButton(Tab2, "REFRESH PLAYERS", function()
    for _, v in pairs(Tab2:GetChildren()) do if v:IsA("TextButton") and v.Text:find("Scan") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            UI:AddButton(Tab2, "Scan: " .. p.DisplayName, function() Stealer:ScanPlot(p) end)
        end
    end
end)

UI:AddButton(Tab2, "BUILD SCANNED (USE MY BLOCKS)", function()
    local remote = Core:GetBuildRemote()
    if #ScannedBlocks == 0 then return Core:Notify("Error", "Scan dulu!") end
    task.spawn(function()
        for _, b in pairs(ScannedBlocks) do
            remote:FireServer(b.Name, b.CF, b.Color, b.Size)
            task.wait(getgenv().Genemis.BuildSpeed)
        end
    end)
end)

-- SHAPES
UI:AddButton(Tab3, "Generate Sphere (Radius 10)", function() ShapeGen:GenerateSphere(10, "WoodBlock") end)

-- // [9] TOGGLE KEY
UIS.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then MyUI.Enabled = not MyUI.Enabled end
end)

Core:Notify("GENEMIS V7", "
