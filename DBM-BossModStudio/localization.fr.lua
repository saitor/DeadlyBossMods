
if GetLocale() ~= "frFR" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations
-- BossMod studio
L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "D�clencheurs et Ev�nements"
L.AreaHead_CreateBossMod = "Informations principales de se nouveau BossMod"
L.BossName = "Nom du BossMod - Exemple 'Hogger'"
L.BossID = "Creature ID"
L.BossLookup = "Prendre ID de la Cible"

L.AreaHead_Pull = "Pull / Combat Detection"
L.CombatFromYell = "Combat commen�ant avec un Cri"
L.CombatAutoDetect = "Detection Automatique de Combat "
L.BossPullYell = "Cri du Boss au pull"
L.BossEnrages = "Boss en fr�n�sie "
L.BossEnrageBar = "Afficher Barre Fr�n�sie"
L.BossEnrageAnnounce = "Annoncer Fr�n�sie au Raid"

L.Min = "Min"
L.Sec = "Sec"

L.AreaHead_TriggerCreate = "Cr�er un Ev�nement D�clencheur au Boss "
L.Describe_TriggerCreate = [[Triggers can be created to handle events in bossfights. If the Boss yell some stuff or use one of his abilitys you need to catch and use them. As an example, the boss gains Shieldwall and you want to start a Bar when this occur, you simply have to choose BossBuffs or Debuffs and type in an Name for this event like "Shieldwall"]]

L.Trigger_Typ = "Ev�nement pouvant �tre d�clencheur"
L.Trigger_Name = "Nom du d�clencheur (Description)"
L.Trigger_Typ_Spell = "Sort ou Style"
L.Trigger_Typ_Buff = "Buff ou Debuff"
L.Trigger_Typ_Yell = "Cri ou Emote"
L.Trigger_Typ_Time = "Time based"
L.Trigger_Typ_Hp = "HitPoint Based"
L.Trigger_Create_Bttn = "cr�er d�clencheur"
L.Trigger_Delete_Bttn = "supprimer d�clencheur"

L.EventYellText = "Crier/Dire/Emote qui peuvent appeler l'evenement"
L.EventTimeBased = "D�clencher apr�s X secondes"
L.EventHpBased = "D�clencher sur X pourcentages de Vie"
L.EventSpellID = "Spell ID"
L.EventAnnounce = "Annonce"
L.EventAnnounceText = "Message � annonc�"
L.EventSpecialWarn = "Afficher une Alerte Sp�ciale"
L.EventSpecialWarn_OnlyMe = "Seulement si je suis affect�"
L.EventStartBar = "Commencer un timer"
L.EventWarnEnd = "Afficher alerte avant la fin du timer"
L.EventWarnMsg = "Message d'Alerte"
L.EventSetIcon = "D�finir une Icone sur la Cible (sur le cri %t du texte)"


