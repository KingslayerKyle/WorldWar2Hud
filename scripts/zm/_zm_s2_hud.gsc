#using scripts\codescripts\struct;

#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;

#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_utility;

#using scripts\zm\_zm_weap_mad_minute;

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#insert scripts\zm\_zm_utility.gsh;

REGISTER_SYSTEM_EX( "zm_s2_hud", &__init__, &__main__, undefined )

function __init__()
{
    clientfield::register( "clientuimodel", "S2.Health",   VERSION_SHIP, GetMinBitCountForNum( 200 ), "int" );
    clientfield::register( "clientuimodel", "S2.MuleKick", VERSION_SHIP, 1, "int" );
    clientfield::register( "clientuimodel", "S2.PerkSlots", VERSION_SHIP, GetMinBitCountForNum( 31 ), "int" );
}

function __main__()
{
    callback::on_spawned( &player_health_monitor );
    callback::on_spawned( &mule_kick_monitor );
    callback::on_spawned( &perk_slots_monitor );
}

function player_health_monitor()
{
    self endon( "bled_out" );
    self endon( "disconnect" );
    
	while( 1 )
	{
		if( isdefined( self ) )
		{
			if( !IS_EQUAL( self clientfield::get_player_uimodel( "S2.Health" ), self.health ) )
			{
				if( zm_utility::is_player_valid( self ) )
				{
					self clientfield::set_player_uimodel( "S2.Health", self.health );
				}
				else
				{
					self clientfield::set_player_uimodel( "S2.Health", 0 );
				}
			}
		}

		WAIT_SERVER_FRAME;
	}
}

function mule_kick_monitor()
{
	self endon( "bled_out" );
    self endon( "disconnect" );

	while( 1 )
	{
		if( isdefined( self ) )
		{
			self waittill( "weapon_change_complete" );

			if( zm_utility::is_player_valid( self ) &&
				!zm_utility::is_placeable_mine( self GetCurrentWeapon() ) &&
				!zm_equipment::is_equipment( self GetCurrentWeapon() ) &&
			    !self zm_utility::is_player_revive_tool( self GetCurrentWeapon() ) &&
				( level.zombie_powerup_weapon["minigun"] != self GetCurrentWeapon() ) &&
				( level.weaponNone != self GetCurrentWeapon() ) &&
				isdefined( self GetWeaponsListPrimaries()[2] ) &&
				( self GetWeaponsListPrimaries()[2] == self GetCurrentWeapon() ) )
			{
				self clientfield::set_player_uimodel( "S2.MuleKick", 1 );
			}
			else
			{
				self clientfield::set_player_uimodel( "S2.MuleKick", 0 );
			}
		}

		WAIT_SERVER_FRAME;
	}
}

function perk_slots_monitor()
{
	self endon( "bled_out" );
    self endon( "disconnect" );

	while( 1 )
	{
		if( isdefined( self ) && isdefined( self zm_utility::get_player_perk_purchase_limit() ) )
		{
			if( !IS_EQUAL( self clientfield::get_player_uimodel( "S2.PerkSlots" ), self zm_utility::get_player_perk_purchase_limit() ) )
			{
				if( self zm_utility::get_player_perk_purchase_limit() <= 31 )
					self clientfield::set_player_uimodel( "S2.PerkSlots", self zm_utility::get_player_perk_purchase_limit() );
			}
		}

		WAIT_SERVER_FRAME;
	}
}
