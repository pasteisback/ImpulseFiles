local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local AimlockEnabled = true
local Smoothness = 6

local function GetNearestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local Head = player.Character.Head
            local HeadPosition, onScreen = workspace.CurrentCamera:WorldToScreenPoint(Head.Position)
            
            if onScreen then
                local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(HeadPosition.X, HeadPosition.Y)).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = Head
                end
            end
        end
    end

    return closestPlayer
end

local function step()
    if AimlockEnabled then
        local TargetHead = GetNearestPlayer()
        if TargetHead then
            local TargetPos = workspace.CurrentCamera:WorldToScreenPoint(TargetHead.Position)
            local AimPosition = Vector2.new(TargetPos.X, TargetPos.Y)
            mousemoverel((AimPosition.X - Mouse.X) / Smoothness, (AimPosition.Y - Mouse.Y) / Smoothness)
        end
    end
end

RunService.RenderStepped:Connect(step)
