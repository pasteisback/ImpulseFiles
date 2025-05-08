local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera

local active = true

local targetPlayer = nil

local function visiPLR(player)
    local character = player.Character
    if not character then return false end

    local head = character:FindFirstChild("Head")
    if not head then return false end

    local origin = mouse.UnitRay.Origin
    local direction = (head.Position - origin).Unit
    local distance = (head.Position - origin).Magnitude

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local raycastResult = workspace:Raycast(origin, direction * distance, raycastParams)

    if raycastResult and raycastResult.Instance:IsDescendantOf(character) then
        return true
    end

    return false
end

mouse.Move:Connect(function()
    if not active then
        targetPlayer = nil
        return
    end

    local target = mouse.Target
    local player = nil

    if target and target.Parent and target.Parent:IsA("Model") then
        player = Players:GetPlayerFromCharacter(target.Parent)
    end

    if player and player ~= lp and visiPLR(player) then
        targetPlayer = player
    else
        targetPlayer = nil
    end
end)

RunService.Heartbeat:Connect(function()
    if active and targetPlayer then
        mouse1press()
       mouse1release()
    end
end)
