local oyuncu = game.Players.LocalPlayer

local kupa = workspace.Trophy:WaitForChild("Trophy")
local kullanildiMi = false
local maksimumHiz = 50

local function hiziArttir()
	local anlikHiz = 0
	while kullanildiMi == false do
		wait(1) 
		if oyuncu.Character and oyuncu.Character:FindFirstChild("Humanoid") then
			oyuncu.leaderstats.Hiz.Value += 1
			-- Hızlanmayı 50 ile sınırlandırma
			if oyuncu.leaderstats.Hiz.Value > maksimumHiz then
				oyuncu.leaderstats.Hiz.Value = maksimumHiz
			end

			local humanoid = oyuncu.Character.Humanoid
			anlikHiz = oyuncu.leaderstats.Hiz.Value
			humanoid.WalkSpeed = anlikHiz
		end
	end
end

local function dokunuldugunda(digerNesne)
	local karakter = digerNesne.Parent
	local humanoid = karakter:FindFirstChildWhichIsA("Humanoid")

	if humanoid then
		local dogmaNoktasi = game.Workspace:FindFirstChild("SpawnLocation")
		if dogmaNoktasi then
			karakter.HumanoidRootPart.CFrame = dogmaNoktasi.CFrame + Vector3.new(0,3,0)
		end
		if kullanildiMi == false then
			kullanildiMi = true
			local oyuncu = game.Players:GetPlayerFromCharacter(karakter)
			oyuncu.leaderstats.Kazanananlar.Value += 1 
			oyuncu.leaderstats.Hiz.Value = 14
			wait(2)
			kullanildiMi = false
			hiziArttir()
		end
	end
end

kupa.Touched:Connect(dokunuldugunda())


oyuncu.CharacterAdded:Connect(function(karakter)
	local humanoid = karakter:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		-- Oyuncunun ölümünde hareket hızını 0'a ayarlama
		oyuncu.leaderstats.Hiz.Value = 0
		humanoid.WalkSpeed = 0
	end)
end)

hiziArttir()
