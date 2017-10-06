--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

util.AddNetworkString( "getMoneyPrintMenu" )

util.AddNetworkString( "upgradeCPU" )
net.Receive( "upgradeCPU", function( len, ply )
	local mp = net.ReadEntity()
	local cost = mp:GetNWInt( "cpu" ) * mp:GetNWInt( "cpuCost" )
	if ply:canAfford( cost ) and mp:GetNWInt( "cpu" ) < mp:GetNWInt( "cpuMax" ) then
		ply:addMoney( -cost )
		mp:SetNWInt( "cpu", mp:GetNWInt( "cpu" ) + 1 )

		mp.delay = CurTime()
	end
end)

util.AddNetworkString( "upgradeCooler" )
net.Receive( "upgradeCooler", function( len, ply )
	local mp = net.ReadEntity()
	local cost = mp:GetNWInt( "cooler" ) * mp:GetNWInt( "coolerCost" )
	if ply:canAfford( cost ) and mp:GetNWInt( "cooler" ) < mp:GetNWInt( "coolerMax" ) then
		ply:addMoney( -cost )
		mp:SetNWInt( "cooler", mp:GetNWInt( "cooler" ) + 1 )

		mp.delay = CurTime()
	end
end)

util.AddNetworkString( "upgradePrinter" )
net.Receive( "upgradePrinter", function( len, ply )
	local mp = net.ReadEntity()
	local cost = mp:GetNWInt( "printer" ) * mp:GetNWInt( "printerCost" )
	if ply:canAfford( cost ) and mp:GetNWInt( "printer" ) < mp:GetNWInt( "printerMax" ) then
		ply:addMoney( -cost )
		mp:SetNWInt( "printer", mp:GetNWInt( "printer" ) + 1 )
	end
end)

util.AddNetworkString( "upgradeStorage" )
net.Receive( "upgradeStorage", function( len, ply )
	local mp = net.ReadEntity()
	local cost = mp:GetNWInt( "storage" ) * mp:GetNWInt( "storageCost" )
	if ply:canAfford( cost ) and mp:GetNWInt( "storage" ) < mp:GetNWInt( "storageMax" ) then
		ply:addMoney( -cost )
		mp:SetNWInt( "storage", mp:GetNWInt( "storage" ) + 1 )
		mp:SetNWInt( "moneyMax", mp:GetNWInt( "moneyMax" ) + 1000 )
	end
end)

util.AddNetworkString( "withdrawMoney" )
net.Receive( "withdrawMoney", function( len, ply )
	local mp = net.ReadEntity()
	local withdraw = mp:GetNWInt( "money" )

	ply:addMoney( withdraw )

	mp:SetNWInt( "money", 0 )
end)

function ENT:Initialize()
	self:SetModel( "models/props_c17/consolebox01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

  local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end


	self:SetNWInt( "cpu", 1 )
	self:SetNWInt( "cpuMax", 10 )
	self:SetNWInt( "cpuCost", 200 )

	self:SetNWInt( "cooler", 1 )
	self:SetNWInt( "coolerMax", 4 )
	self:SetNWInt( "coolerCost", 50 )

	self:SetNWInt( "printer", 1 )
	self:SetNWInt( "printerMax", 5 )
	self:SetNWInt( "printerCost", 80 )

	self:SetNWInt( "storage", 1 )
	self:SetNWInt( "storageMax", 6 )
	self:SetNWInt( "storageCost", 100 )

	self:SetNWInt( "money", 0 )
	self:SetNWInt( "moneyMax", 1000 )

	self.delay = CurTime()
	self.countdown = 100
end

function ENT:Use( activator, caller )
	net.Start( "getMoneyPrintMenu" )
		net.WriteEntity( self )
	net.Send( caller )
end

function ENT:Think()
	if self:GetNWInt( "money" ) != nil then
		if CurTime() < self.delay then return end
		self.delay = CurTime() + ( self.countdown / self:GetNWInt( "cpu" ) / self:GetNWInt( "cooler" ) )

		self:SetNWInt( "money", self:GetNWInt( "money" ) + ( 10 * self:GetNWInt( "printer" ) ) )
		if self:GetNWInt( "money" ) > self:GetNWInt( "moneyMax" ) then
			self:SetNWInt( "money", self:GetNWInt( "moneyMax" ) )
		end
	end
end