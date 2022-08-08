/**
 * Tibia GIMUD Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019 Sabrehaven and Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef FS_CONFIGMANAGER_H_6BDD23BD0B8344F4B7C40E8BE6AF6F39
#define FS_CONFIGMANAGER_H_6BDD23BD0B8344F4B7C40E8BE6AF6F39

#if __has_include("luajit/lua.hpp")
#include <luajit/lua.hpp>
#else
#include <lua.hpp>
#endif

class ConfigManager
{
	public:
		enum boolean_config_t {
			SHOW_MONSTER_LOOT,
			ALLOW_CHANGEOUTFIT,
			ONE_PLAYER_ON_ACCOUNT,
			AIMBOT_HOTKEY_ENABLED,
			REMOVE_RUNE_CHARGES,
			EXPERIENCE_FROM_PLAYERS,
			FREE_PREMIUM,
			REPLACE_KICK_ON_LOGIN,
			ALLOW_CLONES,
			BIND_ONLY_GLOBAL_ADDRESS,
			OPTIMIZE_DATABASE,
			MARKET_PREMIUM,
			STAMINA_SYSTEM,
			WARN_UNSAFE_SCRIPTS,
			CONVERT_UNSAFE_SCRIPTS,
			TELEPORT_NEWBIES,
			STACK_CUMULATIVES,
			BLOCK_HEIGHT,
			UH_TRAP,
			DROP_ITEMS,
			DISTANCE_WEAPONS_DROP_ON_GROUND,
			CORPSE_OWNER_ENABLED,
			ROPE_SPOT_BLOCK,
			PACKET_COMPRESSION,
			LAST_BOOLEAN_CONFIG /* this must be the last one */
		};

		enum string_config_t {
			DUMMY_STR,
			MAP_NAME,
			HOUSE_RENT_PERIOD,
			SERVER_NAME,
			OWNER_NAME,
			OWNER_EMAIL,
			URL,
			LOCATION,
			IP,
			MOTD,
			WORLD_TYPE,
			MYSQL_HOST,
			MYSQL_USER,
			MYSQL_PASS,
			MYSQL_DB,
			MYSQL_SOCK,
			DEFAULT_PRIORITY,
			MAP_AUTHOR,

			LAST_STRING_CONFIG /* this must be the last one */
		};

		enum integer_config_t {
			SQL_PORT,
			MAX_PLAYERS,
			PZ_LOCKED,
			DEFAULT_DESPAWNRANGE,
			DEFAULT_DESPAWNRADIUS,
			RATE_EXPERIENCE,
			RATE_SKILL,
			RATE_LOOT,
			RATE_MAGIC,
			RATE_SPAWN,
			MIN_RATE_SPAWN,
			MAX_RATE_SPAWN,
			BAN_LENGTH,
			MAX_MESSAGEBUFFER,
			ACTIONS_DELAY_INTERVAL,
			EX_ACTIONS_DELAY_INTERVAL,
			KICK_AFTER_MINUTES,
			PROTECTION_LEVEL,
			DEATH_LOSE_PERCENT,
			KNIGHT_CLOSE_ATTACK_DAMAGE_INCREASE_PERCENT,
			PALADIN_RANGE_ATTACK_DAMAGE_INCREASE_PERCENT,
			STATUSQUERY_TIMEOUT,
			WHITE_SKULL_TIME,
			RED_SKULL_TIME,
			KILLS_DAY_RED_SKULL,
			KILLS_WEEK_RED_SKULL,
			KILLS_MONTH_RED_SKULL,
			KILLS_DAY_BANISHMENT,
			KILLS_WEEK_BANISHMENT,
			KILLS_MONTH_BANISHMENT,
			GAME_PORT,
			LOGIN_PORT,
			STATUS_PORT,
			STAIRHOP_DELAY,
			MARKET_OFFER_DURATION,
			CHECK_EXPIRED_MARKET_OFFERS_EACH_MINUTES,
			MAX_MARKET_OFFERS_AT_A_TIME_PER_PLAYER,
			EXP_FROM_PLAYERS_LEVEL_RANGE,
			MAX_PACKETS_PER_SECOND,
			NEWBIE_TOWN,
			NEWBIE_LEVEL_THRESHOLD,
			MONEY_RATE,
			CLIENT_VERSION,

			LAST_INTEGER_CONFIG /* this must be the last one */
		};

		bool load();
		bool reload();

		const std::string& getString(string_config_t what) const;
		int32_t getNumber(integer_config_t what) const;
		bool getBoolean(boolean_config_t what) const;

	private:
		static std::string getGlobalString(lua_State* L, const char* identifier, const char* defaultValue);
		static int32_t getGlobalNumber(lua_State* L, const char* identifier, const int32_t defaultValue = 0);
		static bool getGlobalBoolean(lua_State* L, const char* identifier, const bool defaultValue);

		std::string string[LAST_STRING_CONFIG] = {};
		int32_t integer[LAST_INTEGER_CONFIG] = {};
		bool boolean[LAST_BOOLEAN_CONFIG] = {};

		bool loaded = false;
};

#endif
