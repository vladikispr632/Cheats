-- ============================================================
-- 🎮 POPULAR GAMES HUB | 20 игр Roblox
-- Полный скрипт в одном файле
-- Игры: Укради Брейнрот, Брокхевен, MM2 (аимбот), Blox Fruits,
-- Adopt Me, Grow a Garden, 99 ночей, Tower of Hell, TSB,
-- RIVALS, Piggy, BedWars, DTI, Evade, PSX, Jailbreak,
-- DOORS, Dandy's World, Blade Ball, Arsenal
-- ============================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

_G.StopAll = false
_G.SelectedGame = "Укради Брейнрот (Steal a Brainrot)"

-- ============================================================
-- ОКНО
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name = "🎮 Popular Games Hub | 20 игр",
    LoadingTitle = "Загрузка хаба...",
    LoadingSubtitle = "by Lua Master",
    ConfigurationSaving = { Enabled = true, FolderName = "PopGamesHub", FileName = "config" }
})

local MainTab = Window:CreateTab("📋 Выбор игры", nil)
local QuickTab = Window:CreateTab("⚡ Быстрые функции", nil)

-- ============================================================
-- СПИСОК 20 ПОПУЛЯРНЫХ ИГР
-- ============================================================
local GameList = {
    "Укради Брейнрот (Steal a Brainrot)",
    "Брокхевен (Brookhaven RP)",
    "Murder Mystery 2",
    "Blox Fruits",
    "Adopt Me!",
    "Grow a Garden",
    "99 ночей в лесу",
    "Tower of Hell",
    "The Strongest Battlegrounds",
    "RIVALS",
    "Piggy",
    "BedWars",
    "Dress To Impress",
    "Evade",
    "Pet Simulator X",
    "Jailbreak",
    "DOORS",
    "Dandy's World",
    "Blade Ball",
    "Arsenal"
}

-- ============================================================
-- ФУНКЦИИ ВСЕХ ИГР
-- ============================================================
local GameFunctions = {}

-- ---------- 1. УКРАДИ БРЕЙНРОТ (прозрачная платформа) ----------
GameFunctions["Укради Брейнрот (Steal a Brainrot)"] = function()
    print("Запуск: Укради Брейнрот")

    local old = workspace:FindFirstChild("BrainrotPlatform")
    if old then old:Destroy() end

    local platform = Instance.new("Part")
    platform.Size = Vector3.new(12, 1, 12)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Transparency = 0.7
    platform.Color = Color3.fromRGB(0, 255, 150)
    platform.Material = Enum.Material.Neon
    platform.Name = "BrainrotPlatform"
    platform.Parent = workspace

    task.spawn(function()
        while platform and platform.Parent and not _G.StopAll do
            task.wait(0.1)
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                platform.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3, hrp.Position.Z)
                platform.CFrame = platform.CFrame * CFrame.new(0, 0.5, 0)
            end
        end
    end)

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 35
    end

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("base") or v.Name:lower():find("wall")) then
            v.Transparency = 0.5
        end
    end
    print("Укради Брейнрот: платформа + скорость + прозрачность баз")
end

-- ---------- 2. БРОКХЕВЕН ----------
GameFunctions["Брокхевен (Brookhaven RP)"] = function()
    print("Запуск: Брокхевен")
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(0, 50, 0) end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
        if char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 100 end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.Parent = plr.Character
        end
    end
    print("Брокхевен: fly + noclip + ESP + скорость")
end

