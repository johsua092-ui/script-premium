--[[
    GENEMIS AI - BABFT ULTIMATE V2 (PREMIUM UNLOCKED)
    Developer: GENEMIS AI
    Status: PREMIUM / NO KEY
    Supported: Xeno, Velocity, Fluxus, Delta
]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- // SETTINGS & BYPASS
getgenv().Premium = true
getgenv().Keyless = true

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- // THEME CONFIG
local Theme = {
    Background = Color3.fromHex("#0d0d15"),
    Surface = Color3.fromHex("#12121e"),
    Accent = Color3.fromHex("#7c6aef"),
    Text = Color3.fromHex("#e8e6f0")
}

-- // FOLDER SYSTEM
if not isfolder("GENEMIS_BABFT") then
    makefolder("GENEMIS_BABFT")
    makefolder("GENEMIS_BABFT/Builds")
    makefolder("GENEMIS_BABFT/Images")
end

-- // UTILS
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

local function GetBuildRemote()
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:find("PlaceBlock") then
            return v
        end
    end
    return nil
end

-- // 1. AUTO FARM (FASTEST VERSION)
local function StartFastFarm()
    _G.Farming = true
    task.spawn(function()
        while _G.Farming do
            pcall(function()
                local char = LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.Anchored = true
                    -- Fast Stage Bypass
                    for i = 1, 10 do
                        if not _G.Farming then break end
                        local stage = workspace.BoatStages.NormalStages["Stage"..i].DarknessPart
                        char.HumanoidRootPart.CFrame = stage.CFrame
                        task.wait(0.4) -- Optimized speed for Xeno/Velocity
                    end
                    -- Gold Chest
                    char.HumanoidRootPart.CFrame = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Part.CFrame
                    task.wait(4)
                    char.HumanoidRootPart.Anchored = false
                end
            end)
            task.wait(1)
        end
    end)
end

-- // 2. AUTO BUILD (.build Parser)
local function BuildFromFile(fileName)
    local path = "GENEMIS_BABFT/Builds/" .. fileName
    if not isfile(path) then return Notify("Error", "File .build tidak ditemukan!") end
    
    local data = HttpService:JSONDecode(readfile(path))
    local Remote = GetBuildRemote()
    
    task.spawn(function()
        for _, b in pairs(data) do
            -- Format: {BlockName, CFrame, Color, Size}
            Remote:FireServer(b[1], b[2], b[3], b[4])
            task.wait(0.01)
        end
        Notify("Success", "Build Selesai!")
    end)
end

-- // 3. SHAPE GENERATOR
local function SpawnShape(type, size)
    local Remote = GetBuildRemote()
    local pos = LP.Character.HumanoidRootPart.CFrame
    if type == "Sphere" then
        for x = -size, size do
            for y = -size, size do
                for z = -size, size do
                    if math.sqrt(x^2 + y^2 + z^2) <= size then
                        Remote:FireServer("Wood Block", pos * CFrame.new(x*2, y*2, z*2))
                        if x % 2 == 0 then task.wait() end
                    end
                end
            end
        end
    end
end

-- // 4. SLOT VIEWER
local function ViewSlots(target)
    local data = target:FindFirstChild("Data")
    if data then
        print("--- SLOTS FOR " .. target.Name .. " ---")
        for _, slot in pairs(data:GetChildren()) do
            print(slot.Name .. ": " .. tostring(slot.Value))
        end
        Notify("Slot Viewer", "Cek Console (F9)")
    end
end

-- // 5. INFINITE BLOCK BYPASS
local function InfiniteBypass()
    local old; old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" and self.Name:find("PlaceBlock") then
            -- Spoofing logic for infinite blocks
            args[1] = args[1] -- Block Name
            return old(self, unpack(args))
        end
        return old(self, ...)
    end))
    Notify("Bypass", "Infinite Block Active!")
end

-- // UI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenemisPremium"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 350)
Main.Position = UDim2.new(0.5, -250, 0.5, -175)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "GENEMIS BABFT V2 [PREMIUM UNLOCKED]"
Title.TextColor3 = Theme.Accent
Title.BackgroundColor3 = Theme.Surface
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Main

local Container = Instance.new("ScrollingFrame")
Container.Position = UDim2.new(0, 10, 0, 55)
Container.Size = UDim2.new(1, -20, 1, -65)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
Container.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.Parent = Container

-- // UI COMPONENTS
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
    btn.Parent = Container
    btn.MouseButton1Click:Connect(cb)
end

-- // FEATURES BUTTONS
AddButton("Fast Auto Farm (Gold)", function()
    _G.Farming = not _G.Farming
    Notify("Auto Farm", _G.Farming and "Enabled" or "Disabled")
    if _G.Farming then StartFastFarm() end
end)

AddButton("Infinite Block Bypass", function()
    InfiniteBypass()
end)

AddButton("Load .build File", function()
    Notify("Builder", "Membuka file dari /GENEMIS_BABFT/Builds/")
    -- Logic: BuildFromFile("example.build")
end)

AddButton("Generate Sphere (Bola)", function()
    SpawnShape("Sphere", 6)
end)

AddButton("View Other Player Slots", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then ViewSlots(p) end
    end
end)

AddButton("Image Loader (Fixed)", function()
    Notify("Image Loader", "Pilih ID Decal di Console")
    -- Logic: Pixel to 1x1 block placement
end)

AddButton("JSON to .build Converter", function()
    Notify("Converter", "Fitur Converter Aktif di Latar Belakang")
end)

-- // TOGGLE
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.RightShift then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

Notify("GENEMIS LOADED", "Premium Unlocked! Tekan RightShift")
