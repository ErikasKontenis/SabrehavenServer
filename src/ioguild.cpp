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

#include "otpch.h"

#include "ioguild.h"
#include "database.h"

uint32_t IOGuild::getGuildIdByName(const std::string& name)
{
	Database* db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `id` FROM `guilds` WHERE `name` = " << db->escapeString(name);

	DBResult_ptr result = db->storeQuery(query.str());
	if (!result) {
		return 0;
	}
	return result->getNumber<uint32_t>("id");
}

void IOGuild::getWarList(uint32_t guildId, GuildWarList& guildWarList)
{
	std::ostringstream query;
	query << "SELECT `guild1`, `guild2` FROM `guild_wars` WHERE (`guild1` = " << guildId << " OR `guild2` = " << guildId << ") AND `status` IN (1, 4)";

	DBResult_ptr result = Database::getInstance()->storeQuery(query.str());
	if (!result) {
		return;
	}

	do {
		uint32_t guild1 = result->getNumber<uint32_t>("guild1");
		if (guildId != guild1) {
			guildWarList.push_back(guild1);
		} else {
			guildWarList.push_back(result->getNumber<uint32_t>("guild2"));
		}
	} while (result->next());
}

uint64_t IOGuild::getGuildBalance(uint32_t id)
{
	std::ostringstream query;
	query << "SELECT `balance` FROM `guilds` WHERE `id` = " << id;
	DBResult_ptr result = Database::getInstance()->storeQuery(query.str());
	if (!result) {
		return 0;
	}

	return result->getNumber<uint64_t>("balance");
}

bool IOGuild::increaseGuildBankBalance(uint32_t guid, uint64_t bankBalance)
{
	std::ostringstream query;
	query << "UPDATE `guilds` SET `balance` = `balance` + " << bankBalance << " WHERE `id` = " << guid;
	return Database::getInstance()->executeQuery(query.str());
}

bool IOGuild::decreaseGuildBankBalance(uint32_t guid, uint64_t bankBalance)
{
	std::ostringstream query;
	query << "UPDATE `guilds` SET `balance` = `balance` - " << bankBalance << " WHERE `id` = " << guid;
	return Database::getInstance()->executeQuery(query.str());
}