-- Load the Venyx UI Library
local VenyxLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Library.lua"))()
local Venyx = VenyxLibrary.new("Universal Vehicle Script", 5013109572)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Local Player
local LocalPlayer = Players.LocalPlayer

-- Theme Configuration
local Theme = {
    Background = Color3.fromRGB(61, 60, 124),
    Glow = Color3.fromRGB(60, 63, 221),
    Accent = Color3.fromRGB(55, 52, 90),
    LightContrast = Color3.fromRGB(64, 65, 128),
    DarkContrast = Color3.fromRGB(32, 33, 64),
    TextColor = Color3.fromRGB(255, 255, 255)
}

-- Apply Theme
for index, value in pairs(Theme) do
    pcall(Venyx.setTheme, Venyx, index, value)
end

-- Function to Get Vehicle from Descendant
local function GetVehicleFromDescendant(Descendant)
    return Descendant:FindFirstAncestor(LocalPlayer.Name .. "'s Car")
        or (Descendant:FindFirstAncestor("Body") and Descendant:FindFirstAncestor("Body").Parent)
        or (Descendant:FindFirstAncestor("Misc") and Descendant:FindFirstAncestor("Misc").Parent)
        or Descendant:FindFirstAncestorWhichIsA("Model")
end

-- Function to Teleport Vehicle
local function TeleportVehicle(CoordinateFrame)
    local Parent = LocalPlayer.Character.Parent
    local Vehicle = GetVehicleFromDescendant(LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").SeatPart)
    LocalPlayer.Character.Parent = Vehicle
    local success, response = pcall(function()
        return Vehicle:SetPrimaryPartCFrame(CoordinateFrame)
    end)
    if not success then
        return Vehicle:MoveTo(CoordinateFrame.Position)
    end
end

-- Vehicle Page
local vehiclePage = Venyx:addPage("Vehicle", 8356815386)

-- Usage Section
local usageSection = vehiclePage:addSection("Usage")
local velocityEnabled = true
usageSection:addToggle("Keybinds Active", velocityEnabled, function(v)
    velocityEnabled = v
end)

-- Flight Section
local flightSection = vehiclePage:addSection("Flight")
local flightEnabled = false
local flightSpeed = 1
flightSection:addToggle("Enabled", false, function(v)
    flightEnabled = v
end)
flightSection:addSlider("Speed", 100, 0, 800, function(v)
    flightSpeed = v / 100
end)

-- Flight Keybind
local flightToggleKeyCode = Enum.KeyCode.F
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == flightToggleKeyCode then
        flightEnabled = not flightEnabled
    end
end)

-- Default Character Parent
local defaultCharacterParent
RunService.Stepped:Connect(function()
    local Character = LocalPlayer.Character
    if flightEnabled then
        if Character and typeof(Character) == "Instance" then
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
            if Humanoid and typeof(Humanoid) == "Instance" then
                local SeatPart = Humanoid.SeatPart
                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                    local Vehicle = GetVehicleFromDescendant(SeatPart)
                    if Vehicle and Vehicle:IsA("Model") then
                        Character.Parent = Vehicle
                        if not Vehicle.PrimaryPart then
                            if SeatPart.Parent == Vehicle then
                                Vehicle.PrimaryPart = SeatPart
                            else
                                Vehicle.PrimaryPart = Vehicle:FindFirstChildWhichIsA("BasePart")
                            end
                        end
                        local PrimaryPartCFrame = Vehicle:GetPrimaryPartCFrame()
                        Vehicle:SetPrimaryPartCFrame(
                            CFrame.new(PrimaryPartCFrame.Position, PrimaryPartCFrame.Position + workspace.CurrentCamera.CFrame.LookVector)
                            * (UserInputService:GetFocusedTextBox() and CFrame.new(0, 0, 0) or CFrame.new(
                                (UserInputService:IsKeyDown(Enum.KeyCode.D) and flightSpeed) or (UserInputService:IsKeyDown(Enum.KeyCode.A) and -flightSpeed) or 0,
                                (UserInputService:IsKeyDown(Enum.KeyCode.E) and flightSpeed / 2) or (UserInputService:IsKeyDown(Enum.KeyCode.Q) and -flightSpeed / 2) or 0,
                                (UserInputService:IsKeyDown(Enum.KeyCode.S) and flightSpeed) or (UserInputService:IsKeyDown(Enum.KeyCode.W) and -flightSpeed) or 0
                            ))
                        )
                        SeatPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        SeatPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    else
        if Character and typeof(Character) == "Instance" then
            Character.Parent = defaultCharacterParent or Character.Parent
            defaultCharacterParent = Character.Parent
        end
    end
end)

-- Speed Section
local speedSection = vehiclePage:addSection("Acceleration")
local velocityMult = 0.025
speedSection:addSlider("Multiplier (Thousandths)", 25, 0, 50, function(v)
    velocityMult = v / 1000
end)

-- Velocity Enabled Keybind
local velocityEnabledKeyCode = Enum.KeyCode.R
speedSection:addKeybind("Velocity Enabled", velocityEnabledKeyCode, function()
    if not velocityEnabled then return end
    while UserInputService:IsKeyDown(velocityEnabledKeyCode) do
        task.wait(0)
        local Character = LocalPlayer.Character
        if Character and typeof(Character) == "Instance" then
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
            if Humanoid and typeof(Humanoid) == "Instance" then
                local SeatPart = Humanoid.SeatPart
                if SeatPart and typeof(SeatPart) == "Instance" and SeatPart:IsA("VehicleSeat") then
                    Seat
::contentReference[oaicite:0]{index=0}
 
