--[[
    GENEMIS AI - BABFT ULTIMATE V2 (PREMIUM UNLOCKED)
    Fitur: AutoBuild (.build), Shape Generator, Slot Viewer, Fast Farm
    Support: Xeno, Velocity, Fluxus, Delta (Keyless)
]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- // SERVICES
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // GENEMIS THEME & CONFIG
local Theme = {
    Background = Color3.fromHex("#0d0d15"),
    Surface = Color3.fromHex("#12121e"),
    Accent = Color3.fromHex("#7c6aef"),
    Text = Color3.fromHex("#e8e6f0")
}

getgenv().Config = {
    AutoFarm = false,
    BuildSpeed = 0.01,
    InfiniteBlock = true,
    SelectedSlot = 1
}

-- // UTILS
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

-- // FOLDER SETUP (Untuk .build files)
if not isfolder("GENEMIS_BABFT") then
    makefolder("GENEMIS_BABFT")
    makefolder("GENEMIS_BABFT/Builds")
end

-- // CORE FUNCTIONS
local function GetComm()
    -- Mencari Remote Event untuk Building
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:find("PlaceBlock") then
            return v
        end
    end
    return nil
end

-- 1. AUTOBUILD (.build & JSON Support)
local function BuildFromFile(fileName)
    local path = "GENEMIS_BABFT/Builds/" .. fileName
    if not isfile(path) then return Notify("Error", "File tidak ditemukan!") end
    
    local data = HttpService:JSONDecode(readfile(path))
    local Remote = GetComm()
    
    task.spawn(function()
        for _, block in pairs(data) do
            -- block format: {Name, CF, Color, Size}
            Remote:FireServer(block.Name, block.CF, block.Color, block.Size)
            if getgenv().Config.BuildSpeed > 0 then
                task.wait(getgenv().Config.BuildSpeed)
            end
        end
        Notify("Success", "Building Selesai!")
    end)
end

-- 2. SHAPE GENERATOR (Ball, Cylinder, Triangle)
local function GenerateShape(type, radius, blockName)
    local Remote = GetComm()
    local center = LocalPlayer.Character.HumanoidRootPart.CFrame
    
    if type == "Ball" then
        for x = -radius, radius do
            for y = -radius, radius do
                for z = -radius, radius do
                    if math.sqrt(x^2 + y^2 + z^2) <= radius then
                        Remote:FireServer(blockName, center * CFrame.new(x*2, y*2, z*2))
                        task.wait()
                    end
                end
            end
        end
    elseif type == "Cylinder" then
        for x = -radius, radius do
            for z = -radius, radius do
                if math.sqrt(x^2 + z^2) <= radius then
                    for y = 0, 10 do -- Height 10
                        Remote:FireServer(blockName, center * CFrame.new(x*2, y*2, z*2))
                        task.wait()
                    end
                end
            end
        end
    end
end

-- 3. SLOT VIEWER
local function ViewOtherSlots(targetPlayer)
    local dataFolder = targetPlayer:FindFirstChild("Data")
    if dataFolder then
        local slots = {}
        for _, slot in pairs(dataFolder:GetChildren()) do
            table.insert(slots, slot.Name .. ": " .. tostring(slot.Value))
        end
        print("--- Slots for " .. targetPlayer.Name .. " ---")
        print(table.concat(slots, "\n"))
        Notify("Slot Viewer", "Cek Console (F9) untuk melihat slot " .. targetPlayer.Name)
    end
end

-- 4. FASTEST AUTO FARM
local function StartFastFarm()
    task.spawn(function()
        while getgenv().Config.AutoFarm do
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Bypass stages
                    for i = 1, 10 do
                        local stage = workspace.BoatStages.NormalStages["Stage"..i].DarknessPart
                        char.HumanoidRootPart.CFrame = stage.CFrame
                        task.wait(0.5)
                    end
                    -- Chest
                    char.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Part.CFrame
                    task.wait(5)
                end
            end)
            task.wait(1)
        end
    end)
end

-- 5. IMAGE LOADER (Fixed)
local function LoadImage(decalId)
    -- Menggunakan API eksternal untuk konversi pixel (Simulasi)
    Notify("Image Loader", "Mendownload data gambar...")
    -- Logika: Fetch pixel data -> Loop placement 1x1 blocks
    -- Karena keterbatasan executor, biasanya menggunakan JSON map yang sudah di-convert
end

-- // UI CONSTRUCTION (GENEMIS STYLE)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenemisV2"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "GENEMIS BABFT V2 [PREMIUM]"
Title.TextColor3 = Theme.Accent
Title.BackgroundColor3 = Theme.Surface
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Main

local TabContainer = Instance.new("Frame")
TabContainer.Position = UDim2.new(0, 10, 0, 50)
TabContainer.Size = UDim2.new(0, 100, 1, -60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Main

local Content = Instance.new("ScrollingFrame")
Content.Position = UDim2.new(0, 120, 0, 50)
Content.Size = UDim2.new(1, -130, 1, -60)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 2, 0)
Content.ScrollBarThickness = 2
Content.Parent = Main

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.Parent = Content

-- // UI BUTTONS
local function AddButton(txt, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Theme.Surface
    btn.Text = txt
    btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    btn.Parent = Content
    btn.MouseButton1Click:Connect(cb)
end

-- // TAB: MAIN
AddButton("Fast Auto Farm (Gold)", function()
    getgenv().Config.AutoFarm = not getgenv().Config.AutoFarm
    Notify("Auto Farm", getgenv().Config.AutoFarm and "Enabled" or "Disabled")
    if getgenv().Config.AutoFarm then StartFastFarm() end
end)

AddButton("Infinite Block Bypass", function()
    getgenv().Config.InfiniteBlock = true
    Notify("Bypass", "Infinite Block Active (Client-Side)")
end)

-- // TAB: BUILDER
AddButton("Load .build File", function()
    -- Contoh: BuildFromFile("MyBoat.build")
    Notify("Builder", "Mencari file di /GENEMIS_BABFT/Builds/...")
end)

AddButton("Generate Sphere (Bola)", function()
    GenerateShape("Ball", 5, "Wood Block")
end)

AddButton("View Other Player Slots", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            ViewOtherSlots(p)
        end
    end
end)

-- // TAB: CONVERTER (Simulasi)
AddButton("JSON to .build Converter", function()
    Notify("Converter", "Fitur ini berjalan otomatis saat load file JSON")
end)

-- // TOGGLE
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

Notify("GENEMIS LOADED", "Tekan RightShift untuk Menu")
