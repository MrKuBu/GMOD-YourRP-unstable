--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )
--fr_all.lua

function FR_All()
  --ATM
  lang.loading = "Loading"
  lang.welcome = "Welcome"
  lang.home = "Home"
  lang.withdraw = "Withdraw"
  lang.deposit = "Deposit"
  lang.transfer = "Transfer"
  lang.other = "Other"
  lang.back = "Back"
  lang.nextsite = "Next"
  lang.prevsite = "Prev"
  lang.errorsite = "Error"

  --Buy Menu
  lang.buymenu = "Menu d'achat"
  lang.selectitem = "Choisir l'objet"
  lang.additem = "Ajouter l'objet"
  lang.noitemselected = "aucun objet selectionné"
  lang.itemMenu = "menu d'objets"
  lang.removeitem = "supprimer l'objet"

  --Door
  lang.buybuildingpre = "Acheter"
  lang.buybuildingpos = ""
  lang.addanewbuilding = "ajouter un nouveau bâtiment"
  lang.doorlevel = "porte niveau"
  lang.upgradedoor = "améliorer la porte"
  lang.createkey = "créer clés"
  lang.resetkey = "réinitialiser clés"
  lang.sellbuildingpre = "vendre"
  lang.sellbuildingpos = ""
  lang.lockeddoor = "porte vérouillée"
  lang.unlockeddoor = "porte dévérouillée"
  lang.youdonthaveakey = "tu n'as pas la clé pour ça"
  lang.lockedvehicle = "Vehicle locked"
  lang.unlockedvehicle = "Vehicle unlocked"

  --hud
  lang.tooltip = "Aide"
  lang.changeview = "Changer de vue"
  lang.guimouse = "turn mouse on/off"
  lang.fppr = "Première personne réaliste"
  lang.presse = "Appuies sur [E] pour ouvrir/fermer la porte"
  lang.holde = "Maintiens [E] pour ouvrir les options"
  lang.presseveh = "Press [E] to enter/exit vehicle"
  lang.holdeveh = lang.holde
  lang.dead = "Mort"
  lang.respawning = "Réapparition"
  lang.helpclose = "Clique dans un espace vide pour fermer"
  lang.helpmove = "Tu veux bouger un élément du HUD ? Déplace les boîtes bleues avec ta souris"
  lang.helpresize = "Tu veux redimensionner un élément du HUD ? Vas avec ta souris sur la boîte verte et maintiens le clique en bougeant la souris"
  lang.minimap = "Minimap"
  lang.health = "Vie"
  lang.armor = "Armure"
  lang.wname = "Nom de l'arme"
  lang.wprimary = "Munitions primaires"
  lang.wsecondary = "Munitions secondaires"
  lang.youarespeaking = "You are speaking"

  --Interact
  lang.interactmenu = "Menu d'interaction"
  lang.trade = "Echange"
  lang.promote = "Promouvoir"
  lang.demote = "Rétrograder"

  --Role Menu
  lang.rolemenu = "Menu des rôles"
  lang.moreinfo = "Plus d'information"
  lang.role = "Rôle"
  lang.description = "Description"
  lang.salary = "Salaire"
  lang.sweps = "Equipment"
  lang.getrole = "Prendre le rôle"
  lang.needwhitelist = "Tu dois être mit sur la liste blanche"
  lang.adminonly = "Administrateurs uniquement"

  --Settings
  lang.changehud = "Changer le HUD"
  lang.togglehud = "Basculer le HUD"
  lang.resethud = "Réinitialiser le HUD"
  lang.hudbackground = "Couleur de fond du HUD"
  lang.hudborder = "Couleur des bords du HUD"
  lang.crosshair = "Couleur de la croix"
  lang.crosshairborder = "Couleur des bords de la croix"
  lang.crosshairsettings = "Options de la croix"
  lang.gamemodename = "Nom du mode de jeu"
  lang.advertname = "Nom du canal"
  lang.updatecountdown = "Compte à rebours"
  lang.updateserver = "Mettre à jour"
  lang.cancelupdateserver = "Annuler la mise à jour"
  lang.hardresetdatabase = "Réinitialiser la bande de données"
  lang.newgroup = "Nouveau groupe"
  lang.newrole = "Nouveau rôle"
  lang.startgroup = "Groupe de départ"
  lang.startrole = "Rôle de départ"
  lang.groupname = "Nom du groupe"
  lang.groupcolor = "Couleur du groupe"
  lang.uppergroup = "Groupe supérieur"
  lang.rolename = "Nom du rôle"
  lang.rolecolor = "Couleur du rôle"
  lang.roleplayermodel = "Modèle de joueur du groupe"
  lang.roleplayermodelsize = "Taille de modèle de joueur du groupe"
  lang.roledescription = "Description du rôle"
  lang.rolesalary = "Salaire du rôle"
  lang.rolemaxamount = "Montant maximum du rôle"
  lang.rolehealth = "Vie du rôle"
  lang.rolemaxhealth = "Vie maximale du rôle"
  lang.rolehealthreg = "Régénération de vie du rôle"
  lang.rolearmor = "Armure du rôle"
  lang.rolemaxarmor = "Armure maximale du rôle"
  lang.rolearmorreg = "Régénération de l'armure du rôle"
  lang.rolewalkspeed = "Vitesse de marche du rôle"
  lang.rolerunspeed = "Vitesse de course du rôle"
  lang.rolejumppower = "Hauteur de saut du rôle"
  lang.roleprerole = "Rôle précédent"
  lang.roleinstructor = "Rôle d'instructeur?"
  lang.rolegroup = "Groupe du rôle"
  lang.rolesweps = "Equipement du rôle"
  lang.roleadminonly = "Rôle uniquement pour les administrateurs?"
  lang.rolewhitelist = "Rôle sur liste blanche?"
  lang.modelchange = "Changeur de modèle de joueur"
  lang.openswepmenu = "Ouvrir le menu d'équipements"
  lang.swepmenu = "Menu d'équipements"
  lang.moneypre = "Préfix de l'argent"
  lang.moneypos = "Suffixe de l'argent"
  lang.startmoney = "Argent de départ"
  lang.giverole = "Donner le rôle"
  lang.deleteentry = "Supprimer l'entrée"
  lang.addspawnpoint = "Ajouter un point d'apparition"
  lang.spawnpointcreator = "Créateur de points d'apparition"
  lang.createspawnpointonyou = "Créer un point d'apparition sur ta position"
  lang.selectgroup = "Choisir un groupe"
  lang.whitelist = "Liste blanche"
  lang.addentry = "Ajouter une entrée"
  lang.removeentry = "Supprimer une entrée"
  lang.whitelistplayer = "Ajouter le joueur à la liste blanche"
  lang.restriction = "Restrições"
  lang.usergroup = "GrupoUsuario"
  lang.vehicles = "Veículos"
  lang.duplicator = "Duplicador"
  lang.entities = "Entidade"
  lang.effects = "Efeitos"
  lang.npcs = "Npcs"
  lang.props = "Props"
  lang.ragdolls = "Ragdolls"
  lang.voteable = "Voteable?"
  lang.reason = "Reason"
  lang.timeinsec = "Time in seconds"
  lang.access = "Access"
  lang.jail = "Jail"
  lang.addjailpoint = "Add Jailpoint"
  lang.addjailfreepoint = "Add Releasepoint"
  lang.time = "Time"
  lang.tieup = "Tie up"
  lang.unleash = "Unleash"

  --General
  lang.yes = "Oui"
  lang.no = "Non"
  lang.areyousure = "Es-tu sûr?"
  lang.on = "On"
  lang.off = "Off"
  lang.settings = "Options"
  lang.length = "Taille"
  lang.gap = "Espacement"
  lang.thickness = "Finesse"
  lang.border = "Bord"
  lang.map = "Carte"
  lang.you = "Tu"
  lang.questions = "Questions"
  lang.money = "Argent"
  lang.give = "Donner"
  lang.price = "Prix"
  lang.buy = "Acheter"
  lang.general = "Général"
  lang.server = "Serveur"
  lang.client = "Client"
  lang.character = "Personnage"
  lang.firstname = "Prénom"
  lang.surname = "Nom"
  lang.hud = "Hud"
  lang.role = "Rôle"
  lang.roles = "Rôles"
  lang.group = "Groupe"
  lang.groups = "Groupes"
  lang.friendlyfire = "Tir allié"
  lang.default = "Défaut"
  lang.disabled = "Désactivé"
  lang.enabled = "Activé"
  lang.roleplayshort = "RP"
  lang.roleplay = "Jeu de rôle"
  lang.change = "Changer"
  lang.added = "Ajouté"
  lang.notadded = "Non ajouté"
  lang.add = "Ajouter"
  lang.remove = "Supprimer"
  lang.gender = "Genre"
  lang.nick = "Pseudo"
  lang.position = "Position"
  lang.angle = "Angle"
  lang.type = "Type"
  lang.player = "Joueur"
  lang.players = "Joueurs"
  lang.workshop = "Workshop"
  lang.wiki = "Wiki"
  lang.contact = "Contact"
  lang.siteisloading = "Chargement du site"
  lang.name = "Nom"
  lang.building = "Bâtiment"
  lang.owner = "Propriétaire"
  lang.removeowner = "Supprimer le propriétaire"
  lang.door = "Porte"
  lang.doors = "Portes"
  lang.weapon = "Arme"
  lang.weapons = "Armes"
  lang.key = "Clés"
  lang.fpp = "Première personne"
  lang.tpp = "Troisième personne"
  lang.ping = "Ping"
  lang.mute = "Muer"
  lang.metabolism = "Metabolism"
  lang.hunger = "Hunger"
  lang.thirst = "Sede"
  lang.stamina = "Estamina"
  lang.votes = "Votos"
  lang.confirm = "Confirmar"
  lang.identifycard = "Cartão de identificação"
  lang.male = "Masculino"
  lang.female = "Feminino"
  lang.duplicate = "Duplicar"
  lang.enteraname = "Enter a name"
  lang.nameistolong = "Name is to long"
  lang.nameistoshort = "Name is to short"
  lang.enterworld = "Enter world"
  lang.deletecharacter = "Delete character"
  lang.characterselection = "Character selection"
  lang.charactercreation = "Character creation"
  lang.color = "Color"
  lang.dark = "Dark"
  lang.light = "Light"
  lang.localchat = "Local"
  lang.globalchat = "Global"
  lang.appearance = "Appearance"
  lang.skin = "Variants"
  lang.moneyprinter = "Money printer"
  lang.max = "Max"
  lang.cpu = "CPU"
  lang.cooler = "Cooler"
  lang.printer = "Printer"
  lang.storage = "Storage"
  lang.upgrade = "Upgrade"
  lang.fuelup = "Fuel up"
  lang.fuel = "Fuel"
  lang.toggle = "Toggle"
  lang.full = "Full"
  lang.menu = "Menu"
  lang.suicide = "Suicide"
end
