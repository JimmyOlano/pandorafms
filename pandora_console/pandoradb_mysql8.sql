-- Pandora FMS - the Flexible Monitoring System
-- ============================================
-- Copyright (c) 2005-2020 Artica Soluciones Tecnológicas, http://www.artica.es
-- Please see http://pandora.sourceforge.net for full contribution list

-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation for version 2.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

-- PLEASE NO NOT USE MULTILINE COMMENTS
-- Because Pandora Installer don't understand them
-- and fails creating database !!!

-- Priority : 0 - Maintance (grey)
-- Priority : 1 - Low (green)
-- Priority : 2 - Normal (blue)
-- Priority : 3 - Warning (yellow)
-- Priority : 4 - Critical (red)

-- ---------------------------------------------------------------------
-- Table `taddress`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `taddress` (
	`id_a` int unsigned NOT NULL auto_increment,
	`ip` varchar(60) NOT NULL default '',
	`ip_pack` int unsigned NOT NULL default '0',
	PRIMARY KEY  (`id_a`),
	KEY `ip` (`ip`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `taddress_agent`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `taddress_agent` (
	`id_ag` bigint unsigned NOT NULL auto_increment,
	`id_a` bigint unsigned NOT NULL default '0',
	`id_agent` mediumint unsigned NOT NULL default '0',
	PRIMARY KEY  (`id_ag`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagente`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente` (
	`id_agente` int unsigned NOT NULL auto_increment,
	`nombre` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`direccion` varchar(100) default NULL,
	`comentarios` varchar(255) default '',
	`id_grupo` int unsigned NOT NULL default '0',
	`ultimo_contacto` datetime NOT NULL default '1970-01-01 00:00:00',
	`modo` tinyint  NOT NULL default '0',
	`intervalo` int unsigned NOT NULL default '300',
	`id_os` int unsigned default '0',
	`os_version` varchar(100) default '',
	`agent_version` varchar(100) default '',
	`ultimo_contacto_remoto` datetime default '1970-01-01 00:00:00',
	`disabled` tinyint  NOT NULL default '0',
	`remote` tinyint  NOT NULL default 0,
	`id_parent` int unsigned default '0',
	`custom_id` varchar(255) default '',
	`server_name` varchar(100) default '',
	`cascade_protection` tinyint  NOT NULL default '0',
	`cascade_protection_module` int unsigned NOT NULL default '0',
	`timezone_offset` tinyint  NULL DEFAULT '0' COMMENT 'nuber of hours of diference with the server timezone' ,
	`icon_path` VARCHAR(127) NULL DEFAULT NULL COMMENT 'path in the server to the image of the icon representing the agent' ,
	`update_gis_data` tinyint  NOT NULL DEFAULT '1' COMMENT 'set it to one to update the position data (altitude, longitude, latitude) when getting information from the agent or to 0 to keep the last value and do not update it' ,
	`url_address` mediumtext NULL,
	`quiet` tinyint  NOT NULL default '0',
	`normal_count` bigint NOT NULL default '0',
	`warning_count` bigint NOT NULL default '0',
	`critical_count` bigint NOT NULL default '0',
	`unknown_count` bigint NOT NULL default '0',
	`notinit_count` bigint NOT NULL default '0',
	`total_count` bigint NOT NULL default '0',
	`fired_count` bigint NOT NULL default '0',
	`update_module_count` tinyint  NOT NULL default '0',
	`update_alert_count` tinyint  NOT NULL default '0',
	`update_secondary_groups` tinyint  NOT NULL default '0',
	`alias` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`transactional_agent` tinyint  NOT NULL default '0',
	`alias_as_name` tinyint  NOT NULL default '0',
	`safe_mode_module` int unsigned NOT NULL default '0',
	`cps` int NOT NULL default 0,
	PRIMARY KEY  (`id_agente`),
	KEY `nombre` (`nombre`(255)),
	KEY `direccion` (`direccion`),
	KEY `disabled` (`disabled`),
	KEY `id_grupo` (`id_grupo`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagente_datos`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente_datos` (
	`id_agente_modulo` int unsigned NOT NULL default '0',
	`datos` double(22,5) default NULL,
	`utimestamp` bigint default '0',
	KEY `data_index1` (`id_agente_modulo`, `utimestamp`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagente_datos_inc`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente_datos_inc` (
	`id_agente_modulo` int unsigned NOT NULL default '0',
	`datos` double(22,5) default NULL,
	`utimestamp` int unsigned default '0',
	KEY `data_inc_index_1` (`id_agente_modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagente_datos_string`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente_datos_string` (
	`id_agente_modulo` int unsigned NOT NULL default '0',
	`datos` mediumtext NOT NULL,
	`utimestamp` int unsigned NOT NULL default 0,
	KEY `data_string_index_1` (`id_agente_modulo`, `utimestamp`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tagente_datos_log4x`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente_datos_log4x` (
	`id_tagente_datos_log4x` bigint unsigned NOT NULL auto_increment,
	`id_agente_modulo` int unsigned NOT NULL default '0',
	
	`severity` text NOT NULL,
	`message` text NOT NULL,
	`stacktrace` text NOT NULL,
	
	`utimestamp` int unsigned NOT NULL default 0,
	PRIMARY KEY  (`id_tagente_datos_log4x`),
	KEY `data_log4x_index_1` (`id_agente_modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tagente_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente_estado` (
	`id_agente_estado` int unsigned NOT NULL auto_increment,
	`id_agente_modulo` int NOT NULL default '0',
	`datos` mediumtext NOT NULL,
	`timestamp` datetime NOT NULL default '1970-01-01 00:00:00',
	`estado` int NOT NULL default '0',
	`known_status` tinyint  default 0,
	`id_agente` int NOT NULL default '0',
	`last_try` datetime default NULL,
	`utimestamp` bigint NOT NULL default '0',
	`current_interval` int unsigned NOT NULL default '0',
	`running_by` smallint(4) unsigned default '0',
	`last_execution_try` bigint NOT NULL default '0',
	`status_changes` tinyint  unsigned default 0,
	`last_status` tinyint  default 0,
	`last_known_status` tinyint  default 0,
	`last_error` int NOT NULL default '0',
	`ff_start_utimestamp` bigint default 0,
	`ff_normal` int unsigned default '0',
	`ff_warning` int unsigned default '0',
	`ff_critical` int unsigned default '0',
	`last_dynamic_update` bigint NOT NULL default '0',
	`last_unknown_update` bigint NOT NULL default '0',
	`last_status_change` bigint NOT NULL default '0',
	PRIMARY KEY  (`id_agente_estado`),
	KEY `status_index_1` (`id_agente_modulo`),
	KEY `idx_agente` (`id_agente`),
	KEY `running_by` (`running_by`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;
-- Probably last_execution_try index is not useful and loads more than benefits

-- -----------------------------------------------------
-- Table `tagente_modulo`
-- -----------------------------------------------------
-- id_modulo now uses tmodule 
-- ---------------------------
-- 1 - Data server modules (agent related modules)
-- 2 - Network server modules
-- 4 - Plugin server
-- 5 - Predictive server
-- 6 - WMI server
-- 7 - WEB Server (enteprise)

CREATE TABLE IF NOT EXISTS `tagente_modulo` (
	`id_agente_modulo` int unsigned NOT NULL auto_increment,
	`id_agente` int unsigned NOT NULL default '0',
	`id_tipo_modulo` smallint(5) NOT NULL default '0',
	`descripcion` TEXT NOT NULL,
	`extended_info` TEXT NOT NULL,
	`nombre` text NOT NULL,
	`unit` text,
	`id_policy_module` INTEGER unsigned NOT NULL default '0',
	`max` bigint default '0',
	`min` bigint default '0',
	`module_interval` int unsigned default '0',
	`cron_interval` varchar(100) default '',
	`module_ff_interval` int unsigned default '0',
	`tcp_port` int unsigned default '0',
	`tcp_send` TEXT,
	`tcp_rcv` TEXT,
	`snmp_community` varchar(100) default '',
	`snmp_oid` varchar(255) default '0',
	`ip_target` varchar(100) default '',
	`id_module_group` int unsigned default '0',
	`flag` tinyint  unsigned default '1',
	`id_modulo` int unsigned default '0',
	`disabled` tinyint  unsigned NOT NULL default '0',
	`id_export` smallint(4) unsigned default '0',
	`plugin_user` text,
	`plugin_pass` text,
	`plugin_parameter` text,
	`id_plugin` int default '0',
	`post_process` double(24,15) default 0,
	`prediction_module` bigint default '0',
	`max_timeout` int unsigned default '0',
	`max_retries` int unsigned default '0',
	`custom_id` varchar(255) default '',
	`history_data` tinyint  unsigned default '1',
	`min_warning` double(18,2) default 0,
	`max_warning` double(18,2) default 0,
	`str_warning` text,
	`min_critical` double(18,2) default 0,
	`max_critical` double(18,2) default 0,
	`str_critical` text,
	`min_ff_event` int unsigned default '0',
	`delete_pending` int unsigned default 0,
	`policy_linked` tinyint  unsigned not null default 0,
	`policy_adopted` tinyint  unsigned not null default 0,
	`custom_string_1` mediumtext,
	`custom_string_2` text,
	`custom_string_3` text,
	`custom_integer_1` int default 0,
	`custom_integer_2` int default 0,
	`wizard_level` enum('basic','advanced','nowizard') default 'nowizard',
	`macros` text,
	`critical_instructions` text NOT NULL,
	`warning_instructions` text NOT NULL,
	`unknown_instructions` text NOT NULL,
	`quiet` tinyint  NOT NULL default '0',
	`critical_inverse` tinyint  unsigned default '0',
	`warning_inverse` tinyint  unsigned default '0',
	`id_category` int default 0,
	`disabled_types_event` TEXT NOT NULL,
	`module_macros` TEXT NOT NULL,
	`min_ff_event_normal` int unsigned default '0',
	`min_ff_event_warning` int unsigned default '0',
	`min_ff_event_critical` int unsigned default '0',
	`ff_type` tinyint  unsigned default '0',
	`each_ff` tinyint  unsigned default '0',
	`ff_timeout` int unsigned default '0',
	`dynamic_interval` int unsigned default '0',
	`dynamic_max` int default '0',
	`dynamic_min` int default '0',
	`dynamic_next` bigint NOT NULL default '0',
	`dynamic_two_tailed` tinyint  unsigned default '0',
	`prediction_sample_window` int default 0,
	`prediction_samples` int default 0,
	`prediction_threshold` int default 0,
	`parent_module_id` int unsigned NOT NULL default 0,
	`cps` int NOT NULL default 0,
	PRIMARY KEY  (`id_agente_modulo`),
	KEY `main_idx` (`id_agente_modulo`,`id_agente`),
	KEY `tam_agente` (`id_agente`),
	KEY `id_tipo_modulo` (`id_tipo_modulo`),
	KEY `disabled` (`disabled`),
	KEY `module` (`id_modulo`),
	KEY `nombre` (`nombre` (255)),
	KEY `module_group` (`id_module_group`) using btree
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;
-- snmp_oid is also used for WMI query

-- -----------------------------------------------------
-- Table `tagent_access`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagent_access` (
	`id_agent` int unsigned NOT NULL default '0',
	`utimestamp` bigint NOT NULL default '0',
	KEY `agent_index` (`id_agent`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_snmp`
-- -----------------------------------------------------
CREATE TABLE  IF NOT EXISTS  `talert_snmp` (
	`id_as` int unsigned NOT NULL auto_increment,
	`id_alert` int unsigned NOT NULL default '0',
	`al_field1` text NOT NULL,
	`al_field2` text NOT NULL,
	`al_field3` text NOT NULL,
	`al_field4` text NOT NULL,
	`al_field5` text NOT NULL,
	`al_field6` text NOT NULL,
	`al_field7` text NOT NULL,
	`al_field8` text NOT NULL,
	`al_field9` text NOT NULL,
	`al_field10` text NOT NULL,
	`al_field11` text NOT NULL,
	`al_field12` text NOT NULL,
	`al_field13` text NOT NULL,
	`al_field14` text NOT NULL,
	`al_field15` text NOT NULL,
	`description` varchar(255) default '',
	`alert_type` int unsigned NOT NULL default '0',
	`agent` varchar(100) default '',
	`custom_oid` text,
	`oid` varchar(255) NOT NULL default '',
	`time_threshold` int NOT NULL default '0',
	`times_fired` int unsigned NOT NULL default '0',
	`last_fired` datetime NOT NULL default '1970-01-01 00:00:00',
	`max_alerts` int NOT NULL default '1',
	`min_alerts` int NOT NULL default '1',
	`internal_counter` int unsigned NOT NULL default '0',
	`priority` tinyint  default '0',
	`_snmp_f1_` text, 
	`_snmp_f2_` text, 
	`_snmp_f3_` text,
	`_snmp_f4_` text, 
	`_snmp_f5_` text, 
	`_snmp_f6_` text,
	`_snmp_f7_` text,
	`_snmp_f8_` text,
	`_snmp_f9_` text,
	`_snmp_f10_` text,
	`_snmp_f11_` text,
	`_snmp_f12_` text,
	`_snmp_f13_` text,
	`_snmp_f14_` text,
	`_snmp_f15_` text,
	`_snmp_f16_` text,
	`_snmp_f17_` text,
	`_snmp_f18_` text,
	`_snmp_f19_` text,
	`_snmp_f20_` text,
	`trap_type` int NOT NULL default '-1',
	`single_value` varchar(255) default '', 
	`position` int unsigned NOT NULL default '0',
	`disable_event` tinyint  default 0,
	`id_group` int unsigned NOT NULL default '0',
	`order_1` int unsigned NOT NULL default 1,
	`order_2` int unsigned NOT NULL default 2,
	`order_3` int unsigned NOT NULL default 3,
	`order_4` int unsigned NOT NULL default 4,
	`order_5` int unsigned NOT NULL default 5,
	`order_6` int unsigned NOT NULL default 6,
	`order_7` int unsigned NOT NULL default 7,
	`order_8` int unsigned NOT NULL default 8,
	`order_9` int unsigned NOT NULL default 9,
	`order_10` int unsigned NOT NULL default 10,
	`order_11` int unsigned NOT NULL default 11,
	`order_12` int unsigned NOT NULL default 12,
	`order_13` int unsigned NOT NULL default 13,
	`order_14` int unsigned NOT NULL default 14,
	`order_15` int unsigned NOT NULL default 15,
	`order_16` int unsigned NOT NULL default 16,
	`order_17` int unsigned NOT NULL default 17,
	`order_18` int unsigned NOT NULL default 18,
	`order_19` int unsigned NOT NULL default 19,
	`order_20` int unsigned NOT NULL default 20,
	PRIMARY KEY  (`id_as`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_commands`
-- -----------------------------------------------------
CREATE TABLE  IF NOT EXISTS `talert_commands` (
	`id` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`command` text,
	`id_group` mediumint unsigned NULL default 0,
	`description` text,
	`internal` tinyint  default 0,
	`fields_descriptions` TEXT,
	`fields_values` TEXT,
	`fields_hidden` TEXT,
	`previous_name` text,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_actions`
-- -----------------------------------------------------
CREATE TABLE  IF NOT EXISTS `talert_actions` (
	`id` int unsigned NOT NULL auto_increment,
	`name` text,
	`id_alert_command` int unsigned NULL default 0,
	`field1` text NOT NULL,
	`field2` text NOT NULL,
	`field3` text NOT NULL,
	`field4` text NOT NULL,
	`field5` text NOT NULL,
	`field6` text NOT NULL,
	`field7` text NOT NULL,
	`field8` text NOT NULL,
	`field9` text NOT NULL,
	`field10` text NOT NULL,
	`field11` text NOT NULL,
	`field12` text NOT NULL,
	`field13` text NOT NULL,
	`field14` text NOT NULL,
	`field15` text NOT NULL,
	`field16` text NOT NULL,
	`field17` text NOT NULL,
	`field18` text NOT NULL,
	`field19` text NOT NULL,
	`field20` text NOT NULL,
	`id_group` mediumint unsigned NULL default 0,
	`action_threshold` int NOT NULL default '0',
	`field1_recovery` text NOT NULL,
	`field2_recovery` text NOT NULL,
	`field3_recovery` text NOT NULL,
	`field4_recovery` text NOT NULL,
	`field5_recovery` text NOT NULL,
	`field6_recovery` text NOT NULL,
	`field7_recovery` text NOT NULL,
	`field8_recovery` text NOT NULL,
	`field9_recovery` text NOT NULL,
	`field10_recovery` text NOT NULL,
	`field11_recovery` text NOT NULL,
	`field12_recovery` text NOT NULL,
	`field13_recovery` text NOT NULL,
	`field14_recovery` text NOT NULL,
	`field15_recovery` text NOT NULL,
	`field16_recovery` text NOT NULL,
	`field17_recovery` text NOT NULL,
	`field18_recovery` text NOT NULL,
	`field19_recovery` text NOT NULL,
	`field20_recovery` text NOT NULL,
	`previous_name` text,
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_alert_command`) REFERENCES talert_commands(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_templates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `talert_templates` (
	`id` int unsigned NOT NULL auto_increment,
	`name` text,
	`description` mediumtext,
	`id_alert_action` int unsigned NULL,
	`field1` text NOT NULL,
	`field2` text NOT NULL,
	`field3` text NOT NULL,
	`field4` text NOT NULL,
	`field5` text NOT NULL,
	`field6` text NOT NULL,
	`field7` text NOT NULL,
	`field8` text NOT NULL,
	`field9` text NOT NULL,
	`field10` text NOT NULL,
	`field11` text NOT NULL,
	`field12` text NOT NULL,
	`field13` text NOT NULL,
	`field14` text NOT NULL,
	`field15` text NOT NULL,
	`type` ENUM ('regex', 'max_min', 'max', 'min', 'equal', 'not_equal', 'warning', 'critical', 'onchange', 'unknown', 'always', 'not_normal'),
	`value` varchar(255) default '',
	`matches_value` tinyint  default 0,
	`max_value` double(18,2) default NULL,
	`min_value` double(18,2) default NULL,
	`time_threshold` int NOT NULL default '0',
	`max_alerts` int unsigned NOT NULL default '1',
	`min_alerts` int unsigned NOT NULL default '0',
	`time_from` time default '00:00:00',
	`time_to` time default '00:00:00',
	`monday` tinyint  default 1,
	`tuesday` tinyint  default 1,
	`wednesday` tinyint  default 1,
	`thursday` tinyint  default 1,
	`friday` tinyint  default 1,
	`saturday` tinyint  default 1,
	`sunday` tinyint  default 1,
	`recovery_notify` tinyint  default '0',
	`field1_recovery` text NOT NULL,
	`field2_recovery` text NOT NULL,
	`field3_recovery` text NOT NULL,
	`field4_recovery` text NOT NULL,
	`field5_recovery` text NOT NULL,
	`field6_recovery` text NOT NULL,
	`field7_recovery` text NOT NULL,
	`field8_recovery` text NOT NULL,
	`field9_recovery` text NOT NULL,
	`field10_recovery` text NOT NULL,
	`field11_recovery` text NOT NULL,
	`field12_recovery` text NOT NULL,
	`field13_recovery` text NOT NULL,
	`field14_recovery` text NOT NULL,
	`field15_recovery` text NOT NULL,
	`priority` tinyint  default '0',
	`id_group` mediumint unsigned NULL default 0,
	`special_day` tinyint  default 0,
	`wizard_level` enum('basic','advanced','nowizard') default 'nowizard',
	`min_alerts_reset_counter` tinyint  default 0,
	`disable_event` tinyint  default 0,
	`previous_name` text,
	PRIMARY KEY  (`id`),
	KEY `idx_template_action` (`id_alert_action`),
	FOREIGN KEY (`id_alert_action`) REFERENCES talert_actions(`id`)
		ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_template_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `talert_template_modules` (
	`id` int unsigned NOT NULL auto_increment,
	`id_agent_module` int unsigned NOT NULL,
	`id_alert_template` int unsigned NOT NULL,
	`id_policy_alerts` int unsigned NOT NULL default '0',
	`internal_counter` int default '0',
	`last_fired` bigint NOT NULL default '0',
	`last_reference` bigint NOT NULL default '0',
	`times_fired` int NOT NULL default '0',
	`disabled` tinyint  default '0',
	`standby` tinyint  default '0',
	`priority` tinyint  default '0',
	`force_execution` tinyint  default '0',
	PRIMARY KEY (`id`),
	KEY `idx_template_module` (`id_agent_module`),
	FOREIGN KEY (`id_agent_module`) REFERENCES tagente_modulo(`id_agente_modulo`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`id_alert_template`) REFERENCES talert_templates(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	UNIQUE (`id_agent_module`, `id_alert_template`),
	INDEX force_execution (`force_execution`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_template_module_actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `talert_template_module_actions` (
	`id` int unsigned NOT NULL auto_increment,
	`id_alert_template_module` int unsigned NOT NULL,
	`id_alert_action` int unsigned NOT NULL,
	`fires_min` int unsigned default 0,
	`fires_max` int unsigned default 0,
	`module_action_threshold` int NOT NULL default '0',
	`last_execution` bigint NOT NULL default '0',
	PRIMARY KEY (`id`),
	FOREIGN KEY (`id_alert_template_module`) REFERENCES talert_template_modules(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`id_alert_action`) REFERENCES talert_actions(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `talert_special_days`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `talert_special_days` (
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`id_group` int NOT NULL DEFAULT 0,
	`date` date NOT NULL DEFAULT '1970-01-01',
	`same_day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL DEFAULT 'sunday',
	`description` text,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tattachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tattachment` (
	`id_attachment` int unsigned NOT NULL auto_increment,
	`id_incidencia` int unsigned NOT NULL default '0',
	`id_usuario` varchar(60) NOT NULL default '',
	`filename` varchar(255) NOT NULL default '',
	`description` varchar(150) default '',
	`size` bigint unsigned NOT NULL default '0',
	PRIMARY KEY  (`id_attachment`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tconfig`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tconfig` (
	`id_config` int unsigned NOT NULL auto_increment,
	`token` varchar(100) NOT NULL default '',
	`value` text NOT NULL,
	PRIMARY KEY  (`id_config`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tconfig_os`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `tconfig_os` (
	`id_os` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`description` varchar(250) default '',
	`icon_name` varchar(100) default '',
	`previous_name` text NULL,
	PRIMARY KEY  (`id_os`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tcontainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcontainer` (
	`id_container` mediumint unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`parent` mediumint unsigned NOT NULL default 0,
	`disabled` tinyint  unsigned NOT NULL default 0,
	`id_group` mediumint unsigned NULL default 0, 
	`description` TEXT NOT NULL,
 	PRIMARY KEY  (`id_container`),
 	KEY `parent_index` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tcontainer_item`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcontainer_item` (
	`id_ci` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_container` mediumint unsigned NOT NULL default 0,
	`type` varchar(30) default 'simple_graph',
	`id_agent` int unsigned NOT NULL default 0,
	`id_agent_module` bigint unsigned NULL default NULL,
	`time_lapse` int NOT NULL default 0,
	`id_graph` INTEGER UNSIGNED default 0,
	`only_average` tinyint (1) unsigned default 0 not null,
	`id_group` INT (10) unsigned NOT NULL DEFAULT 0,
	`id_module_group` INT (10) unsigned NOT NULL DEFAULT 0,
	`agent` varchar(100) NOT NULL default '',
	`module` varchar(100) NOT NULL default '',
	`id_tag` integer(10) unsigned NOT NULL DEFAULT 0,
	`type_graph` tinyint  unsigned NOT NULL DEFAULT 0,
	`fullscale` tinyint  UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id_ci`),
	FOREIGN KEY (`id_container`) REFERENCES tcontainer(`id_container`)
	ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tevento`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevento` (
	`id_evento` bigint unsigned NOT NULL auto_increment,
	`id_agente` int NOT NULL default '0',
	`id_usuario` varchar(100) NOT NULL default '0',
	`id_grupo` mediumint NOT NULL default '0',
	`estado` tinyint  unsigned NOT NULL default '0',
	`timestamp` datetime NOT NULL default '1970-01-01 00:00:00',
	`evento` text NOT NULL,
	`utimestamp` bigint NOT NULL default '0',
	`event_type` enum('going_unknown','unknown','alert_fired','alert_recovered','alert_ceased','alert_manual_validation','recon_host_detected','system','error','new_agent','going_up_warning','going_up_critical','going_down_warning','going_down_normal','going_down_critical','going_up_normal', 'configuration_change') default 'unknown',
	`id_agentmodule` int NOT NULL default '0',
	`id_alert_am` int NOT NULL default '0',
	`criticity` int unsigned NOT NULL default '0',
	`user_comment` text NOT NULL,
	`tags` text NOT NULL,
	`source` tinytext NOT NULL,
	`id_extra` tinytext NOT NULL,
	`critical_instructions` text NOT NULL,
	`warning_instructions` text NOT NULL,
	`unknown_instructions` text NOT NULL,
	`owner_user` VARCHAR(100) NOT NULL DEFAULT '',
	`ack_utimestamp` bigint NOT NULL DEFAULT '0',
	`custom_data` TEXT NOT NULL,
	`data` double(22,5) default NULL,
	`module_status` int NOT NULL default '0',
	PRIMARY KEY  (`id_evento`),
	KEY `idx_agente` (`id_agente`),
	KEY `idx_agentmodule` (`id_agentmodule`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
-- Criticity: 0 - Maintance (grey)
-- Criticity: 1 - Informational (blue)
-- Criticity: 2 - Normal (green) (status 0)
-- Criticity: 3 - Warning (yellow) (status 2)
-- Criticity: 4 - Critical (red) (status 1)

-- ---------------------------------------------------------------------
-- Table `tevent_extended`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_extended` (
	`id` serial PRIMARY KEY,
	`id_evento` bigint unsigned NOT NULL,
	`external_id` bigint unsigned,
	`utimestamp` bigint NOT NULL default '0',
	`description` text,
	FOREIGN KEY `tevent_ext_fk`(`id_evento`) REFERENCES `tevento`(`id_evento`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tgrupo`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgrupo` (
	`id_grupo` mediumint unsigned NOT NULL auto_increment,
	`nombre` varchar(100) NOT NULL default '',
	`icon` varchar(50) default 'world',
	`parent` mediumint unsigned NOT NULL default '0',
	`propagate` tinyint  unsigned NOT NULL default '0',
	`disabled` tinyint  unsigned NOT NULL default '0',
	`custom_id` varchar(255) default '',
	`id_skin` int unsigned NOT NULL default '0',
	`description` text,
	`contact` text,
	`other` text,
	`password` varchar(45) default '',
 	PRIMARY KEY  (`id_grupo`),
 	KEY `parent_index` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tcredential_store`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcredential_store` (
	`identifier` varchar(100) NOT NULL,
	`id_group` mediumint unsigned NOT NULL DEFAULT 0,
	`product` enum('CUSTOM', 'AWS', 'AZURE', 'GOOGLE', 'SAP') default 'CUSTOM',
	`username` text,
	`password` text,
	`extra_1` text,
	`extra_2` text,
	PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tincidencia`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tincidencia` (
	`id_incidencia` bigint unsigned zerofill NOT NULL auto_increment,
	`inicio` datetime NOT NULL default '1970-01-01 00:00:00',
	`cierre` datetime NOT NULL default '1970-01-01 00:00:00',
	`titulo` text NOT NULL,
	`descripcion` text NOT NULL,
	`id_usuario` varchar(60) NOT NULL default '',
	`origen` varchar(100) NOT NULL default '',
	`estado` int NOT NULL default '0',
	`prioridad` int NOT NULL default '0',
	`id_grupo` mediumint unsigned NOT NULL default '0',
	`actualizacion` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	`id_creator` varchar(60) default NULL,
	`id_lastupdate` varchar(60) default NULL,
	`id_agente_modulo` bigint NOT NULL,
	`notify_email` tinyint  unsigned NOT NULL default '0',
	`id_agent` int unsigned NULL default 0, 
	PRIMARY KEY  (`id_incidencia`),
	KEY `incident_index_1` (`id_usuario`,`id_incidencia`),
	KEY `id_agente_modulo` (`id_agente_modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tlanguage`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlanguage` (
	`id_language` varchar(6) NOT NULL default '',
	`name` varchar(100) NOT NULL default '',
	PRIMARY KEY  (`id_language`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tlink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlink` (
	`id_link` int unsigned zerofill NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`link` varchar(255) NOT NULL default '',
	PRIMARY KEY  (`id_link`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tmodule_group`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmodule_group` (
	`id_mg` tinyint  unsigned NOT NULL auto_increment,
	`name` varchar(150) NOT NULL default '',
	PRIMARY KEY  (`id_mg`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- This table was moved cause the `tmodule_relationship` will add
-- a foreign key for the trecon_task(id_rt)
-- ----------------------------------------------------------------------
-- Table `trecon_task`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `trecon_task` (
	`id_rt` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`description` varchar(250) NOT NULL default '',
	`subnet` text NOT NULL,
	`id_network_profile` text,
	`review_mode` tinyint  unsigned NOT NULL default 1,
	`id_group` int unsigned NOT NULL default 1,
	`utimestamp` bigint unsigned NOT NULL default 0,
	`status` tinyint  NOT NULL default 0,
	`interval_sweep` int unsigned NOT NULL default 0,
	`id_recon_server` int unsigned NOT NULL default 0,
	`id_os` tinyint  NOT NULL default 0,
	`recon_ports` varchar(250) NOT NULL default '',
	`snmp_community` varchar(64) NOT NULL default 'public',
	`id_recon_script` int,
	`field1` text NOT NULL,
	`field2` varchar(250) NOT NULL default '',
	`field3` varchar(250) NOT NULL default '',
	`field4` varchar(250) NOT NULL default '',
	`os_detect` tinyint  unsigned default 0,
	`resolve_names` tinyint  unsigned default 0,
	`parent_detection` tinyint  unsigned default 0,
	`parent_recursion` tinyint  unsigned default 0,
	`disabled` tinyint  unsigned NOT NULL DEFAULT 0,
	`macros` TEXT,
	`alias_as_name` tinyint  NOT NULL default 0,
	`snmp_enabled` tinyint  unsigned default 0,
	`vlan_enabled` tinyint  unsigned default 0,
	`snmp_version` varchar(5) NOT NULL default 1,
	`snmp_auth_user` varchar(255) NOT NULL default '',
	`snmp_auth_pass` varchar(255) NOT NULL default '',
	`snmp_auth_method` varchar(25) NOT NULL default '',
	`snmp_privacy_method` varchar(25) NOT NULL default '',
	`snmp_privacy_pass` varchar(255) NOT NULL default '',
	`snmp_security_level` varchar(25) NOT NULL default '',
	`wmi_enabled` tinyint  unsigned DEFAULT 0,
	`rcmd_enabled` tinyint  unsigned DEFAULT 0,
	`auth_strings` text,
	`auto_monitor` tinyint  UNSIGNED DEFAULT 1,
	`autoconfiguration_enabled` tinyint  unsigned default 0,
	`summary` text,
	`type` int NOT NULL default 0,
	`subnet_csv` tinyint  UNSIGNED DEFAULT 0,
	PRIMARY KEY  (`id_rt`),
	KEY `recon_task_daemon` (`id_recon_server`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tdiscovery_tmp`
-- ----------------------------------------------------------------------
CREATE TABLE `tdiscovery_tmp_agents` (
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`id_rt` int unsigned NOT NULL,
	`label` varchar(600) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
	`data` MEDIUMTEXT,
	`review_date` datetime DEFAULT NULL,
	`created` datetime DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY `id_rt` (`id_rt`),
	INDEX `label` (`label`),
	CONSTRAINT `tdta_trt` FOREIGN KEY (`id_rt`) REFERENCES `trecon_task` (`id_rt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE `tdiscovery_tmp_connections` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_rt` int unsigned NOT NULL,
  `dev_1` text,
  `dev_2` text,
  `if_1` text,
  `if_2` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tmodule_relationship`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmodule_relationship` (
	`id` int unsigned NOT NULL auto_increment,
	`id_rt` int unsigned DEFAULT NULL,
	`id_server` varchar(100) NOT NULL DEFAULT '',
	`module_a` int unsigned NOT NULL,
	`module_b` int unsigned NOT NULL,
	`disable_update` tinyint  unsigned NOT NULL default '0',
	`type` ENUM('direct', 'failover') DEFAULT 'direct',
	PRIMARY KEY (`id`),
	FOREIGN KEY (`module_a`) REFERENCES tagente_modulo(`id_agente_modulo`)
		ON DELETE CASCADE,
	FOREIGN KEY (`module_b`) REFERENCES tagente_modulo(`id_agente_modulo`)
		ON DELETE CASCADE,
	FOREIGN KEY (`id_rt`) REFERENCES trecon_task(`id_rt`)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnetwork_component`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_component` (
	`id_nc` int unsigned NOT NULL auto_increment,
	`name` text NOT NULL,
	`description` TEXT NOT NULL,
	`id_group` int NOT NULL default '1',
	`type` smallint(6) NOT NULL default '6',
	`max` bigint NOT NULL default '0',
	`min` bigint NOT NULL default '0',
	`module_interval` mediumint unsigned NOT NULL default '0',
	`tcp_port` int unsigned NOT NULL default '0',
	`tcp_send` text NOT NULL,
	`tcp_rcv` text NOT NULL,
	`snmp_community` varchar(255) NOT NULL default 'NULL',
	`snmp_oid` varchar(400) NOT NULL,
	`id_module_group` tinyint  unsigned NOT NULL default '0',
	`id_modulo` int unsigned default '0',
	`id_plugin` INTEGER unsigned default '0',
	`plugin_user` text,
	`plugin_pass` text,
	`plugin_parameter` text,
	`max_timeout` int unsigned default '0',
	`max_retries` int unsigned default '0',
	`history_data` tinyint  unsigned default '1',
	`min_warning` double(18,2) default 0,
	`max_warning` double(18,2) default 0,
	`str_warning` text,
	`min_critical` double(18,2) default 0,
	`max_critical` double(18,2) default 0,
	`str_critical` text,
	`min_ff_event` int unsigned default '0',
	`custom_string_1` text,
	`custom_string_2` text,
	`custom_string_3` text,
	`custom_integer_1` int default 0,
	`custom_integer_2` int default 0,
	`post_process` double(24,15) default 0,
	`unit` text,
	`wizard_level` enum('basic','advanced','nowizard') default 'nowizard',
	`macros` text,
	`critical_instructions` text NOT NULL,
	`warning_instructions` text NOT NULL,
	`unknown_instructions` text NOT NULL,
	`critical_inverse` tinyint  unsigned default '0',
	`warning_inverse` tinyint  unsigned default '0',
	`id_category` int default 0,
	`tags` text NOT NULL,
	`disabled_types_event` TEXT NOT NULL,
	`module_macros` TEXT NOT NULL,
	`min_ff_event_normal` int unsigned default '0',
	`min_ff_event_warning` int unsigned default '0',
	`min_ff_event_critical` int unsigned default '0',
	`ff_type` tinyint  unsigned default '0',
	`each_ff` tinyint  unsigned default '0',
	`dynamic_interval` int unsigned default '0',
	`dynamic_max` int default '0',
	`dynamic_min` int default '0',
	`dynamic_next` bigint NOT NULL default '0',
	`dynamic_two_tailed` tinyint  unsigned default '0',
	`module_type` tinyint  unsigned NOT NULL DEFAULT 1,
	`protocol` tinytext NOT NULL,
	`manufacturer_id` varchar(200) NOT NULL,
	`execution_type` tinyint  unsigned NOT NULL DEFAULT 1,
	`scan_type` tinyint  unsigned NOT NULL DEFAULT 1,
	`value` text NOT NULL,
	`value_operations` text NOT NULL,
	`module_enabled` tinyint  unsigned DEFAULT 0,
	`name_oid` varchar(255) NOT NULL,
	`query_class` varchar(200) NOT NULL,
	`query_key_field` varchar(200) NOT NULL,
	`scan_filters` text NOT NULL,
	`query_filters` text NOT NULL,
	`enabled` tinyint  UNSIGNED DEFAULT 1,
	PRIMARY KEY  (`id_nc`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnetwork_component_group`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_component_group` (
	`id_sg`  int unsigned NOT NULL auto_increment,
	`name` varchar(200) NOT NULL default '',
	`parent` mediumint unsigned NOT NULL default '0',
	PRIMARY KEY  (`id_sg`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnetwork_profile`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_profile` (
	`id_np`  int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`description` varchar(250) default '',
	PRIMARY KEY  (`id_np`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnetwork_profile_component`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_profile_component` (
	`id_nc` mediumint unsigned NOT NULL default '0',
	`id_np` mediumint unsigned NOT NULL default '0',
	KEY `id_np` (`id_np`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tpen`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpen` (
  `pen` int unsigned NOT NULL,
  `manufacturer` TEXT,
  `description` TEXT,
  PRIMARY KEY (`pen`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnetwork_profile_pen`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_profile_pen` (
  `pen` int unsigned NOT NULL,
  `id_np` int unsigned NOT NULL,
  CONSTRAINT `fk_network_profile_pen_pen` FOREIGN KEY (`pen`)
    REFERENCES `tpen` (`pen`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_network_profile_pen_id_np` FOREIGN KEY (`id_np`)
    REFERENCES `tnetwork_profile` (`id_np`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnota`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnota` (
	`id_nota` bigint unsigned zerofill NOT NULL auto_increment,
	`id_incident` bigint unsigned zerofill NOT NULL,
	`id_usuario` varchar(100) NOT NULL default '0',
	`timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
	`nota` mediumtext NOT NULL,
	PRIMARY KEY  (`id_nota`),
	KEY `id_incident` (`id_incident`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `torigen`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `torigen` (
	`origen` varchar(100) NOT NULL default ''
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tperfil`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tperfil` (
	`id_perfil` int unsigned NOT NULL auto_increment,
	`name` TEXT NOT NULL,
	`incident_edit` tinyint  NOT NULL DEFAULT 0,
	`incident_view` tinyint  NOT NULL DEFAULT 0,
	`incident_management` tinyint  NOT NULL DEFAULT 0,
	`agent_view` tinyint  NOT NULL DEFAULT 0,
	`agent_edit` tinyint  NOT NULL DEFAULT 0,
	`alert_edit` tinyint  NOT NULL DEFAULT 0,
	`user_management` tinyint  NOT NULL DEFAULT 0,
	`db_management` tinyint  NOT NULL DEFAULT 0,
	`alert_management` tinyint  NOT NULL DEFAULT 0,
	`pandora_management` tinyint  NOT NULL DEFAULT 0,
	`report_view` tinyint  NOT NULL DEFAULT 0,
	`report_edit` tinyint  NOT NULL DEFAULT 0,
	`report_management` tinyint  NOT NULL DEFAULT 0,
	`event_view` tinyint  NOT NULL DEFAULT 0,
	`event_edit` tinyint  NOT NULL DEFAULT 0,
	`event_management` tinyint  NOT NULL DEFAULT 0,
	`agent_disable` tinyint  NOT NULL DEFAULT 0,
	`map_view` tinyint  NOT NULL DEFAULT 0,
	`map_edit` tinyint  NOT NULL DEFAULT 0,
	`map_management` tinyint  NOT NULL DEFAULT 0,
	`vconsole_view` tinyint  NOT NULL DEFAULT 0,
	`vconsole_edit` tinyint  NOT NULL DEFAULT 0,
	`vconsole_management` tinyint  NOT NULL DEFAULT 0,
	PRIMARY KEY  (`id_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `trecon_script`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `trecon_script` (
	`id_recon_script` int NOT NULL auto_increment,
	`name` varchar(100) default '',
	`description` TEXT,
	`script` varchar(250) default '',
	`macros` TEXT,
	`type` int NOT NULL default 0,
	PRIMARY KEY  (`id_recon_script`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tserver`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tserver` (
	`id_server` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`ip_address` varchar(100) NOT NULL default '',
	`status` int NOT NULL default '0',
	`laststart` datetime NOT NULL default '1970-01-01 00:00:00',
	`keepalive` datetime NOT NULL default '1970-01-01 00:00:00',
	`snmp_server` tinyint  unsigned NOT NULL default '0',
	`network_server` tinyint  unsigned NOT NULL default '0',
	`data_server` tinyint  unsigned NOT NULL default '0',
	`master` tinyint  unsigned NOT NULL default '0',
	`checksum` tinyint  unsigned NOT NULL default '0',
	`description` varchar(255) default NULL,
	`recon_server` tinyint  unsigned NOT NULL default '0',
	`version` varchar(25) NOT NULL default '',
	`plugin_server` tinyint  unsigned NOT NULL default '0',
	`prediction_server` tinyint  unsigned NOT NULL default '0',
	`wmi_server` tinyint  unsigned NOT NULL default '0',
	`export_server` tinyint  unsigned NOT NULL default '0',
	`server_type` tinyint  unsigned NOT NULL default '0',
	`queued_modules` int unsigned NOT NULL default '0',
	`threads` int unsigned NOT NULL default '0',
	`lag_time` int NOT NULL default 0,
	`lag_modules` int NOT NULL default 0,
	`total_modules_running` int NOT NULL default 0,
	`my_modules` int NOT NULL default 0,
	`server_keepalive` int NOT NULL default 0,
	`stat_utimestamp` bigint NOT NULL default '0',
	`exec_proxy` tinyint  UNSIGNED NOT NULL default 0,
	`port` int unsigned NOT NULL default 0,
	PRIMARY KEY  (`id_server`),
	KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
-- server types:
-- 0 data
-- 1 network
-- 2 snmp trap console
-- 3 recon
-- 4 plugin
-- 5 prediction
-- 6 wmi
-- 7 export
-- 8 inventory
-- 9 web
-- TODO: drop 2.x xxxx_server fields, unused since server_type exists.

-- ----------------------------------------------------------------------
-- Table `tsesion`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tsesion` (
	`id_sesion` bigint unsigned NOT NULL auto_increment,
	`id_usuario` varchar(60) NOT NULL default '0',
	`ip_origen` varchar(100) NOT NULL default '',
	`accion` varchar(100) NOT NULL default '',
	`descripcion` text NOT NULL,
	`fecha` datetime NOT NULL default '1970-01-01 00:00:00',
	`utimestamp` bigint unsigned NOT NULL default '0',
	PRIMARY KEY  (`id_sesion`),
	KEY `idx_user` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `ttipo_modulo`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttipo_modulo` (
	`id_tipo` smallint(5) unsigned NOT NULL auto_increment,
	`nombre` varchar(100) NOT NULL default '',
	`categoria` int NOT NULL default '0',
	`descripcion` varchar(100) NOT NULL default '',
	`icon` varchar(100) default NULL,
	PRIMARY KEY  (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `ttrap`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttrap` (
	`id_trap` bigint unsigned NOT NULL auto_increment,
	`source` varchar(50) NOT NULL default '',
	`oid` text NOT NULL,
	`oid_custom` text,
	`type` int NOT NULL default '0',
	`type_custom` varchar(100) default '',
	`value` text,
	`value_custom` text,
	`alerted` smallint(6) NOT NULL default '0',
	`status` smallint(6) NOT NULL default '0',
	`id_usuario` varchar(150) default '',
	`timestamp` datetime NOT NULL default '1970-01-01 00:00:00',
	`priority` tinyint  unsigned NOT NULL default '2',
	`text` varchar(255) default '',
	`description` varchar(255) default '',
	`severity` tinyint  unsigned NOT NULL default '2',
	PRIMARY KEY  (`id_trap`),
	INDEX timestamp (`timestamp`),
	INDEX status (`status`),
	INDEX source (`source`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tevent_filter`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_filter` (
	`id_filter`  int unsigned NOT NULL auto_increment,
	`id_group_filter` int NOT NULL default 0,
	`id_name` varchar(600) NOT NULL,
	`id_group` int NOT NULL default 0,
	`event_type` text NOT NULL,
	`severity` text NOT NULL,
	`status` int NOT NULL default -1,
	`search` TEXT,
	`text_agent` TEXT,
	`id_agent` int default 0,
	`id_agent_module` int default 0,
	`pagination` int NOT NULL default 25,
	`event_view_hr` int NOT NULL default 8,
	`id_user_ack` TEXT,
	`group_rep` int NOT NULL default 0,
	`tag_with` text NOT NULL,
	`tag_without` text NOT NULL,
	`filter_only_alert` int NOT NULL default -1,
	`date_from` date default NULL,
	`date_to` date default NULL,
	`source` tinytext NOT NULL,
	`id_extra` tinytext NOT NULL,
	`user_comment` text NOT NULL,
	`id_source_event` int  NULL default 0,
	PRIMARY KEY  (`id_filter`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tusuario`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tusuario` (
	`id_user` varchar(60) NOT NULL default '0',
	`fullname` varchar(255) NOT NULL,
	`firstname` varchar(255) NOT NULL,
	`lastname` varchar(255) NOT NULL,
	`middlename` varchar(255) NOT NULL,
	`password` varchar(45) default NULL,
	`comments` varchar(200) default NULL,
	`last_connect` bigint NOT NULL default '0',
	`registered` bigint NOT NULL default '0',
	`email` varchar(100) default NULL,
	`phone` varchar(100) default NULL,
	`is_admin` tinyint  unsigned NOT NULL default '0',
	`language` varchar(10) default NULL,
	`timezone` varchar(50) default '',
	`block_size` int NOT NULL DEFAULT 20,
	`id_skin` int unsigned NOT NULL DEFAULT 0,
	`disabled` int NOT NULL DEFAULT 0,
	`shortcut` tinyint  DEFAULT 0,
	`shortcut_data` text,
	`section` TEXT NOT NULL,
	`data_section` TEXT NOT NULL,
	`force_change_pass` tinyint  unsigned NOT NULL default 0,
	`last_pass_change` DATETIME  NOT NULL DEFAULT 0,
	`last_failed_login` DATETIME  NOT NULL DEFAULT 0,
	`failed_attempt` int NOT NULL DEFAULT 0,
	`login_blocked` tinyint  unsigned NOT NULL default 0,
	`metaconsole_access` enum('basic','advanced') default 'basic',
	`not_login` tinyint  unsigned NOT NULL DEFAULT 0,
	`metaconsole_agents_manager` tinyint  unsigned NOT NULL default 0,
	`metaconsole_assigned_server` int unsigned NOT NULL default 0,
	`metaconsole_access_node` tinyint  unsigned NOT NULL default 0,
	`strict_acl` tinyint  unsigned NOT NULL DEFAULT 0,
	`id_filter`  int unsigned NULL default NULL,
	`session_time` int signed NOT NULL default 0,
	`default_event_filter` int unsigned NOT NULL default 0,
	`autorefresh_white_list` text not null default '',
	`time_autorefresh` int unsigned NOT NULL default '30',
	`default_custom_view` int unsigned NULL default '0',
	`ehorus_user_level_user` VARCHAR(60),
	`ehorus_user_level_pass` VARCHAR(45),
	`ehorus_user_level_enabled` tinyint ,
	CONSTRAINT `fk_filter_id` FOREIGN KEY (`id_filter`) REFERENCES tevent_filter (`id_filter`) ON DELETE SET NULL,
	UNIQUE KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tusuario_perfil`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tusuario_perfil` (
	`id_up` bigint unsigned NOT NULL auto_increment,
	`id_usuario` varchar(100) NOT NULL default '',
	`id_perfil` int unsigned NOT NULL default '0',
	`id_grupo` int NOT NULL default '0',
	`no_hierarchy` tinyint  NOT NULL default 0,
	`assigned_by` varchar(100) NOT NULL default '',
	`id_policy` int unsigned NOT NULL default '0',
	`tags` text NOT NULL,
	PRIMARY KEY  (`id_up`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tuser_double_auth`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tuser_double_auth` (
	`id` int unsigned NOT NULL auto_increment,
	`id_user` varchar(60) NOT NULL,
	`secret` varchar(20) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE (`id_user`),
	FOREIGN KEY (`id_user`) REFERENCES tusuario(`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `treset_pass_history`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `treset_pass_history` (
	`id` int unsigned NOT NULL auto_increment,
	`id_user` varchar(60) NOT NULL,
	`reset_moment` datetime NOT NULL,
	`success` tinyint  NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tnotification_source`
-- -----------------------------------------------------
CREATE TABLE `tnotification_source` (
    `id` serial,
    `description` VARCHAR(255) DEFAULT NULL,
    `icon` text,
    `max_postpone_time` int DEFAULT NULL,
    `enabled` int DEFAULT NULL,
    `user_editable` int DEFAULT NULL,
    `also_mail` int DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tmensajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmensajes` (
	`id_mensaje` int UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_usuario_origen` VARCHAR(60) NOT NULL DEFAULT '',
	`mensaje` TEXT NOT NULL,
	`timestamp` bigint UNSIGNED NOT NULL DEFAULT '0',
	`subject` VARCHAR(255) NOT NULL DEFAULT '',
	`estado` int UNSIGNED NOT NULL DEFAULT '0',
	`url` TEXT,
	`response_mode` VARCHAR(200) DEFAULT NULL,
	`citicity` int UNSIGNED DEFAULT '0',
	`id_source` bigint UNSIGNED NOT NULL,
	`subtype` VARCHAR(255) DEFAULT '',
	`hidden_sent` tinyint  UNSIGNED DEFAULT 0,
	PRIMARY KEY (`id_mensaje`),
	UNIQUE KEY `id_mensaje` (`id_mensaje`),
	KEY `tsource_fk` (`id_source`),
	CONSTRAINT `tsource_fk` FOREIGN KEY (`id_source`) REFERENCES `tnotification_source` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnotification_user`
-- ----------------------------------------------------------------------
CREATE TABLE `tnotification_user` (
    `id_mensaje` int UNSIGNED NOT NULL,
    `id_user` VARCHAR(60) NOT NULL,
    `utimestamp_read` bigint,
    `utimestamp_erased` bigint,
    `postpone` INT,
    PRIMARY KEY (`id_mensaje`,`id_user`),
    FOREIGN KEY (`id_mensaje`) REFERENCES `tmensajes`(`id_mensaje`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`id_user`) REFERENCES `tusuario`(`id_user`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnotification_group`
-- ----------------------------------------------------------------------
CREATE TABLE `tnotification_group` (
	`id_mensaje` int UNSIGNED NOT NULL,
	`id_group` mediumint UNSIGNED NOT NULL,
	PRIMARY KEY (`id_mensaje`,`id_group`),
	FOREIGN KEY (`id_mensaje`) REFERENCES `tmensajes`(`id_mensaje`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnotification_source_user`
-- ----------------------------------------------------------------------
CREATE TABLE `tnotification_source_user` (
    `id_source` bigint UNSIGNED NOT NULL,
    `id_user` VARCHAR(60),
    `enabled` int DEFAULT NULL,
    `also_mail` int DEFAULT NULL,
    PRIMARY KEY (`id_source`,`id_user`),
    FOREIGN KEY (`id_source`) REFERENCES `tnotification_source`(`id`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`id_user`) REFERENCES `tusuario`(`id_user`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnotification_source_group`
-- ----------------------------------------------------------------------
CREATE TABLE `tnotification_source_group` (
    `id_source` bigint UNSIGNED NOT NULL,
    `id_group` mediumint unsigned NOT NULL,
    PRIMARY KEY (`id_source`,`id_group`),
	INDEX (`id_group`),
    FOREIGN KEY (`id_source`) REFERENCES `tnotification_source`(`id`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnotification_source_user`
-- ----------------------------------------------------------------------
CREATE TABLE `tnotification_source_group_user` (
    `id_source` bigint UNSIGNED NOT NULL,
    `id_group` mediumint unsigned NOT NULL,
    `id_user` VARCHAR(60),
    `enabled` int DEFAULT NULL,
    `also_mail` int DEFAULT NULL,
    PRIMARY KEY (`id_source`,`id_user`),
    FOREIGN KEY (`id_source`) REFERENCES `tnotification_source`(`id`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`id_user`) REFERENCES `tusuario`(`id_user`)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`id_group`) REFERENCES `tnotification_source_group`(`id_group`)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnews`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnews` (
	`id_news` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`author` varchar(255)  NOT NULL DEFAULT '',
	`subject` varchar(255)  NOT NULL DEFAULT '',
	`text` TEXT NOT NULL,
	`timestamp` DATETIME  NOT NULL DEFAULT 0,
	`id_group` int NOT NULL default 0,
	`modal` tinyint  DEFAULT 0,
	`expire` tinyint  DEFAULT 0,
	`expire_timestamp` DATETIME  NOT NULL DEFAULT 0,
	PRIMARY KEY(`id_news`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tgraph`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgraph` (
	`id_graph` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`id_user` varchar(100) NOT NULL default '',
	`name` varchar(150) NOT NULL default '',
	`description` TEXT NOT NULL,
	`period` int NOT NULL default '0',
	`width` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`height` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`private` tinyint  UNSIGNED NOT NULL default 0,
	`events` tinyint  UNSIGNED NOT NULL default 0,
	`stacked` tinyint  UNSIGNED NOT NULL default 0,
	`id_group` mediumint unsigned NULL default 0,
	`id_graph_template` int NOT NULL default 0,
	`percentil` tinyint  UNSIGNED NOT NULL default 0,
	`summatory_series` tinyint  UNSIGNED NOT NULL default 0,
	`average_series` tinyint  UNSIGNED NOT NULL default 0,
	`modules_series` tinyint  UNSIGNED NOT NULL default 0,
	`fullscale` tinyint  UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id_graph`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tgraph_source`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgraph_source` (
	`id_gs` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`id_graph` int NOT NULL default 0,
	`id_server` int NOT NULL default 0,
	`id_agent_module` int NOT NULL default 0,
	`weight` float(8,3) NOT NULL DEFAULT 0,
	`label` varchar(150) DEFAULT '',
	`field_order` int DEFAULT 0,
	PRIMARY KEY(`id_gs`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `treport`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport` (
	`id_report` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`id_user` varchar(100) NOT NULL default '',
	`name` varchar(150) NOT NULL default '',
	`description` TEXT NOT NULL,
	`private` tinyint  UNSIGNED NOT NULL default 0,
	`id_group` mediumint unsigned NULL default NULL,
	`custom_logo` varchar(200)  default NULL,
	`header` MEDIUMTEXT,
	`first_page` MEDIUMTEXT,
	`footer` MEDIUMTEXT,
	`custom_font` varchar(200) default NULL,
	`id_template` INTEGER UNSIGNED DEFAULT 0,
	`id_group_edit` mediumint unsigned NULL DEFAULT 0,
	`metaconsole` tinyint  DEFAULT 0,
	`non_interactive` tinyint  UNSIGNED NOT NULL default 0,
	`hidden` tinyint  DEFAULT 0,
	`orientation` varchar(25) NOT NULL default 'vertical',
	`cover_page_render` tinyint  NOT NULL DEFAULT 1,
	`index_render` tinyint  NOT NULL DEFAULT 1,
	PRIMARY KEY(`id_report`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `treport_content`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_content` (
	`id_rc` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_report` INTEGER UNSIGNED NOT NULL default 0,
	`id_gs` INTEGER UNSIGNED NULL default NULL,
	`id_agent_module` bigint unsigned NULL default NULL,
	`type` varchar(30) default 'simple_graph',
	`period` int NOT NULL default 0,
	`order` int (11) NOT NULL default 0,
	`name` varchar(300) NULL,
	`description` mediumtext,
	`id_agent` int unsigned NOT NULL default 0,
	`text` TEXT,
	`external_source` Text,
	`treport_custom_sql_id` INTEGER UNSIGNED default 0,
	`header_definition` TinyText,
	`column_separator` TinyText,
	`line_separator` TinyText,
	`time_from` time default '00:00:00',
	`time_to` time default '00:00:00',
	`monday` tinyint  default 1,
	`tuesday` tinyint  default 1,
	`wednesday` tinyint  default 1,
	`thursday` tinyint  default 1,
	`friday` tinyint  default 1,
	`saturday` tinyint  default 1,
	`sunday` tinyint  default 1,
	`only_display_wrong` tinyint (1) unsigned default 0 not null,
	`top_n` INT NOT NULL default 0,
	`top_n_value` INT NOT NULL default 10,
	`exception_condition` INT NOT NULL default 0,
	`exception_condition_value` DOUBLE (18,6) NOT NULL default 0,
	`show_resume` INT NOT NULL default 0,
	`order_uptodown` INT NOT NULL default 0,
	`show_graph` INT NOT NULL default 0,
	`group_by_agent` INT NOT NULL default 0,
	`style` TEXT NOT NULL,
	`id_group` INT (10) unsigned NOT NULL DEFAULT 0,
	`id_module_group` INT (10) unsigned NOT NULL DEFAULT 0,
	`server_name` text,
	`historical_db` tinyint  UNSIGNED NOT NULL default 0,
	`lapse_calc` tinyint  UNSIGNED NOT NULL default '0',
	`lapse` int UNSIGNED NOT NULL default '300',
	`visual_format` tinyint  UNSIGNED NOT NULL default '0',
	`hide_no_data` tinyint  default 0,
	`recursion` tinyint  default NULL,
	`show_extended_events` tinyint  default '0',
	`total_time` tinyint  DEFAULT '1',
	`time_failed` tinyint  DEFAULT '1',
	`time_in_ok_status` tinyint  DEFAULT '1',
	`time_in_unknown_status` tinyint  DEFAULT '1',
	`time_of_not_initialized_module` tinyint  DEFAULT '1',
	`time_of_downtime` tinyint  DEFAULT '1',
	`total_checks` tinyint  DEFAULT '1',
	`checks_failed` tinyint  DEFAULT '1',
	`checks_in_ok_status` tinyint  DEFAULT '1',
	`unknown_checks` tinyint  DEFAULT '1',
	`agent_max_value` tinyint  DEFAULT '1',
	`agent_min_value` tinyint  DEFAULT '1',
	`current_month` tinyint  DEFAULT '1',
	`failover_mode` tinyint  DEFAULT '1',
	`failover_type` tinyint  DEFAULT '1',
	`uncompressed_module` TINYINT DEFAULT '0',
	`landscape` tinyint  UNSIGNED NOT NULL default 0,
	`pagebreak` tinyint  UNSIGNED NOT NULL default 0,
	`compare_work_time` tinyint  UNSIGNED NOT NULL default 0,
	`graph_render` tinyint  UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id_rc`),
	FOREIGN KEY (`id_report`) REFERENCES treport(`id_report`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `treport_content_sla_combined`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_content_sla_combined` (
	`id` INTEGER UNSIGNED NOT NULL auto_increment,
	`id_report_content` INTEGER UNSIGNED NOT NULL,
	`id_agent_module` int unsigned NOT NULL,
	`id_agent_module_failover` int unsigned NOT NULL,
	`sla_max` double(18,2) NOT NULL default 0,
	`sla_min` double(18,2) NOT NULL default 0,
	`sla_limit` double(18,2) NOT NULL default 0,
	`server_name` text,
	PRIMARY KEY(`id`),
	FOREIGN KEY (`id_report_content`) REFERENCES treport_content(`id_rc`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `treport_content_item`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_content_item` (
	`id` INTEGER UNSIGNED NOT NULL auto_increment,
	`id_report_content` INTEGER UNSIGNED NOT NULL,
	`id_agent_module` int unsigned NOT NULL,
	`id_agent_module_failover` int unsigned NOT NULL DEFAULT 0,
	`server_name` text,
	`operation` text,
	PRIMARY KEY(`id`),
	FOREIGN KEY (`id_report_content`) REFERENCES treport_content(`id_rc`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `treport_custom_sql`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_custom_sql` (
	`id` INTEGER UNSIGNED NOT NULL auto_increment,
	`name` varchar(150) NOT NULL default '',
	`sql` TEXT,
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tlayout`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlayout` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(600)  NOT NULL,
	`id_group` INTEGER UNSIGNED NOT NULL,
	`background` varchar(200)  NOT NULL,
	`height` INTEGER UNSIGNED NOT NULL default 0,
	`width` INTEGER UNSIGNED NOT NULL default 0,
	`background_color` varchar(50) NOT NULL default '#FFF',
	`is_favourite` INTEGER UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id`)
)  ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tlayout_data`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlayout_data` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_layout` INTEGER UNSIGNED NOT NULL default 0,
	`pos_x` INTEGER UNSIGNED NOT NULL default 0,
	`pos_y` INTEGER UNSIGNED NOT NULL default 0,
	`height` INTEGER UNSIGNED NOT NULL default 0,
	`width` INTEGER UNSIGNED NOT NULL default 0,
	`label` TEXT,
	`image` varchar(200) DEFAULT "",
	`type` tinyint  UNSIGNED NOT NULL default 0,
	`period` INTEGER UNSIGNED NOT NULL default 3600,
	`id_agente_modulo` mediumint unsigned NOT NULL default '0',
	`id_agent` int unsigned NOT NULL default 0,
	`id_layout_linked` INTEGER unsigned NOT NULL default '0',
	`parent_item` INTEGER UNSIGNED NOT NULL default 0,
	`enable_link` tinyint  UNSIGNED NOT NULL default 1,
	`id_metaconsole` int NOT NULL default 0,
	`id_group` INTEGER UNSIGNED NOT NULL default 0,
	`id_custom_graph` INTEGER UNSIGNED NOT NULL default 0,
	`border_width` INTEGER UNSIGNED NOT NULL default 0,
	`type_graph` varchar(50) NOT NULL default 'area',
	`label_position` varchar(50) NOT NULL default 'down',
	`border_color` varchar(200) DEFAULT "",
	`fill_color` varchar(200) DEFAULT "",
	`show_statistics` tinyint  NOT NULL default '0',
	`linked_layout_node_id` int NOT NULL default 0,
	`linked_layout_status_type` ENUM ('default', 'weight', 'service') DEFAULT 'default',
	`id_layout_linked_weight` int NOT NULL default '0',
	`linked_layout_status_as_service_warning` FLOAT(20, 3) NOT NULL default 0,
	`linked_layout_status_as_service_critical` FLOAT(20, 3) NOT NULL default 0,
	`element_group` int NOT NULL default '0',
	`show_on_top` tinyint  NOT NULL default '0',
	`clock_animation` varchar(60) NOT NULL default "analogic_1",
	`time_format` varchar(60) NOT NULL default "time",
	`timezone` varchar(60) NOT NULL default "Europe/Madrid",
	`show_last_value` tinyint  UNSIGNED NULL default '0',
	`cache_expiration` INTEGER UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tplugin`
-- ---------------------------------------------------------------------
-- The fields "net_dst_opt", "net_port_opt", "user_opt" and
-- "pass_opt" are deprecated for the 5.1.
CREATE TABLE IF NOT EXISTS `tplugin` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(200) NOT NULL,
	`description` mediumtext,
	`max_timeout` int UNSIGNED NOT NULL default 0,
	`max_retries` int UNSIGNED NOT NULL default 0,
	`execute` varchar(250) NOT NULL,
	`net_dst_opt` varchar(50) default '',
	`net_port_opt` varchar(50) default '',
	`user_opt` varchar(50) default '',
	`pass_opt` varchar(50) default '',
	`plugin_type` int UNSIGNED NOT NULL default 0,
	`macros` text,
	`parameters` text,
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4; 

-- ---------------------------------------------------------------------
-- Table `tmodule`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmodule` (
	`id_module` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	PRIMARY KEY (`id_module`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tserver_export`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tserver_export` (
	`id` int unsigned NOT NULL auto_increment,
	`name` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`preffix` varchar(100) NOT NULL default '',
	`interval` int unsigned NOT NULL default '300',
	`ip_server` varchar(100) NOT NULL default '',
	`connect_mode` enum ('tentacle', 'ssh', 'local') default 'local',
	`id_export_server` int unsigned default NULL,
	`user` varchar(100) NOT NULL default '',
	`pass` varchar(100) NOT NULL default '',
	`port` int unsigned default '0',
	`directory` varchar(100) NOT NULL default '',
	`options` varchar(100) NOT NULL default '',
	`timezone_offset` tinyint  NULL DEFAULT '0' COMMENT 'Number of hours of diference with the server timezone' ,
	PRIMARY KEY  (`id`),
	INDEX id_export_server (`id_export_server`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tserver_export_data`
-- ---------------------------------------------------------------------
-- id_export_server is real pandora fms export server process that manages this server
-- id is the "destination" server to export
CREATE TABLE IF NOT EXISTS `tserver_export_data` (
	`id` int unsigned NOT NULL auto_increment,
	`id_export_server` int unsigned default NULL,
	`agent_name` varchar(100) NOT NULL default '',
	`module_name` varchar(600) NOT NULL default '',
	`module_type` varchar(100) NOT NULL default '',
	`data` varchar(255) default NULL, 
	`timestamp` datetime NOT NULL default '1970-01-01 00:00:00',
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tplanned_downtime`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tplanned_downtime` (
	`id` MEDIUMINT( 8 ) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR( 100 ) NOT NULL,
	`description` TEXT NOT NULL,
	`date_from` bigint NOT NULL default '0',
	`date_to` bigint NOT NULL default '0',
	`executed` tinyint  UNSIGNED NOT NULL default 0,
	`id_group` mediumint unsigned NULL default 0,
	`only_alerts` tinyint  UNSIGNED NOT NULL default 0,
	`monday` tinyint  default 0,
	`tuesday` tinyint  default 0,
	`wednesday` tinyint  default 0,
	`thursday` tinyint  default 0,
	`friday` tinyint  default 0,
	`saturday` tinyint  default 0,
	`sunday` tinyint  default 0,
	`periodically_time_from` time NULL default NULL,
	`periodically_time_to` time NULL default NULL,
	`periodically_day_from` int unsigned default NULL,
	`periodically_day_to` int unsigned default NULL,
	`type_downtime` varchar(100) NOT NULL default 'disabled_agents_alerts',
	`type_execution` varchar(100) NOT NULL default 'once',
	`type_periodicity` varchar(100) NOT NULL default 'weekly',
	`id_user` varchar(100) NOT NULL default '0',
	PRIMARY KEY (  `id` ) 
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tplanned_downtime_agents`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tplanned_downtime_agents` (
	`id` int unsigned NOT NULL auto_increment,
	`id_agent` mediumint unsigned NOT NULL default '0',
	`id_downtime` mediumint NOT NULL default '0',
	`all_modules` tinyint  default 1,
	`manually_disabled` tinyint  default 0,
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_downtime`) REFERENCES tplanned_downtime(`id`)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tplanned_downtime_modules`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tplanned_downtime_modules` (
	`id` int unsigned NOT NULL auto_increment,
	`id_agent` mediumint unsigned NOT NULL default '0',
	`id_agent_module` int NOT NULL, 
	`id_downtime` mediumint NOT NULL default '0',
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_downtime`) REFERENCES tplanned_downtime(`id`)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- GIS extension Tables
-- ----------------------------------------------------------------------
-- Table `tgis_data_history`
-- ----------------------------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_data_history` (
	`id_tgis_data` INT NOT NULL AUTO_INCREMENT COMMENT 'key of the table' ,
	`longitude` DOUBLE NOT NULL ,
	`latitude` DOUBLE NOT NULL ,
	`altitude` DOUBLE NULL ,
	`start_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'timestamp on wich the agente started to be in this position' ,
	`end_timestamp` TIMESTAMP NULL COMMENT 'timestamp on wich the agent was placed for last time on this position' ,
	`description` TEXT NULL COMMENT 'description of the region correoponding to this placemnt' ,
	`manual_placement` tinyint  NOT NULL DEFAULT 0 COMMENT '0 to show that the position cames from the agent, 1 to show that the position was established manualy' ,
	`number_of_packages` INT NOT NULL DEFAULT 1 COMMENT 'Number of data packages received with this position from the start_timestampa to the_end_timestamp' ,
	`tagente_id_agente` int UNSIGNED NOT NULL COMMENT 'reference to the agent' ,
	PRIMARY KEY (`id_tgis_data`) ,
	INDEX `start_timestamp_index` USING BTREE (`start_timestamp` ASC),
	INDEX `end_timestamp_index` USING BTREE (`end_timestamp` ASC) )
ENGINE = InnoDB
COMMENT = 'Table to store historical GIS information of the agents';


-- ----------------------------------------------------------------------
-- Table `tgis_data_status`
-- ----------------------------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_data_status` (
	`tagente_id_agente` int UNSIGNED NOT NULL COMMENT 'Reference to the agent' ,
	`current_longitude` DOUBLE NOT NULL COMMENT 'Last received longitude',
	`current_latitude` DOUBLE NOT NULL COMMENT 'Last received latitude',
	`current_altitude` DOUBLE NULL COMMENT 'Last received altitude',
	`stored_longitude` DOUBLE NOT NULL COMMENT 'Reference longitude to see if the agent has moved',
	`stored_latitude` DOUBLE NOT NULL COMMENT 'Reference latitude to see if the agent has moved',
	`stored_altitude` DOUBLE NULL COMMENT 'Reference altitude to see if the agent has moved',
	`number_of_packages` INT NOT NULL DEFAULT 1 COMMENT 'Number of data packages received with this position since start_timestampa' ,
	`start_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp on wich the agente started to be in this position' ,
	`manual_placement` tinyint  NOT NULL DEFAULT 0 COMMENT '0 to show that the position cames from the agent, 1 to show that the position was established manualy' ,
	`description` TEXT NULL COMMENT 'description of the region correoponding to this placemnt' ,
	PRIMARY KEY (`tagente_id_agente`) ,
	INDEX `start_timestamp_index` USING BTREE (`start_timestamp` ASC),
	INDEX `fk_tgisdata_tagente1` (`tagente_id_agente` ASC) ,
	CONSTRAINT `fk_tgisdata_tagente1`
		FOREIGN KEY (`tagente_id_agente` )
		REFERENCES `tagente` (`id_agente` )
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Table to store last GIS information of the agents';

-- ----------------------------------------------------------------------
-- Table `tgis_map`
-- ----------------------------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_map` (
	`id_tgis_map` INT NOT NULL AUTO_INCREMENT COMMENT 'table identifier' ,
	`map_name` VARCHAR(63) NOT NULL COMMENT 'Name of the map' ,
	`initial_longitude` DOUBLE NULL COMMENT "longitude of the center of the map when it\'s loaded" ,
	`initial_latitude` DOUBLE NULL COMMENT "latitude of the center of the map when it\'s loaded" ,
	`initial_altitude` DOUBLE NULL COMMENT "altitude of the center of the map when it\'s loaded" ,
	`zoom_level` tinyint  NULL DEFAULT '1' COMMENT 'Zoom level to show when the map is loaded.' ,
	`map_background` VARCHAR(127) NULL COMMENT 'path on the server to the background image of the map' ,
	`default_longitude` DOUBLE NULL COMMENT 'default longitude for the agents placed on the map' ,
	`default_latitude` DOUBLE NULL COMMENT 'default latitude for the agents placed on the map' ,
	`default_altitude` DOUBLE NULL COMMENT 'default altitude for the agents placed on the map' ,
	`group_id` int NOT NULL DEFAULT 0 COMMENT 'Group that owns the map' ,
	`default_map` tinyint  NULL DEFAULT 0 COMMENT '1 if this is the default map, 0 in other case',
	PRIMARY KEY (`id_tgis_map`),
	INDEX `map_name_index` (`map_name` ASC)
)
ENGINE = InnoDB
COMMENT = 'Table containing information about a gis map';

-- ---------------------------------------------------------------------
-- Table `tgis_map_connection`
-- ---------------------------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_map_connection` (
	`id_tmap_connection` INT NOT NULL AUTO_INCREMENT COMMENT 'table id' ,
	`conection_name` VARCHAR(45) NULL COMMENT 'Name of the connection (name of the base layer)' ,
	`connection_type` VARCHAR(45) NULL COMMENT 'Type of map server to connect' ,
	`conection_data` TEXT NULL COMMENT 'connection information (this can probably change to fit better the possible connection parameters)' ,
	`num_zoom_levels` tinyint  NULL COMMENT 'Number of zoom levels available' ,
	`default_zoom_level` tinyint  NOT NULL DEFAULT 16 COMMENT 'Default Zoom Level for the connection' ,
	`default_longitude` DOUBLE NULL COMMENT 'default longitude for the agents placed on the map' ,
	`default_latitude` DOUBLE NULL COMMENT 'default latitude for the agents placed on the map' ,
	`default_altitude` DOUBLE NULL COMMENT 'default altitude for the agents placed on the map' ,
	`initial_longitude` DOUBLE NULL COMMENT "longitude of the center of the map when it\'s loaded" ,
	`initial_latitude` DOUBLE NULL COMMENT "latitude of the center of the map when it\'s loaded" ,
	`initial_altitude` DOUBLE NULL COMMENT "altitude of the center of the map when it\'s loaded" ,
	`group_id` int NOT NULL DEFAULT 0 COMMENT 'Group that owns the map',
	PRIMARY KEY (`id_tmap_connection`) )
ENGINE = InnoDB
COMMENT = 'Table to store the map connection information';

-- -----------------------------------------------------
-- Table `tgis_map_has_tgis_map_con` (tgis_map_has_tgis_map_connection)
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_map_has_tgis_map_con` (
	`tgis_map_id_tgis_map` INT NOT NULL COMMENT 'reference to tgis_map',
	`tgis_map_con_id_tmap_con` INT NOT NULL COMMENT 'reference to tgis_map_connection',
	`modification_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Modification Time of the Connection',
	`default_map_connection` tinyint  NULL DEFAULT FALSE COMMENT 'Flag to mark the default map connection of a map',
	PRIMARY KEY (`tgis_map_id_tgis_map`, `tgis_map_con_id_tmap_con`),
	INDEX `fk_tgis_map_has_tgis_map_connection_tgis_map1` (`tgis_map_id_tgis_map` ASC),
	INDEX `fk_tgis_map_has_tgis_map_connection_tgis_map_connection1` (`tgis_map_con_id_tmap_con` ASC),
	CONSTRAINT `fk_tgis_map_has_tgis_map_connection_tgis_map1`
		FOREIGN KEY (`tgis_map_id_tgis_map`)
		REFERENCES `tgis_map` (`id_tgis_map`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_tgis_map_has_tgis_map_connection_tgis_map_connection1`
		FOREIGN KEY (`tgis_map_con_id_tmap_con`)
		REFERENCES `tgis_map_connection` (`id_tmap_connection`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Table to asociate a connection to a gis map';

-- -----------------------------------------------------
-- Table `tgis_map_layer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_map_layer` (
	`id_tmap_layer` INT NOT NULL AUTO_INCREMENT COMMENT 'table id' ,
	`layer_name` VARCHAR(45) NOT NULL COMMENT 'Name of the layer ' ,
	`view_layer` tinyint  NOT NULL DEFAULT TRUE COMMENT 'True if the layer must be shown' ,
	`layer_stack_order` tinyint  NULL DEFAULT 0 COMMENT 'Number of order of the layer in the layer stack, bigger means upper on the stack.\n' ,
	`tgis_map_id_tgis_map` INT NOT NULL COMMENT 'reference to the map containing the layer' ,
	`tgrupo_id_grupo` mediumint NOT NULL COMMENT 'reference to the group shown in the layer' ,
	PRIMARY KEY (`id_tmap_layer`) ,
	INDEX `fk_tmap_layer_tgis_map1` (`tgis_map_id_tgis_map` ASC) ,
	CONSTRAINT `fk_tmap_layer_tgis_map1`
		FOREIGN KEY (`tgis_map_id_tgis_map` )
		REFERENCES `tgis_map` (`id_tgis_map` )
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Table containing information about the map layers';

-- -----------------------------------------------------
-- Table `tgis_map_layer_has_tagente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tgis_map_layer_has_tagente` (
	`tgis_map_layer_id_tmap_layer` INT NOT NULL ,
	`tagente_id_agente` int UNSIGNED NOT NULL ,
	PRIMARY KEY (`tgis_map_layer_id_tmap_layer`, `tagente_id_agente`) ,
	INDEX `fk_tgis_map_layer_has_tagente_tgis_map_layer1` (`tgis_map_layer_id_tmap_layer` ASC) ,
	INDEX `fk_tgis_map_layer_has_tagente_tagente1` (`tagente_id_agente` ASC) ,
	CONSTRAINT `fk_tgis_map_layer_has_tagente_tgis_map_layer1`
		FOREIGN KEY (`tgis_map_layer_id_tmap_layer` )
		REFERENCES `tgis_map_layer` (`id_tmap_layer` )
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_tgis_map_layer_has_tagente_tagente1`
		FOREIGN KEY (`tagente_id_agente` )
		REFERENCES `tagente` (`id_agente` )
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Table to define wich agents are shown in a layer';

-- -----------------------------------------------------
-- Table `tgis_map_layer_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgis_map_layer_groups` (
	`layer_id` INT NOT NULL,
	`group_id` mediumint UNSIGNED NOT NULL,
	`agent_id` int UNSIGNED NOT NULL COMMENT 'Used to link the position to the group',
	PRIMARY KEY (`layer_id`, `group_id`),
	FOREIGN KEY (`layer_id`)
		REFERENCES `tgis_map_layer` (`id_tmap_layer`)
		ON DELETE CASCADE,
	FOREIGN KEY (`group_id`)
		REFERENCES `tgrupo` (`id_grupo`)
		ON DELETE CASCADE,
	FOREIGN KEY (`agent_id`)
		REFERENCES `tagente` (`id_agente`)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tgroup_stat`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgroup_stat` (
	`id_group` int unsigned NOT NULL default '0',
	`modules` int unsigned NOT NULL default '0',
	`normal` int unsigned NOT NULL default '0',
	`critical` int unsigned NOT NULL default '0',
	`warning` int unsigned NOT NULL default '0',
	`unknown` int unsigned NOT NULL default '0',
	`non-init` int unsigned NOT NULL default '0',
	`alerts` int unsigned NOT NULL default '0',
	`alerts_fired` int unsigned NOT NULL default '0',
	`agents` int unsigned NOT NULL default '0',
	`agents_unknown` int unsigned NOT NULL default '0',
	`utimestamp` int unsigned NOT NULL default 0,
	PRIMARY KEY  (`id_group`)
) ENGINE=InnoDB 
COMMENT = 'Table to store global system stats per group' 
DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnetwork_map`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_map` (
	`id_networkmap` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_user` VARCHAR(60)  NOT NULL,
	`name` VARCHAR(100)  NOT NULL,
	`type` VARCHAR(20)  NOT NULL,
	`layout` VARCHAR(20)  NOT NULL,
	`nooverlap` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`simple` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`regenerate` tinyint  UNSIGNED NOT NULL DEFAULT 1,
	`font_size` INT UNSIGNED NOT NULL DEFAULT 12,
	`id_group` INT  NOT NULL DEFAULT 0,
	`id_module_group` INT  NOT NULL DEFAULT 0,  
	`id_policy` INT  NOT NULL DEFAULT 0,
	`depth` VARCHAR(20)  NOT NULL,
	`only_modules_with_alerts` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`hide_policy_modules` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`zoom` FLOAT UNSIGNED NOT NULL DEFAULT 1,
	`distance_nodes` FLOAT UNSIGNED NOT NULL DEFAULT 2.5,
	`center` INT UNSIGNED NOT NULL DEFAULT 0,
	`contracted_nodes` TEXT,
	`show_snmp_modules` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`text_filter` VARCHAR(100)  NOT NULL DEFAULT "",
	`dont_show_subgroups` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`pandoras_children` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`show_groups` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`show_modules` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`id_agent` INT  NOT NULL DEFAULT 0,
	`server_name` VARCHAR(100)  NOT NULL,
	`show_modulegroup` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`l2_network` tinyint  UNSIGNED NOT NULL DEFAULT 0,
	`id_tag` int DEFAULT 0,
	`store_group` int DEFAULT 0,
	PRIMARY KEY  (`id_networkmap`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tsnmp_filter`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tsnmp_filter` (
	`id_snmp_filter` int unsigned NOT NULL auto_increment,
	`description` varchar(255) default '',
	`filter` varchar(255) default '',
	`unified_filters_id` int not null default 0,
	PRIMARY KEY  (`id_snmp_filter`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tagent_custom_fields`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagent_custom_fields` (
	`id_field` int unsigned NOT NULL auto_increment,
	`name` varchar(45) NOT NULL default '',
	`display_on_front` tinyint  NOT NULL default 0,
	`is_password_type` tinyint  NOT NULL default 0,
	`combo_values` VARCHAR(255) DEFAULT '',
	PRIMARY KEY  (`id_field`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tagent_custom_data`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagent_custom_data` (
	`id_field` int unsigned NOT NULL,
	`id_agent` int unsigned NOT NULL,
	`description` text,
	FOREIGN KEY (`id_field`) REFERENCES tagent_custom_fields(`id_field`)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (`id_agent`) REFERENCES tagente(`id_agente`)
		ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY  (`id_field`, `id_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `ttag`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttag` ( 
	`id_tag` integer(10) unsigned NOT NULL auto_increment, 
	`name` varchar(100) NOT NULL default '', 
	`description` text NOT NULL, 
	`url` mediumtext NOT NULL,
	`email` text NULL,
	`phone` text NULL,
	`previous_name` text NULL,
	PRIMARY KEY  (`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4; 

-- -----------------------------------------------------
-- Table `ttag_module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttag_module` (
	`id_tag` int NOT NULL,
	`id_agente_modulo` int NOT NULL DEFAULT 0,
	`id_policy_module` int NOT NULL DEFAULT 0,
	PRIMARY KEY  (id_tag, id_agente_modulo),
	KEY `idx_id_agente_modulo` (`id_agente_modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4; 

-- ---------------------------------------------------------------------
-- Table `ttag_policy_module`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttag_policy_module` ( 
	`id_tag` int NOT NULL, 
	`id_policy_module` int NOT NULL DEFAULT 0, 
	PRIMARY KEY  (id_tag, id_policy_module),
	KEY `idx_id_policy_module` (`id_policy_module`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4; 

-- ---------------------------------------------------------------------
-- Table `tnetflow_filter`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetflow_filter` (
	`id_sg`  int unsigned NOT NULL auto_increment,
	`id_name` varchar(600) NOT NULL default '0',
	`id_group` int,
	`ip_dst` TEXT NOT NULL,
	`ip_src` TEXT NOT NULL,
	`dst_port` TEXT NOT NULL,
	`src_port` TEXT NOT NULL,
	`router_ip` TEXT NOT NULL,
	`advanced_filter` TEXT NOT NULL,
	`filter_args` TEXT NOT NULL,
	`aggregate` varchar(60),
	PRIMARY KEY  (`id_sg`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tnetflow_report`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetflow_report` (
	`id_report` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`id_name` varchar(150) NOT NULL default '',
	`description` TEXT NOT NULL,
	`id_group` int,
	`server_name` TEXT NOT NULL,
	PRIMARY KEY(`id_report`)  
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tnetflow_report_content`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetflow_report_content` (
	`id_rc` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_report` INTEGER UNSIGNED NOT NULL default 0,
	`id_filter` INTEGER UNSIGNED NOT NULL default 0,
	`description` TEXT NOT NULL,
	`date` bigint NOT NULL default '0',
	`period` int NOT NULL default 0,
	`max` int (11) NOT NULL default 0,
	`show_graph` varchar(60),
	`order` int (11) NOT NULL default 0,
	PRIMARY KEY(`id_rc`),
	FOREIGN KEY (`id_report`) REFERENCES tnetflow_report(`id_report`)
	ON DELETE CASCADE,
	FOREIGN KEY (`id_filter`) REFERENCES tnetflow_filter(`id_sg`)
	ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tpassword_history`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpassword_history` (
	`id_pass`  int unsigned NOT NULL auto_increment,
	`id_user` varchar(60) NOT NULL,
	`password` varchar(45) default NULL,
	`date_begin` DATETIME  NOT NULL DEFAULT 0,
	`date_end` DATETIME  NOT NULL DEFAULT 0,
	PRIMARY KEY  (`id_pass`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tevent_response`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_response` (
	`id`  int unsigned NOT NULL auto_increment,
	`name` varchar(600) NOT NULL default '',
	`description` TEXT NOT NULL,
	`target` TEXT NOT NULL,
	`type` varchar(60) NOT NULL,
	`id_group` mediumint NOT NULL default 0,
	`modal_width` INTEGER  NOT NULL DEFAULT 0,
	`modal_height` INTEGER  NOT NULL DEFAULT 0,
	`new_window` tinyint   NOT NULL DEFAULT 0,
	`params` TEXT  NOT NULL,
	`server_to_exec` int unsigned NOT NULL DEFAULT 0,
	`command_timeout` int unsigned NOT NULL DEFAULT 90,
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tcategory`
-- ----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcategory` ( 
	`id` int unsigned NOT NULL auto_increment, 
	`name` varchar(600) NOT NULL default '', 
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4; 

-- ---------------------------------------------------------------------
-- Table `tupdate_settings`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tupdate_settings` ( 
	`key` varchar(255) default '', 
	`value` varchar(255) default '', PRIMARY KEY (`key`) 
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tupdate_package`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tupdate_package` (  
	id int unsigned NOT NULL auto_increment,  
	timestamp datetime NOT NULL,  
	description varchar(255) default '',  PRIMARY KEY (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tupdate`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tupdate` (  
	id int unsigned NOT NULL auto_increment,  
	type enum('code', 'db_data', 'db_schema', 'binary'),  
	id_update_package int unsigned NOT NULL default 0,  
	filename  varchar(250) default '',  
	checksum  varchar(250) default '',  
	previous_checksum  varchar(250) default '',  
	svn_version int unsigned NOT NULL default 0,  
	data LONGTEXT,  
	data_rollback LONGTEXT,  
	description TEXT,  
	db_table_name varchar(140) default '',  
	db_field_name varchar(140) default '',  
	db_field_value varchar(1024) default '',  PRIMARY KEY  (`id`),  
	FOREIGN KEY (`id_update_package`) REFERENCES tupdate_package(`id`)   ON UPDATE CASCADE ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tupdate_journal`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tupdate_journal` (  
	id int unsigned NOT NULL auto_increment,  
	id_update int unsigned NOT NULL default 0,  PRIMARY KEY  (`id`),  
	FOREIGN KEY (`id_update`) REFERENCES tupdate(`id`)   ON UPDATE CASCADE ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `talert_snmp_action`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS  `talert_snmp_action` (
	`id` int unsigned NOT NULL auto_increment,
	`id_alert_snmp` int unsigned NOT NULL default '0',
	`alert_type` int unsigned NOT NULL default '0',
	`al_field1` text NOT NULL,
	`al_field2` text NOT NULL,
	`al_field3` text NOT NULL,
	`al_field4` text NOT NULL,
	`al_field5` text NOT NULL,
	`al_field6` text NOT NULL,
	`al_field7` text NOT NULL,
	`al_field8` text NOT NULL,
	`al_field9` text NOT NULL,
	`al_field10` text NOT NULL,
	`al_field11` text NOT NULL,
	`al_field12` text NOT NULL,
	`al_field13` text NOT NULL,
	`al_field14` text NOT NULL,
	`al_field15` text NOT NULL,
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tsessions_php`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tsessions_php` (
	`id_session` CHAR(52) NOT NULL,
	`last_active` INTEGER NOT NULL,
	`data` TEXT,
	PRIMARY KEY (`id_session`)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tmap`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmap` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_group` int unsigned NOT NULL default 0,
	`id_user` varchar(250) NOT NULL default '',
	`type` int unsigned NOT NULL default 0,
	`subtype` int unsigned NOT NULL default 0,
	`name` varchar(250) default '',
	`description` TEXT,
	`height` INTEGER UNSIGNED NOT NULL default 0,
	`width` INTEGER UNSIGNED NOT NULL default 0,
	`center_x` INTEGER NOT NULL default 0,
	`center_y` INTEGER NOT NULL default 0,
	`background` varchar(250) default '',
	`background_options` INTEGER UNSIGNED NOT NULL default 0,
	`source_period` INTEGER UNSIGNED NOT NULL default 0,
	`source` INTEGER UNSIGNED NOT NULL default 0,
	`source_data`  varchar(250) default '',
	`generation_method` INTEGER UNSIGNED NOT NULL default 0,
	`generated` INTEGER UNSIGNED NOT NULL default 0,
	`filter` TEXT,
	`id_group_map` int UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id`)
)  ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `titem`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `titem` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_map` int unsigned NOT NULL default 0,
	`x` INTEGER NOT NULL default 0,
	`y` INTEGER NOT NULL default 0,
	`z` INTEGER NOT NULL default 0,
	`deleted` INTEGER(1) unsigned NOT NULL default 0,
	`type` INTEGER UNSIGNED NOT NULL default 0,
	`refresh` INTEGER UNSIGNED NOT NULL default 0,
	`source` INTEGER UNSIGNED NOT NULL default 0,
	`source_data` varchar(250) default '',
	`options` TEXT,
	`style` TEXT,
	PRIMARY KEY(`id`)
)  ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `trel_item`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `trel_item` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_parent` int unsigned NOT NULL default 0,
	`id_child` int unsigned NOT NULL default 0,
	`id_map` int unsigned NOT NULL default 0,
	`id_parent_source_data` int unsigned NOT NULL default 0,
	`id_child_source_data` int unsigned NOT NULL default 0,
	`parent_type` int unsigned NOT NULL default 0,
	`child_type` int unsigned NOT NULL default 0,
	`id_item` int unsigned NOT NULL default 0,
	`deleted` int unsigned NOT NULL default 0,
	PRIMARY KEY(`id`)
)  ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tlocal_component`
-- -----------------------------------------------------
-- tlocal_component is a repository of local modules for
-- physical agents on Windows / Unix physical agents
CREATE TABLE IF NOT EXISTS `tlocal_component` (
	`id` int unsigned NOT NULL auto_increment,
	`name` text NOT NULL,
	`data` mediumtext NOT NULL,
	`description` varchar(1024) default NULL,
	`id_os` int unsigned default '0',
	`os_version` varchar(100) default '',
	`id_network_component_group` int unsigned NOT NULL default 0,
	`type` smallint(6) NOT NULL default '6',
	`max` bigint NOT NULL default '0',
	`min` bigint NOT NULL default '0',
	`module_interval` mediumint unsigned NOT NULL default '0',
	`id_module_group` tinyint  unsigned NOT NULL default '0',
	`history_data` tinyint  unsigned default '1',
	`min_warning` double(18,2) default 0,
	`max_warning` double(18,2) default 0,
	`str_warning` text,
	`min_critical` double(18,2) default 0,
	`max_critical` double(18,2) default 0,
	`str_critical` text,
	`min_ff_event` int unsigned default '0',
	`post_process` double(24,15) default 0,
	`unit` text,
	`wizard_level` enum('basic','advanced','nowizard') default 'nowizard',
	`macros` text,
	`critical_instructions` text NOT NULL default '',
	`warning_instructions` text NOT NULL default '',
	`unknown_instructions` text NOT NULL default '',
	`critical_inverse` tinyint  unsigned default '0',
	`warning_inverse` tinyint  unsigned default '0',
	`id_category` int default 0,
	`tags` text NOT NULL default '',
	`disabled_types_event` TEXT NOT NULL DEFAULT '',
	`min_ff_event_normal` int unsigned default '0',
	`min_ff_event_warning` int unsigned default '0',
	`min_ff_event_critical` int unsigned default '0',
	`ff_type` tinyint  unsigned default '0',
	`each_ff` tinyint  unsigned default '0',
	`ff_timeout` int unsigned default '0',
	`dynamic_interval` int unsigned default '0',
	`dynamic_max` int default '0',
	`dynamic_min` int default '0',
	`dynamic_next` bigint NOT NULL default '0',
	`dynamic_two_tailed` tinyint  unsigned default '0',
	`prediction_sample_window` int default 0,
	`prediction_samples` int default 0,
	`prediction_threshold` int default 0,
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_network_component_group`) REFERENCES tnetwork_component_group(`id_sg`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tpolicy_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_modules` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned NOT NULL default '0',
	`configuration_data` mediumtext NOT NULL,
	`id_tipo_modulo` smallint(5) NOT NULL default '0',
	`description` varchar(1024) NOT NULL default '',
	`name` varchar(200) NOT NULL default '',
	`unit` text default '',
	`max` bigint default '0',
	`min` bigint default '0',
	`module_interval` int unsigned default '0',
	`ip_target` varchar(100) default '',
	`tcp_port` int unsigned default '0',
	`tcp_send` text default '',
	`tcp_rcv` text default '',
	`snmp_community` varchar(100) default '',
	`snmp_oid` varchar(255) default '0',
	`id_module_group` int unsigned default '0',
	`flag` tinyint  unsigned default '1',
	`id_module` int default '0',
	`disabled` tinyint  unsigned NOT NULL default '0',
	`id_export` smallint(4) unsigned default '0',
	`plugin_user` text default '',
	`plugin_pass` text default '',
	`plugin_parameter` text,
	`id_plugin` int default '0',
	`post_process` double(24,15) default 0,
	`prediction_module` bigint default '0',
	`max_timeout` int unsigned default '0',
	`max_retries` int unsigned default '0',
	`custom_id` varchar(255) default '',
	`history_data` tinyint  unsigned default '1',
	`min_warning` double(18,2) default 0,
	`max_warning` double(18,2) default 0,
	`str_warning` text default '',
	`min_critical` double(18,2) default 0,
	`max_critical` double(18,2) default 0,
	`str_critical` text default '',
	`min_ff_event` int unsigned default '0',
	`custom_string_1` text default '',
	`custom_string_2` text default '',
	`custom_string_3` text default '',
	`custom_integer_1` int default 0,
	`custom_integer_2` int default 0,
	`pending_delete` tinyint  default '0',
	`critical_instructions` text NOT NULL default '',
	`warning_instructions` text NOT NULL default '',
	`unknown_instructions` text NOT NULL default '',
	`critical_inverse` tinyint  unsigned default '0',
	`warning_inverse` tinyint  unsigned default '0',
	`id_category` int default 0,
	`module_ff_interval` int unsigned default '0',
	`quiet` tinyint  NOT NULL default '0',
	`cron_interval` varchar(100) default '',
	`macros` text,
	`disabled_types_event` TEXT NOT NULL default '',
	`module_macros` TEXT NOT NULL default '',
	`min_ff_event_normal` int unsigned default '0',
	`min_ff_event_warning` int unsigned default '0',
	`min_ff_event_critical` int unsigned default '0',
	`ff_type` tinyint  unsigned default '0',
	`each_ff` tinyint  unsigned default '0',
	`ff_timeout` int unsigned default '0',
	`dynamic_interval` int unsigned default '0',
	`dynamic_max` int default '0',
	`dynamic_min` int default '0',
	`dynamic_next` bigint NOT NULL default '0',
	`dynamic_two_tailed` tinyint  unsigned default '0',
	`prediction_sample_window` int default 0,
	`prediction_samples` int default 0,
	`prediction_threshold` int default 0,
	`cps` int NOT NULL DEFAULT 0,
	PRIMARY KEY  (`id`),
	KEY `main_idx` (`id_policy`),
	UNIQUE (`id_policy`, `name`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tpolicies`
-- ---------------------------------------------------------------------
-- 'status' could be 0 (without changes, updated), 1 (needy update only database) or 2 (needy update database and conf files)
CREATE TABLE IF NOT EXISTS `tpolicies` (
	`id` int unsigned NOT NULL auto_increment,
	`name` text NOT NULL default '',
	`description` varchar(255) NOT NULL default '',
	`id_group` int unsigned default '0',
	`status` int unsigned NOT NULL default 0,
	`force_apply` tinyint  default 0,
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tpolicy_alerts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_alerts` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned NOT NULL default '0',
	`id_policy_module` int unsigned default '0',
	`id_alert_template` int unsigned default '0',
	`name_extern_module` TEXT NOT NULL default '',
	`disabled` tinyint  default '0',
	`standby` tinyint  default '0',
	`pending_delete` tinyint  default '0',
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_alert_template`) REFERENCES talert_templates(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`id_policy`) REFERENCES tpolicies(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tpolicy_agents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_agents` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned default '0',
	`id_agent` int unsigned default '0',
	`policy_applied` tinyint  unsigned default '0',
	`pending_delete` tinyint  unsigned default '0',
	`last_apply_utimestamp` int unsigned NOT NULL default 0,
	`id_node` int NOT NULL default 0,
	PRIMARY KEY  (`id`),
	UNIQUE (`id_policy`, `id_agent`, `id_node`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tpolicy_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_groups` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned default '0',
	`id_group` int unsigned default '0',
	`policy_applied` tinyint  unsigned default '0',
	`pending_delete` tinyint  unsigned default '0',
	`last_apply_utimestamp` int unsigned NOT NULL default 0,
	PRIMARY KEY  (`id`),
	UNIQUE (`id_policy`, `id_group`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tdashboard`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tdashboard` (
	`id` int unsigned NOT NULL auto_increment,
	`name` varchar(60) NOT NULL default '',
	`id_user` varchar(60) NOT NULL default '',
	`id_group` int NOT NULL default 0,
	`active` tinyint  NOT NULL default 0,
	`cells` int unsigned default 0,
	`cells_slideshow` tinyint  NOT NULL default 0,
	PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tdatabase`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tdatabase` (
	`id` int unsigned NOT NULL auto_increment,
	`host` VARCHAR(255) default '',
	`label` VARCHAR(255) default '',
	`os_port` INT UNSIGNED NOT NULL DEFAULT 22,
	`os_user` VARCHAR(255) default '',
	`db_port` INT UNSIGNED NOT NULL DEFAULT 3306,
	`status` tinyint  unsigned default '0',
	`action` tinyint  unsigned default '0',
	`ssh_key` TEXT,
	`ssh_pubkey` TEXT,
	`last_error` TEXT,
	PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `twidget`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twidget` (
	`id` int unsigned NOT NULL auto_increment,
	`class_name` varchar(60) NOT NULL default '',
	`unique_name` varchar(60) NOT NULL default '',
	`description` text NOT NULL default '',
	`options` text NOT NULL default '',
	`page` varchar(120) NOT NULL default '',
	PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `twidget_dashboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twidget_dashboard` (
	`id` int unsigned NOT NULL auto_increment,
	`position` TEXT NOT NULL default '',
	`options` LONGTEXT NOT NULL default '',
	`order` int NOT NULL default 0,
	`id_dashboard` int unsigned NOT NULL default 0,
	`id_widget` int unsigned NOT NULL default 0,
	`prop_width` float(5,3) NOT NULL default 0.32,
	`prop_height` float(5,3) NOT NULL default 0.32,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`id_dashboard`) REFERENCES tdashboard(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tmodule_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmodule_inventory` (
	`id_module_inventory` int NOT NULL auto_increment,
	`id_os` int unsigned default NULL,
	`name` text default '',
	`description` text default '',
	`interpreter` varchar(100) default '',
	`data_format` text default '',
	`code` BLOB NOT NULL,
	`block_mode` int NOT NULL default 0,
	PRIMARY KEY  (`id_module_inventory`),
	FOREIGN KEY (`id_os`) REFERENCES tconfig_os(`id_os`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagent_module_inventory`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagent_module_inventory` (
	`id_agent_module_inventory` int NOT NULL auto_increment,
	`id_agente` int unsigned NOT NULL,
	`id_module_inventory` int NOT NULL,
	`target` varchar(100) default '',
	`interval` int unsigned NOT NULL default '3600',
	`username` varchar(100) default '',
	`password` varchar(100) default '',
	`data` MEDIUMBLOB NOT NULL,
	`timestamp` datetime default '1970-01-01 00:00:00',
	`utimestamp` bigint default '0',
	`flag` tinyint  unsigned default '1',
	`id_policy_module_inventory` int NOT NULL default '0',
	`custom_fields` MEDIUMBLOB NOT NULL,
	PRIMARY KEY  (`id_agent_module_inventory`),
	FOREIGN KEY (`id_agente`) REFERENCES tagente(`id_agente`)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (`id_module_inventory`) REFERENCES tmodule_inventory(`id_module_inventory`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tpolicy_modules_inventory`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_modules_inventory` (
	`id` int NOT NULL auto_increment,
	`id_policy` int unsigned NOT NULL,
	`id_module_inventory` int NOT NULL,
	`interval` int unsigned NOT NULL default '3600',
	`username` varchar(100) default '',
	`password` varchar(100) default '',
	`pending_delete` tinyint  default '0',
	`custom_fields` MEDIUMBLOB NOT NULL,
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_policy`) REFERENCES tpolicies(`id`)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (`id_module_inventory`) REFERENCES tmodule_inventory(`id_module_inventory`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tagente_datos_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagente_datos_inventory` (
	`id_agent_module_inventory` int NOT NULL,
	`data` MEDIUMBLOB NOT NULL,
	`utimestamp` bigint default '0',
	`timestamp` datetime default '1970-01-01 00:00:00',
	KEY `idx_id_agent_module` (`id_agent_module_inventory`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `ttrap_custom_values`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttrap_custom_values` (
	`id` int NOT NULL auto_increment,
	`oid` varchar(255) NOT NULL default '',
	`custom_oid` varchar(255) NOT NULL default '',
	`text` varchar(255) default '',
	`description` varchar(255) default '',
	`severity` tinyint  unsigned NOT NULL default '2',
	CONSTRAINT oid_custom_oid UNIQUE(oid, custom_oid),
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tmetaconsole_setup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmetaconsole_setup` (
	`id` int NOT NULL auto_increment,
	`server_name` text,
	`server_url` text,
	`dbuser` text,
	`dbpass` text,
	`dbhost` text,
	`dbport` text,
	`dbname` text,
	`meta_dbuser` text,
	`meta_dbpass` text,
	`meta_dbhost` text,
	`meta_dbport` text,
	`meta_dbname` text,
	`auth_token` text,
	`id_group` int unsigned NOT NULL default 0,
	`api_password` text NOT NULL,
	`disabled` tinyint  unsigned NOT NULL default '0',
	`last_event_replication` bigint default '0',
	`server_uid` text NOT NULL default '',
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB 
COMMENT = 'Table to store metaconsole sources' 
DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tprofile_view`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tprofile_view` (
	`id` int unsigned NOT NULL auto_increment,
	`id_profile` int unsigned NOT NULL default 0,
	`sec` text default '',
	`sec2` text default '',
	`sec3` text default '',
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB 
COMMENT = 'Table to define by each profile defined in Pandora, to which sec/page has access independently of its ACL (for showing in the console or not). By default have access to all pages allowed by ACL, if forbidden here, then pages are not shown.' 
DEFAULT CHARSET=UTF8MB4;


-- ---------------------------------------------------------------------
-- Table `tservice`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tservice` (
	`id` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`description` text NOT NULL default '',
	`id_group` int unsigned NOT NULL default 0,
	`critical` float(20,3) NOT NULL default 0,
	`warning` float(20,3) NOT NULL default 0,
	`unknown_as_critical` tinyint  NOT NULL default 0,
	`service_interval` float(20,3) NOT NULL default 0,
	`service_value` float(20,3) NOT NULL default 0,
	`status` tinyint  NOT NULL default -1,
	`utimestamp` int unsigned NOT NULL default 0,
	`auto_calculate` tinyint  unsigned NOT NULL default 1,
	`id_agent_module` int unsigned NOT NULL default 0,
	`sla_interval` float(20,3) NOT NULL default 0,
	`sla_id_module` int unsigned NOT NULL default 0,
	`sla_value_id_module` int unsigned NOT NULL default 0,
	`sla_limit` float(20,3) NOT NULL default 100,
	`id_template_alert_warning` int unsigned NOT NULL default 0,
	`id_template_alert_critical` int unsigned NOT NULL default 0,
	`id_template_alert_unknown` int unsigned NOT NULL default 0,
	`id_template_alert_critical_sla` int unsigned NOT NULL default 0,
	`quiet` tinyint  NOT NULL default 0,
	`cps` int NOT NULL default 0,
	`cascade_protection` tinyint  NOT NULL default 0,
	`evaluate_sla` int NOT NULL default 0,
	`is_favourite` tinyint  NOT NULL default 0,
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB 
COMMENT = 'Table to define services to monitor' 
DEFAULT CHARSET=UTF8MB4;


-- ---------------------------------------------------------------------
-- Table `tservice_element`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tservice_element` (
	`id` int unsigned NOT NULL auto_increment,
	`id_service` int unsigned NOT NULL,
	`weight_ok` float(20,3) NOT NULL default 0,
	`weight_warning` float(20,3) NOT NULL default 0,
	`weight_critical` float(20,3) NOT NULL default 0,
	`weight_unknown` float(20,3) NOT NULL default 0,
	`description` text NOT NULL default '',
	`id_agente_modulo` int unsigned NOT NULL default 0,
	`id_agent` int unsigned NOT NULL default 0,
	`id_service_child` int unsigned NOT NULL default 0,
	`id_server_meta` int  unsigned NOT NULL default 0,
	`rules` text,
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB 
COMMENT = 'Table to define the modules and the weights of the modules that define a service' 
DEFAULT CHARSET=UTF8MB4;


-- ---------------------------------------------------------------------
-- Table `tcollection`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcollection` (
	`id` int unsigned NOT NULL auto_increment,
	`name` varchar(100) NOT NULL default '',
	`short_name` varchar(100) NOT NULL default '',
	`id_group` int unsigned NOT NULL default 0,
	`description` mediumtext,
	`status` int unsigned NOT NULL default '0',
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
-- status: 0 - Not apply
-- status: 1 - Applied

-- ---------------------------------------------------------------------
-- Table `tpolicy_collections`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_collections` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned NOT NULL default '0',
	`id_collection` int unsigned default '0',
	`pending_delete` tinyint  default '0',
	PRIMARY KEY  (`id`),
	FOREIGN KEY (`id_policy`) REFERENCES `tpolicies` (`id`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`id_collection`) REFERENCES `tcollection` (`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tpolicy_alerts_actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_alerts_actions` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy_alert` int unsigned NOT NULL,
	`id_alert_action` int unsigned NOT NULL,
	`fires_min` int unsigned default 0,
	`fires_max` int unsigned default 0,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`id_policy_alert`) REFERENCES `tpolicy_alerts` (`id`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`id_alert_action`) REFERENCES `talert_actions` (`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tpolicy_plugins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_plugins` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned default '0',
	`plugin_exec` TEXT,
	`pending_delete` tinyint  default '0',
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tsesion_extended`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tsesion_extended` (
	`id` int unsigned NOT NULL auto_increment,
	`id_sesion` int unsigned NOT NULL,
	`extended_info` TEXT default '',
	`hash` varchar(255) default '',
	PRIMARY KEY (`id`),
	KEY idx_session (id_sesion)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tskin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tskin` ( 
	`id` int unsigned NOT NULL auto_increment, 
	`name` TEXT NOT NULL DEFAULT '',
	`relative_path` TEXT NOT NULL DEFAULT '', 
	`description` text NOT NULL DEFAULT '',
	`disabled` tinyint  NOT NULL default '0', 
	PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tpolicy_queue`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpolicy_queue` (
	`id` int unsigned NOT NULL auto_increment,
	`id_policy` int unsigned NOT NULL default '0',
	`id_agent` int unsigned NOT NULL default '0',
	`operation` varchar(15) default '',
	`progress` int unsigned NOT NULL default '0',
	`end_utimestamp` int unsigned NOT NULL default 0,
	`priority` int unsigned NOT NULL default '0',
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tevent_rule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_rule` (
	`id_event_rule` int unsigned NOT NULL auto_increment,
	`id_event_alert` int unsigned NOT NULL,
	`operation` enum('NOP', 'AND','OR','XOR','NAND','NOR','NXOR'),
	`order` int unsigned default '0',
	`window` int NOT NULL default '0',
	`count` int NOT NULL default '1',
	`agent` text default '',
	`id_usuario` varchar(100) NOT NULL default '',
	`id_grupo` mediumint default NULL,
	`evento` text NOT NULL default '',
	`event_type` enum('','unknown','alert_fired','alert_recovered','alert_ceased','alert_manual_validation','recon_host_detected','system','error','new_agent','going_up_warning','going_up_critical','going_down_warning','going_down_normal','going_down_critical','going_up_normal') default '',
	`module` text default '',
	`alert` text default '',
	`criticity` int unsigned default NULL,
	`user_comment` text NOT NULL,
	`id_tag` integer(10) unsigned NOT NULL default '0',
	`name` text default '',
	`group_recursion` int unsigned default 0,
	`log_content` text,
	`log_source` text,
	`log_agent` text,
	`operator_agent` text COMMENT 'Operator for agent',
	`operator_id_usuario` text COMMENT 'Operator for id_usuario',
	`operator_id_grupo` text COMMENT 'Operator for id_grupo',
	`operator_evento` text COMMENT 'Operator for evento',
	`operator_event_type` text COMMENT 'Operator for event_type',
	`operator_module` text COMMENT 'Operator for module',
	`operator_alert` text COMMENT 'Operator for alert',
	`operator_criticity` text COMMENT 'Operator for criticity',
	`operator_user_comment` text COMMENT 'Operator for user_comment',
	`operator_id_tag` text COMMENT 'Operator for id_tag',
	`operator_log_content` text COMMENT 'Operator for log_content',
	`operator_log_source` text COMMENT 'Operator for log_source',
	`operator_log_agent` text COMMENT 'Operator for log_agent',
	PRIMARY KEY  (`id_event_rule`),
	KEY `idx_id_event_alert` (`id_event_alert`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tevent_alert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_alert` (
	`id` int unsigned NOT NULL auto_increment,
	`name` text default '',
	`description` mediumtext,
	`order` int unsigned default 0,
	`mode` enum('PASS','DROP'),
	`field1` text NOT NULL default '',
	`field2` text NOT NULL default '',
	`field3` text NOT NULL default '',
	`field4` text NOT NULL default '',
	`field5` text NOT NULL default '',
	`field6` text NOT NULL default '',
	`field7` text NOT NULL default '',
	`field8` text NOT NULL default '',
	`field9` text NOT NULL default '',
	`field10` text NOT NULL default '',
	`time_threshold` int NOT NULL default 86400,
	`max_alerts` int unsigned NOT NULL default '1',
	`min_alerts` int unsigned NOT NULL default '0',
	`time_from` time default '00:00:00',
	`time_to` time default '00:00:00',
	`monday` tinyint  default 1,
	`tuesday` tinyint  default 1,
	`wednesday` tinyint  default 1,
	`thursday` tinyint  default 1,
	`friday` tinyint  default 1,
	`saturday` tinyint  default 1,
	`sunday` tinyint  default 1,
	`recovery_notify` tinyint  default '0',
	`field2_recovery` text NOT NULL default '',
	`field3_recovery` text NOT NULL,
	`id_group` mediumint unsigned NULL default 0,
	`internal_counter` int default '0',
	`last_fired` bigint NOT NULL default '0',
	`last_reference` bigint NOT NULL default '0',
	`times_fired` int NOT NULL default '0',
	`disabled` tinyint  default '0',
	`standby` tinyint  default '0',
	`priority` tinyint  default '0',
	`force_execution` tinyint  default '0',
	`group_by` enum ('','id_agente','id_agentmodule','id_alert_am','id_grupo') default '',
	`special_days` tinyint  default 0,
	`disable_event` tinyint  default 0,
	PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tevent_alert_action`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_alert_action` (
	`id` int unsigned NOT NULL auto_increment,
	`id_event_alert` int unsigned NOT NULL,
	`id_alert_action` int unsigned NOT NULL,
	`fires_min` int unsigned default 0,
	`fires_max` int unsigned default 0,
	`module_action_threshold` int NOT NULL default '0',
	`last_execution` bigint NOT NULL default '0',
	PRIMARY KEY (`id`),
	FOREIGN KEY (`id_event_alert`) REFERENCES tevent_alert(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`id_alert_action`) REFERENCES talert_actions(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


-- -----------------------------------------------------
-- Table `tmodule_synth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmodule_synth` (
	`id` int unsigned NOT NULL auto_increment,
	`id_agent_module_source` int unsigned NOT NULL DEFAULT 0,
	`id_agent_module_target` int unsigned NOT NULL DEFAULT 0,
	`fixed_value` float NOT NULL DEFAULT 0,
	`operation` enum ('ADD', 'SUB', 'DIV', 'MUL', 'AVG', 'NOP') NOT NULL DEFAULT 'NOP',
	`order` int NOT NULL DEFAULT '0',
	FOREIGN KEY (`id_agent_module_target`) REFERENCES tagente_modulo(`id_agente_modulo`)
		ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


-- -----------------------------------------------------
-- Table `tnetworkmap_enterprise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetworkmap_enterprise` (
	`id` int unsigned NOT NULL auto_increment,
	`name` varchar(500) default '',
	`id_group` int unsigned NOT NULL default 0,
	`options` text default '',
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


-- -----------------------------------------------------
-- Table `tnetworkmap_enterprise_nodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetworkmap_enterprise_nodes` (
	`id` int unsigned NOT NULL auto_increment,
	`id_networkmap_enterprise` int unsigned NOT NULL,
	`x` int default 0,
	`y` int default 0,
	`z` int default 0,
	`id_agent` int default 0,
	`id_module` int default 0,
	`id_agent_module` int default 0,
	`parent` int default 0,
	`options` text default '',
	`deleted` int default 0,
	`state` varchar(150) NOT NULL default '',
	PRIMARY KEY (id),
	FOREIGN KEY (`id_networkmap_enterprise`) REFERENCES tnetworkmap_enterprise(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


-- -----------------------------------------------------
-- Table `tnetworkmap_ent_rel_nodes` (Before `tnetworkmap_enterprise_relation_nodes`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetworkmap_ent_rel_nodes` (
	`id` int unsigned NOT NULL auto_increment,
	`id_networkmap_enterprise` int unsigned NOT NULL,
	`parent` int default 0,
	`parent_type` varchar(30) default 'node',
	`child` int default 0,
	`child_type` varchar(30) default 'node',
	`deleted` int default 0,
	PRIMARY KEY (id, id_networkmap_enterprise),
	FOREIGN KEY (`id_networkmap_enterprise`) REFERENCES tnetworkmap_enterprise(`id`)
		ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `treport_template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_template` (
	`id_report` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`id_user` varchar(100) NOT NULL default '',
	`name` varchar(150) NOT NULL default '',
	`description` TEXT NOT NULL,
	`private` tinyint  UNSIGNED NOT NULL default 0,
	`id_group` mediumint unsigned NULL default NULL,
	`custom_logo` varchar(200)  default NULL,
	`header` MEDIUMTEXT  default NULL,
	`first_page` MEDIUMTEXT default NULL,
	`footer` MEDIUMTEXT default NULL,
	`custom_font` varchar(200) default NULL,
	`metaconsole` tinyint  DEFAULT 0,
	`agent_regex` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`cover_page_render` tinyint  NOT NULL DEFAULT 1,
	`index_render` tinyint  NOT NULL DEFAULT 1,
	PRIMARY KEY(`id_report`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `treport_content_template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_content_template` (
	`id_rc` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_report` INTEGER UNSIGNED NOT NULL default 0,
	`id_gs` INTEGER UNSIGNED NULL default NULL,
	`text_agent_module` text,
	`type` varchar(30) default 'simple_graph',
	`period` int NOT NULL default 0,
	`order` int (11) NOT NULL default 0,
	`description` mediumtext, 
	`text_agent` text,
	`text` TEXT,
	`external_source` Text,
	`treport_custom_sql_id` INTEGER UNSIGNED default 0,
	`header_definition` TinyText default NULL,
	`column_separator` TinyText default NULL,
	`line_separator` TinyText default NULL,
	`time_from` time default '00:00:00',
	`time_to` time default '00:00:00',
	`monday` tinyint  default 1,
	`tuesday` tinyint  default 1,
	`wednesday` tinyint  default 1,
	`thursday` tinyint  default 1,
	`friday` tinyint  default 1,
	`saturday` tinyint  default 1,
	`sunday` tinyint  default 1,
	`only_display_wrong` tinyint (1) unsigned default 0 not null,
	`top_n` INT NOT NULL default 0,
	`top_n_value` INT NOT NULL default 10,
	`exception_condition` INT NOT NULL default 0,
	`exception_condition_value` DOUBLE (18,6) NOT NULL default 0,
	`show_resume` INT NOT NULL default 0,
	`order_uptodown` INT NOT NULL default 0,
	`show_graph` INT NOT NULL default 0,
	`group_by_agent` INT NOT NULL default 0,
	`style` TEXT NOT NULL,
	`id_group` INT (10) unsigned NOT NULL DEFAULT 0,
	`id_module_group` INT (10) unsigned NOT NULL DEFAULT 0,
	`server_name` text,
	`exact_match` tinyint  default 0,
	`module_names` TEXT,
	`module_free_text` TEXT,
	`each_agent` tinyint  default 1,
	`historical_db` tinyint  UNSIGNED NOT NULL default 0,
	`lapse_calc` tinyint  UNSIGNED NOT NULL default '0',
	`lapse` int UNSIGNED NOT NULL default '300',
	`visual_format` tinyint  UNSIGNED NOT NULL default '0',
	`hide_no_data` tinyint  default 0,
	`total_time` tinyint  DEFAULT '1',
	`time_failed` tinyint  DEFAULT '1',
	`time_in_ok_status` tinyint  DEFAULT '1',
	`time_in_unknown_status` tinyint  DEFAULT '1',
	`time_of_not_initialized_module` tinyint  DEFAULT '1',
	`time_of_downtime` tinyint  DEFAULT '1',
	`total_checks` tinyint  DEFAULT '1',
	`checks_failed` tinyint  DEFAULT '1',
	`checks_in_ok_status` tinyint  DEFAULT '1',
	`unknown_checks` tinyint  DEFAULT '1',
	`agent_max_value` tinyint  DEFAULT '1',
	`agent_min_value` tinyint  DEFAULT '1',
	`current_month` tinyint  DEFAULT '1',
	`failover_mode` tinyint  DEFAULT '1',
	`failover_type` tinyint  DEFAULT '1',
	`uncompressed_module` TINYINT DEFAULT '0',
	`landscape` tinyint  UNSIGNED NOT NULL default 0,
	`pagebreak` tinyint  UNSIGNED NOT NULL default 0,
	`compare_work_time` tinyint  UNSIGNED NOT NULL default 0,
	`graph_render` tinyint  UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id_rc`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `treport_content_sla_com_temp` (treport_content_sla_combined_template)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_content_sla_com_temp` (
	`id` INTEGER UNSIGNED NOT NULL auto_increment,
	`id_report_content` INTEGER UNSIGNED NOT NULL,
	`text_agent` text,
	`text_agent_module` text,
	`sla_max` double(18,2) NOT NULL default 0,
	`sla_min` double(18,2) NOT NULL default 0,
	`sla_limit` double(18,2) NOT NULL default 0,
	`server_name` text,
	`exact_match` tinyint  default 0,
	PRIMARY KEY(`id`),
	FOREIGN KEY (`id_report_content`) REFERENCES treport_content_template(`id_rc`)
		ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `treport_content_item_temp` (treport_content_item_template)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treport_content_item_temp` (
	`id` INTEGER UNSIGNED NOT NULL auto_increment, 
	`id_report_content` INTEGER UNSIGNED NOT NULL, 
	`text_agent` text,
	`text_agent_module` text,
	`server_name` text,
	`exact_match` tinyint  default 0,
	`operation` text,	
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tgraph_template`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgraph_template` (
	`id_graph_template` INTEGER UNSIGNED NOT NULL  AUTO_INCREMENT,
	`id_user` TEXT NOT NULL,
	`name` TEXT NOT NULL,
	`description` TEXT NOT NULL,
	`period` int NOT NULL default '0',
	`width` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`height` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`private` tinyint  UNSIGNED NOT NULL default 0,
	`events` tinyint  UNSIGNED NOT NULL default 0,
	`stacked` tinyint  UNSIGNED NOT NULL default 0,
	`id_group` mediumint unsigned NULL default 0,
	PRIMARY KEY(`id_graph_template`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tgraph_source_template`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tgraph_source_template` (
	`id_gs_template` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_template` int NOT NULL default 0,
	`agent` TEXT, 
	`module` TEXT,
	`weight` FLOAT(5,3) NOT NULL DEFAULT 2,
	`exact_match` tinyint  default 0, 
	PRIMARY KEY(`id_gs_template`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tmetaconsole_event`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmetaconsole_event` (
	`id_evento` bigint unsigned NOT NULL auto_increment,
	`id_source_event` bigint unsigned NOT NULL,
	`id_agente` int NOT NULL default '0',
	`agent_name` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`id_usuario` varchar(100) NOT NULL default '0',
	`id_grupo` mediumint NOT NULL default '0',
	`group_name` varchar(100) NOT NULL default '',
	`estado` tinyint  unsigned NOT NULL default '0',
	`timestamp` datetime NOT NULL default '1970-01-01 00:00:00',
	`evento` text NOT NULL,
	`utimestamp` bigint NOT NULL default '0',
	`event_type` enum('going_unknown','unknown','alert_fired','alert_recovered','alert_ceased','alert_manual_validation','recon_host_detected','system','error','new_agent','going_up_warning','going_up_critical','going_down_warning','going_down_normal','going_down_critical','going_up_normal', 'configuration_change') default 'unknown',
	`id_agentmodule` int NOT NULL default '0',
	`module_name` varchar(600) NOT NULL,
	`id_alert_am` int NOT NULL default '0',
	`alert_template_name` text,
	`criticity` int unsigned NOT NULL default '0',
	`user_comment` text NOT NULL,
	`tags` text NOT NULL,
	`source` tinytext NOT NULL,
	`id_extra` tinytext NOT NULL,
	`critical_instructions` text NOT NULL default '',
	`warning_instructions` text NOT NULL default '',
	`unknown_instructions` text NOT NULL default '',
	`owner_user` VARCHAR(100) NOT NULL DEFAULT '',
	`ack_utimestamp` bigint NOT NULL DEFAULT '0',
	`server_id` int NOT NULL,
	`custom_data` TEXT NOT NULL DEFAULT '',
	`data` double(22,5) default NULL,
	`module_status` int NOT NULL default '0',
	PRIMARY KEY  (`id_evento`),
	KEY `idx_agente` (`id_agente`),
	KEY `idx_agentmodule` (`id_agentmodule`),
	KEY `server_id` (`server_id`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
-- Criticity: 0 - Maintance (grey)
-- Criticity: 1 - Informational (blue)
-- Criticity: 2 - Normal (green) (status 0)
-- Criticity: 3 - Warning (yellow) (status 2)
-- Criticity: 4 - Critical (red) (status 1)
-- Criticity: 5 - Minor
-- Criticity: 6 - Major

ALTER TABLE tmetaconsole_event ADD INDEX `tme_timestamp_idx` (`timestamp`);
ALTER TABLE tmetaconsole_event ADD INDEX `tme_module_status_idx` (`module_status`);
ALTER TABLE tmetaconsole_event ADD INDEX `tme_criticity_idx` (`criticity`);
ALTER TABLE tmetaconsole_event ADD INDEX `tme_agent_name_idx` (`agent_name`);

-- ---------------------------------------------------------------------
-- Table `tmetaconsole_event_history`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmetaconsole_event_history` (
	`id_evento` bigint unsigned NOT NULL auto_increment,
	`id_source_event` bigint unsigned NOT NULL,
	`id_agente` int NOT NULL default '0',
	`agent_name` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`id_usuario` varchar(100) NOT NULL default '0',
	`id_grupo` mediumint NOT NULL default '0',
	`group_name` varchar(100) NOT NULL default '',
	`estado` tinyint  unsigned NOT NULL default '0',
	`timestamp` datetime NOT NULL default '1970-01-01 00:00:00',
	`evento` text NOT NULL,
	`utimestamp` bigint NOT NULL default '0',
	`event_type` enum('going_unknown','unknown','alert_fired','alert_recovered','alert_ceased','alert_manual_validation','recon_host_detected','system','error','new_agent','going_up_warning','going_up_critical','going_down_warning','going_down_normal','going_down_critical','going_up_normal', 'configuration_change') default 'unknown',
	`id_agentmodule` int NOT NULL default '0',
	`module_name` varchar(600) NOT NULL,
	`id_alert_am` int NOT NULL default '0',
	`alert_template_name` text,
	`criticity` int unsigned NOT NULL default '0',
	`user_comment` text NOT NULL,
	`tags` text NOT NULL,
	`source` tinytext NOT NULL,
	`id_extra` tinytext NOT NULL,
	`critical_instructions` text NOT NULL default '',
	`warning_instructions` text NOT NULL default '',
	`unknown_instructions` text NOT NULL default '',
	`owner_user` VARCHAR(100) NOT NULL DEFAULT '',
	`ack_utimestamp` bigint NOT NULL DEFAULT '0',
	`server_id` int NOT NULL,
	`custom_data` TEXT NOT NULL DEFAULT '',
	`data` double(22,5) default NULL,
	`module_status` int NOT NULL default '0',
	PRIMARY KEY  (`id_evento`),
	KEY `idx_agente` (`id_agente`),
	KEY `idx_agentmodule` (`id_agentmodule`),
	KEY `idx_utimestamp` USING BTREE (`utimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
-- Criticity: 0 - Maintance (grey)
-- Criticity: 1 - Informational (blue)
-- Criticity: 2 - Normal (green) (status 0)
-- Criticity: 3 - Warning (yellow) (status 2)
-- Criticity: 4 - Critical (red) (status 1)
-- Criticity: 5 - Minor
-- Criticity: 6 - Major

ALTER TABLE tmetaconsole_event_history ADD INDEX `tmeh_estado_idx` (`estado`);
ALTER TABLE tmetaconsole_event_history ADD INDEX `tmeh_timestamp_idx` (`timestamp`);

-- ---------------------------------------------------------------------
-- Table `textension_translate_string`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `textension_translate_string` (
	`id` int unsigned NOT NULL auto_increment,
	`lang` VARCHAR(10) NOT NULL ,
	`string` TEXT NOT NULL DEFAULT '' ,
	`translation` TEXT NOT NULL DEFAULT '',
	PRIMARY KEY (`id`),
	KEY `lang_index` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagent_module_log`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagent_module_log` (
	`id_agent_module_log` int NOT NULL AUTO_INCREMENT,
	`id_agent` int unsigned NOT NULL,
	`source` text NOT NULL,
	`timestamp` datetime DEFAULT '1970-01-01 00:00:00',
	`utimestamp` bigint DEFAULT '0',
	PRIMARY KEY (`id_agent_module_log`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tevent_custom_field`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tevent_custom_field` (
	`id_group` mediumint unsigned NOT NULL,
	`value` text NOT NULL,
	PRIMARY KEY  (`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tmetaconsole_agent`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmetaconsole_agent` (
	`id_agente` int unsigned NOT NULL auto_increment,
	`id_tagente` int unsigned NOT NULL,
	`id_tmetaconsole_setup` int NOT NULL,
	`nombre` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`direccion` varchar(100) default NULL,
	`comentarios` varchar(255) default '',
	`id_grupo` int unsigned NOT NULL default '0',
	`ultimo_contacto` datetime NOT NULL default '1970-01-01 00:00:00',
	`modo` tinyint  NOT NULL default '0',
	`intervalo` int unsigned NOT NULL default '300',
	`id_os` int unsigned default '0',
	`os_version` varchar(100) default '',
	`agent_version` varchar(100) default '',
	`ultimo_contacto_remoto` datetime default '1970-01-01 00:00:00',
	`disabled` tinyint  NOT NULL default '0',
	`remote` tinyint  NOT NULL default '0',
	`id_parent` int unsigned default '0',
	`custom_id` varchar(255) default '',
	`server_name` varchar(100) default '',
	`cascade_protection` tinyint  NOT NULL default '0',
	`cascade_protection_module` int unsigned default '0',
	`timezone_offset` tinyint  NULL DEFAULT '0' COMMENT 'number of hours of diference with the server timezone' ,
	`icon_path` VARCHAR(127) NULL DEFAULT NULL COMMENT 'path in the server to the image of the icon representing the agent' ,
	`update_gis_data` tinyint  NOT NULL DEFAULT '1' COMMENT 'set it to one to update the position data (altitude, longitude, latitude) when getting information from the agent or to 0 to keep the last value and do not update it' ,
	`url_address` mediumtext NULL,
	`quiet` tinyint  NOT NULL default '0',
	`normal_count` bigint NOT NULL default '0',
	`warning_count` bigint NOT NULL default '0',
	`critical_count` bigint NOT NULL default '0',
	`unknown_count` bigint NOT NULL default '0',
	`notinit_count` bigint NOT NULL default '0',
	`total_count` bigint NOT NULL default '0',
	`fired_count` bigint NOT NULL default '0',
	`update_module_count` tinyint  NOT NULL default '0',
	`update_alert_count` tinyint  NOT NULL default '0',
	`update_secondary_groups` tinyint  NOT NULL default '0',
	`transactional_agent` tinyint  NOT NULL default '0',
	`alias` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`alias_as_name` tinyint  NOT NULL default '0',
	`safe_mode_module` int unsigned NOT NULL default '0',
	`cps` int NOT NULL default 0,
	PRIMARY KEY  (`id_agente`),
	KEY `nombre` (`nombre`(255)),
	KEY `direccion` (`direccion`),
	KEY `id_tagente_idx` (`id_tagente`),
	KEY `disabled` (`disabled`),
	KEY `id_grupo` (`id_grupo`),
	FOREIGN KEY (`id_tmetaconsole_setup`) REFERENCES tmetaconsole_setup(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8MB4;

ALTER TABLE tmetaconsole_agent ADD INDEX `tma_id_os_idx` (`id_os`);
ALTER TABLE tmetaconsole_agent ADD INDEX `tma_server_name_idx` (`server_name`);

-- ---------------------------------------------------------------------
-- Table `ttransaction`
-- ---------------------------------------------------------------------
create table IF NOT EXISTS `ttransaction` (
    `transaction_id` int unsigned NOT NULL auto_increment,
    `agent_id` int unsigned NOT NULL,
    `group_id` int unsigned NOT NULL default '0',
    `description` text,
    `name` varchar(250) NOT NULL,
    `loop_interval` int unsigned NOT NULL default 40,
    `ready` int unsigned NOT NULL default 0,
    `running` int unsigned NOT NULL default 0,
    PRIMARY KEY (`transaction_id`)
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tphase`
-- ---------------------------------------------------------------------
create table IF NOT EXISTS `tphase`(
    `phase_id` int unsigned not null auto_increment,
    `transaction_id` int unsigned not null,
    `agent_id` int unsigned not null,
    `name` varchar(250) not null,
    `idx` int unsigned not null,
    `dependencies` text,
    `enables` text,
    `launch` text,
    `retries` int unsigned default null,
    `timeout` int unsigned default null,
    PRIMARY KEY (`phase_id`,`transaction_id`)
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `treset_pass` (
	`id` bigint unsigned NOT NULL auto_increment,
	`id_user` varchar(100) NOT NULL default '',
	`cod_hash` varchar(100) NOT NULL default '',
	`reset_time` int unsigned NOT NULL default 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tcluster`
-- ---------------------------------------------------------------------

create table IF NOT EXISTS `tcluster`(
    `id` int unsigned not null auto_increment,
    `name` tinytext not null default '',
    `cluster_type` enum('AA','AP') not null default 'AA',
		`description` text not null default '',
		`group` int unsigned NOT NULL default '0',
		`id_agent` int unsigned NOT NULL,
		PRIMARY KEY (`id`)
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tcluster_item`
-- ---------------------------------------------------------------------

create table IF NOT EXISTS `tcluster_item`(
		`id` int unsigned not null auto_increment,
    `name` tinytext not null default '',
    `item_type` enum('AA','AP')  not null default 'AA',
		`critical_limit` int unsigned NOT NULL default '0',
		`warning_limit` int unsigned NOT NULL default '0',
		`is_critical` tinyint  unsigned NOT NULL default '0',
		`id_cluster` int unsigned,
		PRIMARY KEY (`id`),
		FOREIGN KEY (`id_cluster`) REFERENCES tcluster(`id`)
			ON DELETE SET NULL ON UPDATE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tcluster_agent`
-- ---------------------------------------------------------------------

create table IF NOT EXISTS `tcluster_agent`(
    `id_cluster` int unsigned not null,
    `id_agent` int unsigned not null,
		PRIMARY KEY (`id_cluster`,`id_agent`),
		FOREIGN KEY (`id_cluster`) REFERENCES tcluster(`id`)
			ON UPDATE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tprovisioning`
-- ---------------------------------------------------------------------
create table IF NOT EXISTS `tprovisioning`(
    `id` int unsigned NOT NULL auto_increment,
    `name` varchar(100) NOT NULL,
	`description` TEXT default '',
	`order` int NOT NULL default 0,
	`config` TEXT default '',
		PRIMARY KEY (`id`)
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tprovisioning_rules`
-- ---------------------------------------------------------------------
create table IF NOT EXISTS `tprovisioning_rules`(
    `id` int unsigned NOT NULL auto_increment,
    `id_provisioning` int unsigned NOT NULL,
	`order` int NOT NULL default 0,
	`operator` enum('AND','OR') default 'OR',
	`type` enum('alias','ip-range') default 'alias',
	`value` varchar(100) NOT NULL default '',
		PRIMARY KEY (`id`),
		FOREIGN KEY (`id_provisioning`) REFERENCES tprovisioning(`id`)
			ON DELETE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tmigration_queue`
-- ---------------------------------------------------------------------

create table IF NOT EXISTS `tmigration_queue`(
    `id` int unsigned not null auto_increment,
    `id_source_agent` int unsigned not null,
    `id_target_agent` int unsigned not null,
    `id_source_node` int unsigned not null,
    `id_target_node` int unsigned not null,
    `priority` int unsigned default 0,
    `step` int default 0,
    `running` tinyint  default 0,
    `active_db_only` tinyint  default 0,
    PRIMARY KEY(`id`)
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tmigration_module_queue`
-- ---------------------------------------------------------------------

create table IF NOT EXISTS `tmigration_module_queue`(
    `id` int unsigned not null auto_increment,
    `id_migration` int unsigned not null,
    `id_source_agentmodule` int unsigned not null,
    `id_target_agentmodule` int unsigned not null,
    `last_replication_timestamp` bigint NOT NULL default 0,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_migration`) REFERENCES tmigration_queue(`id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagent_secondary_group`
-- ---------------------------------------------------------------------

create table IF NOT EXISTS `tagent_secondary_group`(
    `id` int unsigned not null auto_increment,
    `id_agent` int unsigned NOT NULL,
    `id_group` mediumint unsigned NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_agent`) REFERENCES tagente(`id_agente`)
        ON DELETE CASCADE,
	FOREIGN KEY(`id_group`) REFERENCES tgrupo(`id_grupo`)
        ON DELETE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tmetaconsole_agent_secondary_group`
-- ---------------------------------------------------------------------
create table IF NOT EXISTS `tmetaconsole_agent_secondary_group`(
    `id` int unsigned not null auto_increment,
    `id_agent` int unsigned NOT NULL,
    `id_tagente` int unsigned NOT NULL,
    `id_tmetaconsole_setup` int NOT NULL,
    `id_group` mediumint unsigned NOT NULL,
    PRIMARY KEY(`id`),
	KEY `id_tagente` (`id_tagente`),
    FOREIGN KEY(`id_agent`) REFERENCES tmetaconsole_agent(`id_agente`)
        ON DELETE CASCADE,
	FOREIGN KEY(`id_group`) REFERENCES tgrupo(`id_grupo`)
        ON DELETE CASCADE,
	FOREIGN KEY (`id_tmetaconsole_setup`) REFERENCES tmetaconsole_setup(`id`)
		ON DELETE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tautoconfig`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tautoconfig` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tautoconfig_rules`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tautoconfig_rules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_autoconfig` int unsigned NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  `operator` enum('AND','OR') DEFAULT 'OR',
  `type` enum('alias','ip-range','group','os','custom-field','script','server-name') DEFAULT 'alias',
  `value` text,
  `custom` text,
  PRIMARY KEY (`id`),
  KEY `id_autoconfig` (`id_autoconfig`),
  CONSTRAINT `tautoconfig_rules_ibfk_1` FOREIGN KEY (`id_autoconfig`) REFERENCES `tautoconfig` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tautoconfig_actions`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tautoconfig_actions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_autoconfig` int unsigned NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  `action_type` enum('set-group', 'set-secondary-group', 'apply-policy', 'launch-script', 'launch-event', 'launch-alert-action', 'raw-config') DEFAULT 'launch-event',
  `value` text,
  `custom` text,
  PRIMARY KEY (`id`),
  KEY `id_autoconfig` (`id_autoconfig`),
  CONSTRAINT `tautoconfig_action_ibfk_1` FOREIGN KEY (`id_autoconfig`) REFERENCES `tautoconfig` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tlayout_template`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlayout_template` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(600)  NOT NULL,
	`id_group` INTEGER UNSIGNED NOT NULL,
	`background` varchar(200)  NOT NULL,
	`height` INTEGER UNSIGNED NOT NULL default 0,
	`width` INTEGER UNSIGNED NOT NULL default 0,
	`background_color` varchar(50) NOT NULL default '#FFF',
	`is_favourite` INTEGER UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id`)
)  ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tlayout_template_data`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlayout_template_data` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`id_layout_template` INTEGER UNSIGNED NOT NULL,
	`pos_x` INTEGER UNSIGNED NOT NULL default 0,
	`pos_y` INTEGER UNSIGNED NOT NULL default 0,
	`height` INTEGER UNSIGNED NOT NULL default 0,
	`width` INTEGER UNSIGNED NOT NULL default 0,
	`label` TEXT,
	`image` varchar(200) DEFAULT "",
	`type` tinyint  UNSIGNED NOT NULL default 0,
	`period` INTEGER UNSIGNED NOT NULL default 3600,
	`module_name` text NOT NULL,
	`agent_name` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL default '',
	`id_layout_linked` INTEGER unsigned NOT NULL default '0',
	`parent_item` INTEGER UNSIGNED NOT NULL default 0,
	`enable_link` tinyint  UNSIGNED NOT NULL default 1,
	`id_metaconsole` int NOT NULL default 0,
	`id_group` INTEGER UNSIGNED NOT NULL default 0,
	`id_custom_graph` INTEGER UNSIGNED NOT NULL default 0,
	`border_width` INTEGER UNSIGNED NOT NULL default 0,
	`type_graph` varchar(50) NOT NULL default 'area',
	`label_position` varchar(50) NOT NULL default 'down',
	`border_color` varchar(200) DEFAULT "",
	`fill_color` varchar(200) DEFAULT "",
	`show_statistics` tinyint  NOT NULL default '0',
	`linked_layout_node_id` int NOT NULL default 0,
	`linked_layout_status_type` ENUM ('default', 'weight', 'service') DEFAULT 'default',
	`id_layout_linked_weight` int NOT NULL default '0',
	`linked_layout_status_as_service_warning` FLOAT(20, 3) NOT NULL default 0,
	`linked_layout_status_as_service_critical` FLOAT(20, 3) NOT NULL default 0,
	`element_group` int NOT NULL default '0',
	`show_on_top` tinyint  NOT NULL default '0',
	`clock_animation` varchar(60) NOT NULL default "analogic_1",
	`time_format` varchar(60) NOT NULL default "time",
	`timezone` varchar(60) NOT NULL default "Europe/Madrid",
	`show_last_value` tinyint  UNSIGNED NULL default '0',
	`cache_expiration` INTEGER UNSIGNED NOT NULL default 0,
	PRIMARY KEY(`id`),
	FOREIGN KEY (`id_layout_template`) REFERENCES tlayout_template(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tlog_graph_models`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlog_graph_models` (
	`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
	`title` TEXT NOT NULL,
	`regexp` TEXT NOT NULL,
	`fields` TEXT NOT NULL,
	`average` tinyint  NOT NULL default '0',
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagent_custom_fields_filter`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tagent_custom_fields_filter` (
	`id` int unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(600) NOT NULL,
	`id_group` int unsigned default '0',
	`id_custom_field` varchar(600) default '',
	`id_custom_fields_data` varchar(600) default '',
	`id_status` varchar(600) default '',
	`module_search` varchar(600) default '',
	`module_status` varchar(600) default '',
	`recursion` int unsigned default '0',
	`group_search` int unsigned default '0',
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- -----------------------------------------------------
-- Table `tnetwork_matrix`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnetwork_matrix` (
	`id` int unsigned NOT NULL auto_increment,
	`source` varchar(60) default '',
	`destination` varchar(60) default '',
	`utimestamp` bigint default 0,
	`bytes` int unsigned default 0,
	`pkts` int unsigned default 0,
	PRIMARY KEY (`id`),
	UNIQUE (`source`, `destination`, `utimestamp`)
) ENGINE = InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `user_task`
-- ---------------------------------------------------------------------
CREATE TABLE `tuser_task` (
	`id` int unsigned NOT NULL auto_increment,
	`function_name` varchar(80) NOT NULL default '',
	`parameters` text NOT NULL default '',
	`name` varchar(60) NOT NULL default '',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `user_task_scheduled`
-- ---------------------------------------------------------------------
CREATE TABLE `tuser_task_scheduled` (
	`id` int unsigned NOT NULL auto_increment,
	`id_usuario` varchar(60) NOT NULL default '0',
	`id_user_task` int unsigned NOT NULL default '0',
	`args` TEXT NOT NULL,
	`scheduled` enum('no','hourly','daily','weekly','monthly','yearly','custom') default 'no',
	`last_run` int unsigned default '0',
	`custom_data` int NULL default '0',
	`flag_delete` tinyint  UNSIGNED NOT NULL default 0,
	`id_grupo` int unsigned NOT NULL default 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tvisual_console_items_cache`
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `tvisual_console_elements_cache` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `vc_id` INTEGER UNSIGNED NOT NULL,
    `vc_item_id` INTEGER UNSIGNED NOT NULL,
    `user_id` VARCHAR(60) DEFAULT NULL,
    `data` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`expiration` INTEGER UNSIGNED NOT NULL COMMENT 'Seconds to expire',
    PRIMARY KEY(`id`),
    FOREIGN KEY(`vc_id`) REFERENCES `tlayout`(`id`)
        ON DELETE CASCADE,
    FOREIGN KEY(`vc_item_id`) REFERENCES `tlayout_data`(`id`)
        ON DELETE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES `tusuario`(`id_user`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) engine=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ---------------------------------------------------------------------
-- Table `tagent_repository`
-- ---------------------------------------------------------------------
CREATE TABLE `tagent_repository` (
  `id` SERIAL,
  `id_os` int UNSIGNED DEFAULT 0,
  `arch` ENUM('x64', 'x86') DEFAULT 'x64',
  `version` VARCHAR(10) DEFAULT '',
  `path` text,
  `uploaded_by` VARCHAR(100) DEFAULT '',
  `uploaded` bigint NOT NULL DEFAULT 0 COMMENT "When it was uploaded",
  `last_err` text,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_os`) REFERENCES `tconfig_os`(`id_os`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tdeployment_hosts`
-- ----------------------------------------------------------------------
CREATE TABLE `tdeployment_hosts` (
  `id` SERIAL,
  `id_cs` VARCHAR(100),
  `ip` VARCHAR(100) NOT NULL UNIQUE,
  `id_os` int UNSIGNED DEFAULT 0,
  `os_version` VARCHAR(100) DEFAULT '' COMMENT "OS version in STR format",
  `arch` ENUM('x64', 'x86') DEFAULT 'x64',
  `current_agent_version` VARCHAR(100) DEFAULT '' COMMENT "String latest installed agent",
  `target_agent_version_id` BIGINT UNSIGNED,
  `deployed` bigint NOT NULL DEFAULT 0 COMMENT "When it was deployed",
  `server_ip` varchar(100) default NULL COMMENT "Where to point target agent",
  `last_err` text,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_cs`) REFERENCES `tcredential_store`(`identifier`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (`id_os`) REFERENCES `tconfig_os`(`id_os`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (`target_agent_version_id`) REFERENCES  `tagent_repository`(`id`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tremote_command`
-- ----------------------------------------------------------------------
CREATE TABLE `tremote_command` (
  `id` SERIAL,
  `name` varchar(150) NOT NULL,
  `timeout` int unsigned NOT NULL default 30,
  `retries` int unsigned NOT NULL default 3,
  `preconditions` text,
  `script` text,
  `postconditions` text,
  `utimestamp` int unsigned NOT NULL default 0,
  `id_group` int unsigned NOT NULL default 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tremote_command_target`
-- ----------------------------------------------------------------------
CREATE TABLE `tremote_command_target` (
  `id` SERIAL,
  `rcmd_id` bigint unsigned NOT NULL,
  `id_agent` int unsigned NOT NULL,
  `utimestamp` int unsigned NOT NULL default 0,
  `stdout` MEDIUMTEXT,
  `stderr` MEDIUMTEXT,
  `errorlevel` int unsigned NOT NULL default 0,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`rcmd_id`) REFERENCES `tremote_command`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

-- ----------------------------------------------------------------------
-- Table `tnode_relations`
-- ----------------------------------------------------------------------
CREATE TABLE `tnode_relations` (
	`id` int unsigned NOT NULL auto_increment,
    `gateway` VARCHAR(100) NOT NULL,
	`imei` VARCHAR(100) NOT NULL,
	`node_address` VARCHAR(60) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
