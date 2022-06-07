Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

func = {}
Tunnel.bindInterface(GetCurrentResourceName(),func)
Config = module(GetCurrentResourceName(),"config/config_ponto")
--[ Conexão com A VRP ]--


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function func.identidade()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local testee 

    if vRP.hasPermission(user_id,Config["permissao"]["PoliciaS"]) then
        testee = true
    elseif vRP.hasPermission(user_id,Config["permissao"]["PoliciaF"]) then
        testee = false
    end

    if identity then
        return identity.name,identity.firstname,testee
    end
end

func.entreservico = function()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        local groups = vRP.getUserGroups(user_id)

        if vRP.hasPermission(user_id,Config["permissao"]["PoliciaF"]) then
		    vRP.addUserGroup(user_id,Config["groups"]["Policialservico"])
            vRP.removeUserGroup(user_id,Config["groups"]["Policialfora"])
		    TriggerClientEvent("Notify",source,"sucesso","Você Entrou em servico. <b>"..user_id)
            SendWebhookMessage(Config["Webhooks"]["Policia"],"ID:"..user_id.." Entrou em serviço Nome:"..identity.name..", Sobrenome:"..identity.firstname)
        else
		    TriggerClientEvent("Notify",source,"negado","Você ja está em serviço. <b>"..user_id)
        end
    end
end    

func.sairservico = function()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        local groups = vRP.getUserGroups(user_id)
        if vRP.hasPermission(user_id,Config["permissao"]["PoliciaS"]) then
		    vRP.addUserGroup(user_id,Config["groups"]["Policialfora"])
            vRP.removeUserGroup(user_id,Config["groups"]["Policialservico"])
		    TriggerClientEvent("Notify",source,"sucesso","Você Saiu de servico. <b>"..user_id)
        else
		    TriggerClientEvent("Notify",source,"negado","Você não está em serviço. <b>"..user_id)
        end
    end
end

print("^2Created by ^1Raavy#0001^0")

