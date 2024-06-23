extends Node

enum EntityType {Ally = 0,Ennemy = 1,RedTotem = 2,BlueTotem = 3,YellowTotem = 4,PurpleTotem = 5,GreenTotem = 6,none}

enum LootType {gold,soul}

enum WaveEditorAction {Load,Save}

enum DragOrigin {UI,World}

enum GameplayLoopState {MainMenu,Preparation,Round,EndRound,Victory,Defeat,GameClosed,_none}

enum SoulType {blue,purple,yellow,green,red}

enum BoosterType {Melee,Distance,Magic}

enum MeleeBoosterPool {cheumvalier,rogue,berserk,tank}

const CARD_PER_BOOSTER = 3

const INVENTORY_CAPACITY = 10