-- ---------- 3. MM2 (АИМБОТ) ----------
GameFunctions["Murder Mystery 2"] = function()
    print("Запуск: MM2 с аимботом")

    local AIM_KEY = Enum.KeyCode.E
    local AIM_SMOOTH = 0.15
    local AIM_FOV = 200
    local aimEnabled = false

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(0, 255, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.Parent = plr.Character
        end
    end

    local function GetClosestTarget()
        local myChar = LocalPlayer.Character
        if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
        local myPos = myChar.HumanoidRootPart.Position
        local closest, closestDist = nil, AIM_FOV
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local dist = (hrp.Position - myPos).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = plr
                    end
                end
            end
        end
        return closest
    end

    local function AimAt(target)
        if not target or not target.Character then return end
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        local myChar = LocalPlayer.Character
        if not targetHRP or not myChar then return end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end
        local targetPos = targetHRP.Position + Vector3.new(0, 2.5, 0)
        local direction = (targetPos - myHRP.Position).Unit
        local lookCFrame = CFrame.new(myHRP.Position, myHRP.Position + direction)
        myHRP.CFrame = myHRP.CFrame:Lerp(lookCFrame, AIM_SMOOTH)
    end

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == AIM_KEY then
            aimEnabled = not aimEnabled
            print("Аимбот:", aimEnabled and "ВКЛ" or "ВЫКЛ")
        end
    end)

    RunService.RenderStepped:Connect(function()
        if aimEnabled and not _G.StopAll then
            local t = GetClosestTarget()
            if t then AimAt(t) end
        end
    end)

    task.spawn(function()
        while task.wait(0.3) and not _G.StopAll do
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("coin") then
                    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then hrp.CFrame = obj.CFrame end
                end
            end
        end
    end)

    RunService.Stepped:Connect(function()
        if _G.StopAll then return end
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
    print("MM2: Аимбот [E] + ESP + авто-монеты + noclip")
end

-- ---------- 4. BLOX FRUITS ----------
GameFunctions["Blox Fruits"] = function()
    print("Запуск: Blox Fruits")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 80
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= LocalPlayer.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 100, 0)
            hl.Parent = obj
        end
    end
    print("Blox Fruits: скорость + ESP врагов")
end

-- ---------- 5. ADOPT ME ----------
GameFunctions["Adopt Me!"] = function()
    print("Запуск: Adopt Me!")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 60
    end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("egg") then
            v.Transparency = 0.5
        end
    end
    print("Adopt Me: скорость + прозрачность яиц")
end

-- ---------- 6. GROW A GARDEN ----------
GameFunctions["Grow a Garden"] = function()
    print("Запуск: Grow a Garden")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
    print("Grow a Garden: скорость")
end

-- ---------- 7. 99 НОЧЕЙ В ЛЕСУ ----------
GameFunctions["99 ночей в лесу"] = function()
    print("Запуск: 99 ночей в лесу")
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(0, 30, 0) end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    print("99 ночей: fly + noclip")
end

-- ---------- 8. TOWER OF HELL ----------
GameFunctions["Tower of Hell"] = function()
    print("Запуск: Tower of Hell")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = 200
    end
    print("Tower of Hell: скорость + прыжок")
end

-- ---------- 9. THE STRONGEST BATTLEGROUNDS ----------
GameFunctions["The Strongest Battlegrounds"] = function()
    print("Запуск: The Strongest Battlegrounds")
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.Parent = plr.Character
        end
    end
    print("TSB: ESP")
end

-- ---------- 10. RIVALS ----------
GameFunctions["RIVALS"] = function()
    print("Запуск: RIVALS")
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 50, 50)
            hl.Parent = plr.Character
        end
    end
    print("RIVALS: ESP")
end

-- ---------- 11. PIGGY ----------
GameFunctions["Piggy"] = function()
    print("Запуск: Piggy")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 60
    end
    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    print("Piggy: скорость + noclip")
end

-- ---------- 12. BEDWARS ----------
GameFunctions["BedWars"] = function()
    print("Запуск: BedWars")
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(0, 255, 255)
            hl.Parent = plr.Character
        end
    end
    print("BedWars: ESP")
end

-- ---------- 13. DRESS TO IMPRESS ----------
GameFunctions["Dress To Impress"] = function()
    print("Запуск: Dress To Impress")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
    print("DTI: скорость")
end

-- ---------- 14. EVADE ----------
GameFunctions["Evade"] = function()
    print("Запуск: Evade")
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(0, 40, 0) end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    print("Evade: fly + noclip")
end

-- ---------- 15. PET SIMULATOR X ----------
GameFunctions["Pet Simulator X"] = function()
    print("Запуск: Pet Simulator X")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 70
    end
    print("PSX: скорость")
end

-- ---------- 16. JAILBREAK ----------
GameFunctions["Jailbreak"] = function()
    print("Запуск: Jailbreak")
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(0, 50, 0) end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    print("Jailbreak: fly + noclip")
end

-- ---------- 17. DOORS ----------
GameFunctions["DOORS"] = function()
    print("Запуск: DOORS")
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 80
    end
    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = false end
    end
    print("DOORS: скорость + noclip")
end

-- ---------- 18. DANDY'S WORLD ----------
GameFunctions["Dandy's World"] = function()
    print("Запуск: Dandy's World")
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(0, 30, 0) end
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 60
        end
    end
    print("Dandy's World: fly + скорость")
end

-- ---------- 19. BLADE BALL ----------
GameFunctions["Blade Ball"] = function()
    print("Запуск: Blade Ball")
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 255, 0)
            hl.Parent = plr.Character
        end
    end
    print("Blade Ball: ESP")
end

-- ---------- 20. ARSENAL ----------
GameFunctions["Arsenal"] = function()
    print("Запуск: Arsenal")
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 0, 255)
            hl.Parent = plr.Character
        end
    end
    print("Arsenal: ESP")
end

-- ============================================================
-- UI ЭЛЕМЕНТЫ (создаём после определения функций)
-- ============================================================
MainTab:CreateDropdown({
    Name = "Выбери игру",
    Options = GameList,
    CurrentOption = _G.SelectedGame,
    Callback = function(Option)
        _G.SelectedGame = Option
        print("Выбрано:", Option)
    end
})

MainTab:CreateButton({
    Name = "▶️ ЗАПУСТИТЬ ФУНКЦИИ ИГРЫ",
    Callback = function()
        local fn = GameFunctions[_G.SelectedGame]
        if fn then fn() else warn("Функция не найдена:", _G.SelectedGame) end
    end
})

MainTab:CreateButton({
    Name = "🛑 ВЫКЛЮЧИТЬ ВСЕ (стоп-кран)",
    Callback = function()
        _G.StopAll = true
        local p = workspace:FindFirstChild("BrainrotPlatform")
        if p then p:Destroy() end
        print("Все функции остановлены")
    end
})

-- ============================================================
-- БЫСТРЫЕ ФУНКЦИИ (отдельная вкладка)
-- ============================================================
QuickTab:CreateButton({
    Name = "🧠 Прозрачная платформа (Brainrot)",
    Callback = function()
        GameFunctions["Укради Брейнрот (Steal a Brainrot)"]()
    end
})

QuickTab:CreateButton({
    Name = "🎯 Аимбот MM2",
    Callback = function()
        GameFunctions["Murder Mystery 2"]()
    end
})

QuickTab:CreateSlider({
    Name = "Скорость",
    Range = {16, 300},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end
})

QuickTab:CreateButton({
    Name = "🚀 Fly (полёт)",
    Callback = function()
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Velocity = Vector3.new(0, 50, 0) end
        end
    end
})

QuickTab:CreateButton({
    Name = "👁 ESP всех игроков",
    Callback = function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hl = Instance.new("Highlight")
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.Parent = plr.Character
            end
        end
    end
})

-- ============================================================
-- ФОНОВЫЕ ЦИКЛЫ
-- ============================================================
-- Анти-АФК
LocalPlayer.Idled:Connect(function()
    local vu = game:GetService("VirtualUser")
    vu:CaptureController()
    vu:ClickButton2(Vector2.new())
end)

-- Сброс скорости при респавне
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end
end)

-- Мониторинг стоп-крана
task.spawn(function()
    while task.wait(1) do
        if _G.StopAll then
            local p = workspace:FindFirstChild("BrainrotPlatform")
            if p then p:Destroy() end
            _G.StopAll = false
        end
    end
end)

print("✅ Хаб загружен! 20 игр готовы.")
print("1. Выбери игру в меню")
print("2. Нажми 'ЗАПУСТИТЬ ФУНКЦИИ ИГРЫ'")
print("3. Для остановки — 'ВЫКЛЮЧИТЬ ВСЕ (стоп-кран)'")
